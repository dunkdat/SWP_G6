/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vnpay.common;

import dal.DAOOrder;
import java.io.IOException;import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.UUID;
import java.util.Vector;
import model.Order;
import model.Products;
import model.User;

/**
 *
 * @author CTT VNPAY
 */
public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        String bankCode = req.getParameter("bankCode");
        double amountDouble = getAmount(req);
        String reciveAddress = req.getParameter("address");
        String reciveName = req.getParameter("reciveName");
        String recivePhone = req.getParameter("recivePhone");
        String shipId_raw = req.getParameter("shipment");
        System.out.println("amountDouble"+amountDouble);
if(amountDouble == 0) {
 resp.sendRedirect("cart");
          return;
}
        int orderId = getOrderId(req, resp, reciveAddress, reciveName, recivePhone, shipId_raw);
        if(orderId < 1) {
          resp.sendRedirect("cart");
          return;
        }
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        
        long amount = (long) (amountDouble * 24000000);
        String vnp_TxnRef = orderId+"";
        String vnp_IpAddr = Config.getIpAddress(req);

        String vnp_TmnCode = Config.vnp_TmnCode;
        
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        
        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = req.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
        
        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        System.out.println(paymentUrl);
        
         resp.setContentType("application/json");
         resp.setCharacterEncoding("UTF-8");
        String jsonResponse = "{\"redirectUrl\": \"" + paymentUrl + "\"}";
        System.out.println("run here");
       resp.getWriter().write(jsonResponse);
        return;
    }
    
    public double getAmount(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String[] selectedProducts = (String[]) session.getAttribute("listBuy"); // Lấy danh sách ID sản phẩm đã chọn
        Vector<Products> listOrder = new Vector<>();
        double amount = 0;
        if (session.getAttribute("listBuy") != null) {
            // Lọc sản phẩm theo ID được chọn
            for (String productId : selectedProducts) {
                Products pro = (Products) session.getAttribute("cart-" + productId);
                if (pro != null) {
                    amount += pro.getQuantity() * pro.getPrice();
                }
            }
        }
        
        return amount;
    }
    public int getOrderId(HttpServletRequest request, HttpServletResponse response, 
            String reciveAddress, String reciveName, String recivePhone,String shipId_raw)
            throws ServletException, IOException {
            HttpSession session = request.getSession();
            System.out.println("run payment");
            DAOOrder daoOrder = new DAOOrder();
            String[] selectedProducts = (String[]) session.getAttribute("listBuy"); // Lấy danh sách ID sản phẩm đã chọn

            if (shipId_raw != null && selectedProducts != null) {
                System.out.println("run payment1");
                int shipId = Integer.parseInt(shipId_raw);
                Vector<Products> listOrder = new Vector<>();

                // Lọc sản phẩm theo ID được chọn
                for (String productId : selectedProducts) {
                    Products pro = (Products) session.getAttribute("cart-" + productId);
                    if (pro != null) {
                        listOrder.add(pro);
                    }
                }

                User cus = (User) session.getAttribute("current_user");

                if (cus != null && reciveName != null && recivePhone != null
                        && reciveAddress != null && !listOrder.isEmpty()) {
                    System.out.println("run payment2");
                    Order newOrder = new Order(reciveAddress, "Chờ xác nhận",
                            reciveName, recivePhone,
                            cus.getId(), shipId);
                    int orderId = daoOrder.insertOrder(newOrder);
                    System.out.println(orderId);
                    if (orderId > 0) {
                        daoOrder.insertOrderItem(listOrder, orderId);
                        request.setAttribute("mess", "Order success");
                        for (String productId : selectedProducts) {
                            Products proRemove = (Products) session.getAttribute("cart-" + productId);
                            removeSession(request, response, "cart-" + proRemove.getId(), session);
                        }
                        session.removeAttribute("listBuy");
                    }
                   return orderId;
                } 
            }
        return -1;
    }
    public void removeSession(HttpServletRequest request, HttpServletResponse response,
            String startName, HttpSession session)
            throws ServletException {
        Enumeration<String> sessionNames = session.getAttributeNames();
        while (sessionNames.hasMoreElements()) {
            String currSessionName = sessionNames.nextElement();
            if (currSessionName.startsWith(startName)) {
                session.removeAttribute(currSessionName);
            }
        }
    }
}
