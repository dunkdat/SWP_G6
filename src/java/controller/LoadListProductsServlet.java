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
        int totalProducts = productDAO.getTotalFilteredProducts(category, brand, lowPrice, highPrice, query);

        // Calculate total pages based on the number of products
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        List<Products> productList = productDAO.getAllProduct(category, brand, lowPrice, highPrice, query, pageSize, offset);

        // Render the products with JSP-style formatting
        PrintWriter out = response.getWriter();
        if(productList.isEmpty()){
            out.println("<div class='mess'>No product founds</div>");
        }
        
        out.println("<section class='products'>");
        
        // Iterate through products and display product information
        for (Products product : productList) {
            out.println("<a href='productdetails?id=" + product.getId() + "'>");
            out.println("<div class='product'>");

            // Display product image
            out.println("<img src='" + product.getLink_picture() + "' alt='" + product.getName() + "'>");

            // Display sale badge if salePercent > 0
            if (product.getSalePercent() > 0) {
                out.println("<div class='sale-badge'>-" + product.getSalePercent() + "%</div>");
            }

            // Display product name
            out.println("<h2>" + product.getName() + "</h2>");

            // Display price (original and sale if applicable)
            if (product.getSalePercent() > 0) {
                out.println("<div class='price-container'>");
                out.println("<p class='original-price'>$" + String.format("%.2f", product.getPrice() + product.getPrice() * product.getSalePercent() / 100)  + "</p>");
                double discountedPrice = product.getPrice();
                out.println("<p class='sale-price'>$" + String.format("%.2f", discountedPrice) + "</p>");
                out.println("</div>");
            } else {
                out.println("<p class='sale-price'>$" + product.getPrice() + "</p>");
            }

            // Fetch and display star rating
            float averageRating = productDAO.getAverageStarRating(product.getName());
            out.println("<div class='product-rating'>");
if(averageRating !=0){
            for (int i = 1; i <= 5; i++) {
                if (i <= averageRating) {
                    out.println("<span class='star filled'>⭐</span>");
                } else {
                    out.println("<span class='star empty'>⭐</span>");
                }
            }
            
                out.println("<span class='rating-value'>(" + averageRating + ")</span>");
            }
            
            out.println("</div>");

            // View details link
           

            out.println("</div>"); // Close product div 
            out.println("</a>");
        }

        out.println("</section>");

        // Render pagination
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
