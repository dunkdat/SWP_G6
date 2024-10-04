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
public class LoadListProductsServlet extends HttpServlet {
   
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
            out.println("<title>Servlet LoadListProductsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadListProductsServlet at " + request.getContextPath () + "</h1>");
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
    try {
        // Get parameters
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String price = request.getParameter("price");
        String query = request.getParameter("query");
        String lowPrice = null;
        String highPrice = null;

        if (price != null) {
            String[] prices = price.split("-");
            if (prices.length == 2) {
                lowPrice = prices[0];
                highPrice = prices[1];
            }
        }

        // Pagination logic
        String pageParam = request.getParameter("page");
        int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
        int pageSize = 12;
        int offset = (page - 1) * pageSize;
        
        // Fetch the filtered products
        DAOProduct productDAO = new DAOProduct();
        // Tính tổng số sản phẩm sau khi áp dụng bộ lọc
        int totalProducts = productDAO.getTotalFilteredProducts(category, brand, lowPrice, highPrice, query);

        // Tính tổng số trang dựa trên số sản phẩm đã lọc
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        List<Products> productList = productDAO.getAllProduct(category, brand, lowPrice, highPrice,query, pageSize, offset);

        // Render the products
        PrintWriter out = response.getWriter();
        out.println("<section class='products'>");
        for (Products product : productList) {
            out.println("<div class='product'>");
            out.println("<img src='" + product.getLink_picture() + "' alt='" + product.getName() + "'>");
            out.println("<h2>" + product.getName() + "</h2>");
            out.println("<p>" + product.getPrice() + "</p>");
            out.println("<a href='productdetails?id=" + product.getId() + "' class='view-details-btn'>View Details</a>");
            out.println("</div>");
        }
        out.println("</section>");
        out.println("<div class='pagination'>");
        for (int i = 1; i <= totalPages; i++) {
            if (i == page) {
                out.println("<a href='#' class='active' data-page='" + i + "'>" + i + "</a>");
            } else {
                out.println("<a href='#' data-page='" + i + "'>" + i + "</a>");
            }
        }
        out.println("</div>");
        out.close();
    } catch (Exception e) {
        e.printStackTrace(); // Log the error
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing the request.");
    }
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
