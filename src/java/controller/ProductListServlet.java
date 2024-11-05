/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.DAOCategory;
import dal.DAOProduct;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import model.Products;
/**
 *
 * @author Lenovo
 */
public class ProductListServlet extends HttpServlet {
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
            String cat = request.getParameter("category");
            String sub = request.getParameter("submit");
            String brand = request.getParameter("brand");
            String price = request.getParameter("price");

                String lowPrice = null;
                String highPrice = null;
                if (sub != null) {

                    if (price != null) {
                        String[] prices = price.split("-");
                        lowPrice = prices[0];
                        highPrice = prices[1];
                    }

                }
                DAOProduct d = new DAOProduct();
                DAOCategory c = new DAOCategory();
                String pageParam = request.getParameter("page");
                int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;
                int pageSize = 12; // Số sản phẩm trên mỗi trang
                int offset = (currentPage - 1) * pageSize;

                // Lấy tổng số sản phẩm và tính tổng số trang
                int totalProducts = d.getTotalProducts(cat);
                int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                List<Products> t = d.getAllProduct(cat, brand, lowPrice, highPrice,null, pageSize, offset);
                
                if (t.size() == 0) {
                    request.setAttribute("message", "No product found!");
                    request.setAttribute("categoryList", c.getAllCategory());
                    request.getRequestDispatcher("productlist.jsp").forward(request, response);
                } else {
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("productlist", t);
                    request.setAttribute("categoryList", c.getAllCategory());
                     Map<String, Float> averageRatings = d.getAllAverageStarRatings();

        // Set the average ratings in the request scope
        request.setAttribute("averageRatings", averageRatings);
                    request.getRequestDispatcher("productlist.jsp").forward(request, response);
                    return;
                }
            
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
        processRequest(request, response);
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
