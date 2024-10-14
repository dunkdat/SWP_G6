/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAOProduct;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Products;

/**
 *
 * @author DAT
 */
public class LoadOnSaleProductsServlet extends HttpServlet {
   
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
            out.println("<title>Servlet LoadOnSaleProductsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadOnSaleProductsServlet at " + request.getContextPath () + "</h1>");
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
    int productsPerPage = 10;
    String category = request.getParameter("category");
    String query = request.getParameter("query");

    // Get the page parameter from the request
    if (request.getParameter("page") != null) {
        page = Integer.parseInt(request.getParameter("page"));
    }

    DAOProduct productDAO = new DAOProduct();

    // Retrieve total products count to calculate total pages
    int totalProducts = productDAO.getTotalFilteredProducts(category, null, null, null, query);
    int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

    // Fetch the products for the current page
    List<Products> products = productDAO.getAllProduct(category, null, null, null, query, productsPerPage, (page-1)*productsPerPage);

    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    // Start generating the products section HTML
    out.println("<div class='products-section'>");
    out.println("    <table id='productTable'>");
    out.println("        <thead>");
    out.println("            <tr>");
    out.println("                <th>ID</th>");
    out.println("                <th>Thumbnail</th>");
    out.println("                <th>Product Name</th>");
    out.println("                <th>Category</th>");
    out.println("                <th>Brand</th>");
    out.println("                <th>Price</th>");
    out.println("                <th>On Sale</th>");
    out.println("                <th>Actions</th>");
    out.println("            </tr>");
    out.println("        </thead>");
    out.println("        <tbody id='productTableBody'>");

    // Generate the product rows
    for (Products product : products) {
        out.println("<tr>");
        out.println("<td>" + product.getId() + "</td>");
        out.println("<td><img src='" + product.getLink_picture() + "' alt='Product Thumbnail' width='50' height='50'></td>");
        out.println("<td>" + product.getName() + "</td>");
        out.println("<td>" + product.getCategory() + "</td>");
        out.println("<td>" + product.getBrand() + "</td>");
        out.println("<td>" + product.getPrice() + "</td>");
        if (product.getSalePercent() > 0) {
        out.println("<td style='color: green;'>" + product.getSalePercent() + "%</td>");
    } else {
        out.println("<td>" + product.getSalePercent() + "%</td>");
    }
         out.println("<td><button class='details-btn' onclick=\"showOnSaleDetails('" + product.getName() + "', '" + product.getLink_picture() + "', " + product.getPrice() + ", " + product.getSalePercent() + ")\">Change</button></td>");
        out.println("</tr>");
    }

    out.println("        </tbody>");
    out.println("    </table>");

    // Generate pagination links
    out.println("<div class='pagination'>");

// Nút "Prev" (chỉ hiển thị nếu trang hiện tại lớn hơn 1)
if (page > 1) {
    out.println("<a href='#' data-page='" + (page - 1) + "'>Prev</a>");
}

// Tính toán trang bắt đầu và kết thúc
int startPage = Math.max(1, page - 2); // Trang bắt đầu, tối thiểu là 1
int endPage = Math.min(startPage + 4, totalPages); // Trang kết thúc, tối đa là 5 trang
startPage = Math.max(1, endPage - 4); // Điều chỉnh lại trang bắt đầu nếu trang kết thúc quá gần cuối

// Hiển thị các liên kết phân trang
for (int i = startPage; i <= endPage; i++) {
    if (i == page) {
        out.println("<a href='#' data-page='" + i + "' class='active'>" + i + "</a>");
    } else {
        out.println("<a href='#' data-page='" + i + "'>" + i + "</a>");
    }
}

// Nút "Next" (chỉ hiển thị nếu trang hiện tại nhỏ hơn tổng số trang)
if (page < totalPages) {
    out.println("<a href='#' data-page='" + (page + 1) + "'>Next</a>");
}

out.println("</div>"); // Kết thúc phần phân trang

    out.println("</div>"); // Closing products-section div

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
