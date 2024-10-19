/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAORole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Role;

/**
 *
 * @author DAT
 */
public class LoadRoleListServlet extends HttpServlet {
   
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
            out.println("<title>Servlet LoadRoleListServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadRoleListServlet at " + request.getContextPath () + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        String status = request.getParameter("status"); // Lọc theo trạng thái
        String query = request.getParameter("query"); // Lọc theo chi tiết
        int rolesPerPage = 10; // Số lượng vai trò trên mỗi trang
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy danh sách role từ DAO (hoặc database)
        DAORole roleDAO = new DAORole();
        int totalRoles = roleDAO.countAllRoles(status, query); // Tổng số vai trò
        int totalPages = (int) Math.ceil((double) totalRoles / rolesPerPage);

        List<Role> roleList = roleDAO.getAllRoleQuantities(status, query, (page - 1) * rolesPerPage, rolesPerPage);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Bắt đầu tạo bảng role
        out.println("<table id='roleTable'>");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th>Role Name</th>");
        out.println("<th>Details</th>");
        out.println("<th>Employees</th>");
        out.println("<th>Status</th>");
        out.println("<th>Actions</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody id='roleTableBody'>");

        // Hiển thị các vai trò
        for (Role role : roleList) {
            out.println("<tr>");
            out.println("<td>" + role.getId() + "</td>");
            out.println("<td>" + role.getDetails() + "</td>");
            out.println("<td>" + role.getEmployee() + "</td>");
            out.println("<td style='color:" + (role.getStatus().equals("inactive") ? "red" : "green") + "'>"
                    + (role.getStatus().equals("active") ? "Active" : "Inactive") + "</td>");
            out.println("<td>");
            out.println("<button onclick=\"editRole('" + role.getId() + "', '" + role.getDetails() + "', '" + role.getEmployee() + "', '" + role.getStatus() + "')\">Details</button>");
            out.println("</td>");
            out.println("</tr>");
        }

        out.println("</tbody>");
        out.println("</table>");

        // Tạo phân trang
        out.println("<div class='pagination'>");

        // Nút "Prev" (chỉ hiển thị nếu trang hiện tại lớn hơn 1)
        if (page > 1) {
            out.println("<a href='#' class='pagination-link' data-page='" + (page - 1) + "'>&laquo; Prev</a>");
        }

        // Tính toán trang bắt đầu và kết thúc
        int startPage = Math.max(1, page - 2);
        int endPage = Math.min(startPage + 4, totalPages);
        startPage = Math.max(1, endPage - 4);

        // Hiển thị các số trang
        for (int i = startPage; i <= endPage; i++) {
            if (i == page) {
                out.println("<a href='#' class='active'>" + i + "</a>");
            } else {
                out.println("<a href='#' class='pagination-link' data-page='" + i + "'>" + i + "</a>");
            }
        }

        // Nút "Next" (chỉ hiển thị nếu trang hiện tại nhỏ hơn tổng số trang)
        if (page < totalPages) {
            out.println("<a href='#' class='pagination-link' data-page='" + (page + 1) + "'>Next &raquo;</a>");
        }

        out.println("</div>"); // Kết thúc phân trang

        out.close();
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

}
