/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAOCategory;
import dal.DAONews;
import dal.DAOProduct;
import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Products;

/**
 *
 * @author DAT
 */
public class HomePageServlet extends HttpServlet {
   
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
    SliderDAO sliderDAO = new SliderDAO();
    DAONews newsDAO = new DAONews();
    DAOProduct productDAO = new DAOProduct();
        DAOCategory c = new DAOCategory();
        

    // Lấy số trang hiện tại
    String pageParam = request.getParameter("page");
    int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;
    int pageSize = 12; // Số sản phẩm trên mỗi trang
    int offset = (currentPage - 1) * pageSize;

    // Lấy tổng số sản phẩm và tính tổng số trang
    int totalProducts = productDAO.getTotalProducts();
    int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

    // Lấy danh sách sản phẩm cho trang hiện tại
    List<Products> productList = productDAO.getProductsByPage(offset, pageSize);

    // Đặt các thuộc tính cho request
    request.setAttribute("bloglist", newsDAO.getAllNews());
    request.setAttribute("slider", sliderDAO.getAllSlider());
    request.setAttribute("productlist", productList);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("categoryList", c.getAllCategory());

    request.getRequestDispatcher("homepage.jsp").forward(request, response);
            
            
        
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
        processRequest(request, response);
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
