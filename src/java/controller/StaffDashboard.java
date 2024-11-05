/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAODashboard;
import dal.DAOOrder;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Order;
import model.User;

/**
 *
 * @author Lenovo
 */
public class StaffDashboard extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet StaffDashboard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffDashboard at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        if(session.getAttribute("current_user") == null) {
         response.sendRedirect("login");
         return;
        }
        User user = (User)session.getAttribute("current_user");
        
        if(!user.getRole().equals("sale") && !user.getRole().equals("maketing")) {
            response.sendRedirect("login");
            return;
        }
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String status = request.getParameter("status");
        if(status == null) {
            status = "all";
        }
        LocalDateTime end = LocalDateTime.now();
        LocalDateTime start = end.minusDays(12);
        if(startDate != null) {
            LocalDate localDateStart = LocalDate.parse(startDate); 
            start = localDateStart.atStartOfDay(); 
        }
        if(endDate != null) {
           LocalDate localDateEnd = LocalDate.parse(endDate); 
            end = localDateEnd.atStartOfDay();
        }
        
        request.setAttribute("startDate", start.toLocalDate());
        request.setAttribute("endDate", end.toLocalDate());
        DAODashboard dao = new DAODashboard();
    
        
        List<Order> orders = dao.getAllOrder(convertDate(start), convertDate(end));
        List<Order> orderRequire = new ArrayList<>();
        int totalOrder = orders.size();
        int succOrder = 0;
        int fail = 0;
        int process = 0;
        int require = 0;
        for (Order order : orders) {
            if(order.getStatus().equals("Đã giao")) {
                succOrder++;
            } else if(order.getStatus().equals("Đã hủy")) {
                fail++;
            } else {
                 process++;
            }
            if(status != null && !status.equals("all") && status.equals(order.getStatus())) {
                require++;
                orderRequire.add(order);
            }
        }
        request.setAttribute("require", require);
        request.setAttribute("orderRequire", orderRequire);
        if(status.equals("all")) {
            status = null;
        }
        request.setAttribute("status", status);
        request.setAttribute("orders", orders);
        request.setAttribute("totalOrder", totalOrder);
        request.setAttribute("succOrder", succOrder);
        request.setAttribute("fail", fail);
        request.setAttribute("process", process);
        request.getRequestDispatcher("StaffDashboard.jsp").forward(request, response);
    } 
public String convertDate(LocalDateTime myDateObj) {
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
        String formattedDate = myDateObj.format(myFormatObj);  
        return formattedDate;
    }
    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    public static void main(String[] args) {
       LocalDateTime end = LocalDateTime.now();
        LocalDateTime start = end.minusDays(7);
      
        DAODashboard dao = new DAODashboard();
        
        List<Order> orders = dao.getAllOrder(convertDates(start), convertDates(end));
       
        System.out.println(orders);
        
    }
    
    public static String convertDates(LocalDateTime myDateObj) {
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
        String formattedDate = myDateObj.format(myFormatObj);  
        return formattedDate;
    }
}
