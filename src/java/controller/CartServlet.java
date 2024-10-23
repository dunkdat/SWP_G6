/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAOOrder;
import dal.DAOProduct;
import dal.DAOShipment;
import dal.DAOUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.Products;
import model.User;

/**
 *
 * @author Lenovo
 */
public class CartServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        //gia su user 1 login
        DAOUser daoU = new DAOUser();
        DAOProduct daoPro = new DAOProduct();
        HttpSession session = request.getSession();
         User acc = (User)session.getAttribute("current_user");
        if(acc == null) {
            response.sendRedirect("login");
            return;
        }
        String messAfterOrder = request.getParameter("mess");
        String service = request.getParameter("Service");
        if (messAfterOrder != null) {
            request.setAttribute("mess", messAfterOrder);
        }
        if (service == null) {
            getShipper(request, response);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } else if (service.equals("changeQuantity")) {
            System.out.println("runhere");
            String pid = request.getParameter("pid");
            String action = request.getParameter("action");
            String key = "cart-" + pid;
            Products pExist = (Products) session.getAttribute(key);
            Products pro = daoPro.getProductById(pid);
            int quantityResult = 0;
            if (action.equals("add")) {
                //add
                if ((pExist.getQuantity() + 1) > pro.getQuantity()) {
                    request.setAttribute("messErr", "Have max quantity");
                    quantityResult = pro.getQuantity();
                } else {
                    quantityResult = pExist.getQuantity() + 1;
                }
            } else {
                //minus
                if ((pExist.getQuantity() - 1) > pro.getQuantity()) {
                    quantityResult = pro.getQuantity();
                } else if ((pExist.getQuantity() - 1) <= 0) {
                    quantityResult = 1;
                    request.setAttribute("messErr", "Have min order");
                } else {
                    quantityResult = pExist.getQuantity() - 1;
                }
            }
            Products pAdd = new Products(pid, pro.getName(),
                    pro.getCategory(), pro.getBrand(),
                    pro.getPrice(), pro.getColor(), pro.getSize(),
                    quantityResult, pro.getLink_picture());

            session.setAttribute(key, pAdd);
            updateCount(session);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        } else if (service.equals("removeOrder")) {
            String proId = request.getParameter("pid");
            String key = "cart-" + proId;
            response.getWriter().write("removeSuccess");
            session.removeAttribute(key);
            updateCount(session);
            request.setAttribute("messSuss", "Remove success");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }

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

    public void updateCount(HttpSession session) {
        int numOrder = 0;
        java.util.Enumeration em = session.getAttributeNames();
        while (em.hasMoreElements()) {
            String id = em.nextElement().toString();
            if (id.startsWith("cart")) {
                numOrder++;
            }
        }
        session.setAttribute("numberOrder", numOrder);
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
        DAOProduct daoPro = new DAOProduct();
        HttpSession session = request.getSession();
         User acc = (User)session.getAttribute("current_user");
        if(acc == null) {
            response.sendRedirect("login");
            return;
        }
        String service = request.getParameter("Service");
        System.out.println("runhere0");
        getShipper(request, response);
        if (service == null) {
            System.out.println("runhere1");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }
        if (service.equals("addToCart")) {
            String quantity = request.getParameter("quantity");
            //test de phong
            
            int quantityAdd = Integer.parseInt(quantity);
            String name = request.getParameter("name");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String action = request.getParameter("action");
            Products pro = daoPro.getProductByNameColorSize(name, color, size);
            String key = "cart-" + pro.getId();

            Products pExist = (Products) session.getAttribute(key);

            int quantityResult = 0;
            if (pExist == null) {
                quantityResult = quantityAdd;
            } else {
                if ((pExist.getQuantity() + quantityAdd) > pro.getQuantity()) {
                    quantityResult = pro.getQuantity();
                    request.setAttribute("messErr", "Have max quantity");
                } else {
                    quantityResult = pExist.getQuantity() + quantityAdd;
                }
            }
            Products pAdd = new Products(pro.getId(), pro.getName(),
                    pro.getCategory(), pro.getBrand(),
                    pro.getPrice(), color, pro.getSize(),
                    quantityResult, pro.getLink_picture());
            session.setAttribute(key, pAdd);
            updateCount(session);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }

        if (service.equals("payment")) {
            System.out.println("run payment");
            DAOOrder daoOrder = new DAOOrder();
            String shipId_raw = request.getParameter("shipment");
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

                String reciveAddress = request.getParameter("address");

                User cus = (User) session.getAttribute("current_user");
                String reciveName = request.getParameter("reciveName");
                String recivePhone = request.getParameter("recivePhone");

                System.out.println("list: " + listOrder);

                System.out.println("cus" + cus + "reciveName" + reciveName + "recivePhone" + recivePhone + "reciveAddress" + reciveAddress);

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
                        response.sendRedirect("cart");
                        return;
                    }
                } else {
                    response.sendRedirect("cart");
                    return;
                }
            }
        }

    }

    public void getShipper(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOShipment daoShip = new DAOShipment();
        request.setAttribute("shipments", daoShip.getAllShipper());
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

    public static void main(String[] args) {
        DAOUser daoU = new DAOUser();
        DAOProduct daoPro = new DAOProduct();
        User cuTest = daoU.getUserById(2);
        System.out.println(cuTest);
    }
}