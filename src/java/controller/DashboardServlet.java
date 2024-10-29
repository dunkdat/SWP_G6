/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAOCategory;
import dal.DAOOrder;
import dal.DAOProduct;
import dal.DAOUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
import java.util.Map;

/**
 *
 * @author DAT
 */
public class DashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet DashboardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardServlet at " + request.getContextPath() + "</h1>");
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
        DAOOrder o = new DAOOrder();
        DAOUser u = new DAOUser();
        DAOProduct p = new DAOProduct();
        String role = request.getParameter("role");
        if (role != null) {
            if (role.equals("Admin")) {
                request.setAttribute("successOrders", o.getConfirmOrderCount());
                request.setAttribute("cancelledOrders", o.getCancelOrderCount());
                request.setAttribute("submittedOrders", o.getPendingOrderCount());
                request.setAttribute("totalRevenues", o.getTotalRevenueInLast7Days());
                request.setAttribute("newBoughts", o.getSoldCount());
                request.setAttribute("totalCustomers", u.getTotalCustomer());
                request.setAttribute("totalFeedbacks", p.countAllReviews());
                request.setAttribute("avgFeedbackStarTotal", p.getAverageStarRatingTotal());
                List<String> trendLabels = Arrays.asList("Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7");
                List<Integer> successOrderData = o.getOrderCountInLast7Days();
                List<Integer> allOrderData = o.getSuccessOrderCountInLast7Days();

                request.setAttribute("trendLabels", trendLabels);
                request.setAttribute("successOrderData", successOrderData);
                request.setAttribute("allOrderData", allOrderData);
                request.getRequestDispatcher("admindashboard.jsp").forward(request, response);
                return;
            }
            if(role.equals("Staff")){
                request.setAttribute("inventories", p.getTotalInventory());
                request.setAttribute("goodSold", o.getTotalSoldQuantity());
                List<String> trendLabels = Arrays.asList("Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7");
                List<Integer> successOrderData = o.getOrderCountInLast7Days();
                List<Integer> allOrderData = o.getSuccessOrderCountInLast7Days();
                Map<String, Integer> soldQuantityByCategory = o.getSoldQuantityByCategory();

                request.setAttribute("categoryLabels", new ArrayList<>(soldQuantityByCategory.keySet()));
                request.setAttribute("categoryValues", new ArrayList<>(soldQuantityByCategory.values()));
                request.setAttribute("trendLabels", trendLabels);
                request.setAttribute("successOrderData", successOrderData);
                request.setAttribute("allOrderData", allOrderData);
                request.getRequestDispatcher("staffdashboard.jsp").forward(request, response);
                return;
            }
        }

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
        processRequest(request, response);
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
