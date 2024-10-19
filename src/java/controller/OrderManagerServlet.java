/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAOOrder;
import dal.DAOUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.OrderManager;
import javax.swing.*;
import model.User;

/**
 *
 * @author Mr Viet
 */
public class OrderManagerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOOrder dao_order = new DAOOrder();
//        DAOOrder dao_order = new DAOOrder();

        if (request.getParameter("service") != null) {
            List<OrderManager> orders2 = dao_order.getAllOrders();
//            request.setAttribute("isExport", "a");
//            OrderManager.exportToExcel(orders2);
        }

        int page = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 20;

        List<OrderManager> orders = dao_order.getAllOrders(page, pageSize, "", "", "", "", "");

        request.setAttribute("orders", orders);
        request.setAttribute("pageSize", pageSize);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", dao_order.getTotalPages(pageSize, ""));

        request.getRequestDispatcher("orderManager.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOOrder dao = new DAOOrder();
        List<OrderManager> orders = null;
        DAOUser daoU = new DAOUser();
        HttpSession ss = request.getSession();
        User usLogin = (User)ss.getAttribute("current_user");
        if(usLogin == null) {
            response.sendRedirect("login");
            return;
        }
        //only admin or sale can manage
        if(!usLogin.getRole().equals("admin") || !usLogin.getRole().equals("sale")) {
            response.sendRedirect("login");
            return;
        }
        DAOOrder dao_order = new DAOOrder();

        int page = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        String service = request.getParameter("service") != null ? request.getParameter("service") : "";
        int pageSize = request.getParameter("pageSize") != null ? Integer.parseInt(request.getParameter("pageSize")) : 10;
        String que = request.getParameter("que") != null ? request.getParameter("que") : "";

        String querry = request.getParameter("querry") != null ? request.getParameter("querry") : "";
        String querry2 = request.getParameter("querry2") != null ? request.getParameter("querry2") : "";
        String querry3 = request.getParameter("querry3") != null ? request.getParameter("querry3") : "";

        if (request.getParameter("order-sort") != null) {
            querry = request.getParameter("order-sort");
        } else if (request.getParameter("filter") != null) {
            
            System.out.println("que = "+que);
            System.out.println("querry2 = "+querry2);
            
            String date12 = request.getParameter("fromDate");
            String date22 = request.getParameter("toDate");
            if(!date12.isEmpty() && !date22.isEmpty()) {
                  que = " AND o.createAt BETWEEN '" + date12 + "' AND '" + date22 + "'";
                  querry2 = " AND o.createAt BETWEEN '" + date12 + "' AND '" + date22 + "'";
            }
        } else if (service.equals("delete")) {
            
            
            
            dao.deleteOrder(Integer.parseInt(request.getParameter("orderId")));
            System.out.println("đã xóa");
        } else if (service.equals("changeStatus")) {
            dao_order.changeStatus(
                    Integer.parseInt(request.getParameter("orderId")),
                    request.getParameter("newStatus"));
        } else if (service.equals("pagging")) {
            pageSize = Integer.parseInt(request.getParameter("nepp"));
        } else if (service.equals("search")) {
            String inputSearch = request.getParameter("search");
            if (inputSearch.matches("[1-9]\\d*")) {
                int id = Integer.parseInt(inputSearch);
                querry3 = " AND o.id = '" + id + "' ";
            } else {
                querry3 = " AND c.email LIKE '%" + inputSearch + "%' OR c.phone LIKE '%" + inputSearch + "%' ";
            }
        }  
        String statusOrder = "";
        if(request.getParameter("statusOrder") != null) {
            statusOrder = request.getParameter("statusOrder");
        }
        
         String keyword = "";
         String querry4 = "";
        if(request.getParameter("keyword") != null) {
            keyword = request.getParameter("keyword");
            querry4 = "AND CONCAT(c.email, o.phone, o.status, o.address) like '%"+keyword+"%' ";
        }
        orders = dao_order.getAllOrders(page, pageSize, querry, querry2, querry3, statusOrder, querry4);
        System.out.println("ỏders"+ orders );
        request.setAttribute("que", que);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("querry", querry);
        request.setAttribute("querry2", querry2);
        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", dao_order.getTotalPages(pageSize, que));

        System.out.println(request.getParameter("service"));
        request.getRequestDispatcher("orderManager.jsp").forward(request, response);
    }

    public static boolean chiChuaSoNguyen(String str) {
        // Regex để kiểm tra xem chuỗi chỉ chứa các ký tự số nguyên không hay không
        String regex = "\\d+"; // "\\d" đại diện cho các ký tự số, "+" biểu thị cho một hoặc nhiều ký tự số

        // Tạo pattern
        Pattern pattern = Pattern.compile(regex);

        // Tạo matcher
        Matcher matcher = pattern.matcher(str);

        // Kiểm tra xem matcher có khớp hoàn toàn với chuỗi không
        return matcher.matches();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
