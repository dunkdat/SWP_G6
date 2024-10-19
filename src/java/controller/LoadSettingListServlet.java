/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAOCategory;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;

/**
 *
 * @author DAT
 */
public class LoadSettingListServlet extends HttpServlet {

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
            out.println("<title>Servlet LoadSettingListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadSettingListServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        String status = request.getParameter("status");
        String query = request.getParameter("query");
        int categoriesPerPage = 10; // Số lượng category mỗi trang
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy danh sách category từ DAO (hoặc database)
        DAOCategory categoryDAO = new DAOCategory();
        int totalCategories = categoryDAO.countAllCategories(status,query); // Tổng số category
        int totalPages = (int) Math.ceil((double) totalCategories / categoriesPerPage);

        List<Category> categoryList = categoryDAO.getAllCategoryQuantities(status,query,(page - 1) * categoriesPerPage, categoriesPerPage);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Bắt đầu tạo bảng category
        out.println("<table id='categoryTable'>");
        out.println("<thead>");
        out.println("<tr>");
        out.println("<th>Category ID</th>");
        out.println("<th>Details</th>");
        out.println("<th>Inventory</th>");
        out.println("<th>Status</th>");
        out.println("<th>Actions</th>");
        out.println("</tr>");
        out.println("</thead>");
        out.println("<tbody id='categoryTableBody'>");

        for (Category category : categoryList) {
            out.println("<tr>");
            out.println("<td>" + category.getId() + "</td>");
            out.println("<td>" + category.getDetails() + "</td>");
            out.println("<td>" + category.getInventory() + "</td>");
            out.println("<td style='color:" + (category.getStatus().equals("inactive") ? "red" : "green") + "'>"
                    + (category.getStatus().equals("active") ? "Active" : "Inactive") + "</td>");
            out.println("<td>");
            out.println("<button onclick=\"editCategory('" + category.getId() + "', '" + category.getDetails() + "','" + category.getInventory() + "', '" + category.getStatus() + "')\">Details</button>");
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
