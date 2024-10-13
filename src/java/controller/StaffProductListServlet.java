/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAOProduct;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author DAT
 */
@MultipartConfig
public class StaffProductListServlet extends HttpServlet {
   
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
            DAOProduct d = new DAOProduct();
            String submit = request.getParameter("submit");
            
        if(submit!=null){
            String id = request.getParameter("id");
        String linkPicture = request.getParameter("link_picture");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String color = request.getParameter("color");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String details = request.getParameter("details");
        String sizeStr = request.getParameter("size"); // Size có thể là null nếu không phải shoes
        int size = 0;
        double price = Double.parseDouble(request.getParameter("price"));
        if (sizeStr != null && !sizeStr.isEmpty()) {
            size = Integer.parseInt(sizeStr);
        }
            if(submit.equals("add")){
                d.addProduct(id, linkPicture, name, category, brand, color, quantity, details, size, price);
            }
        }
        

            int currentPage =  1;
                int pageSize = 10; // Số sản phẩm trên mỗi trang
                int offset = (currentPage - 1) * pageSize;

                // Lấy tổng số sản phẩm và tính tổng số trang
                int totalProducts = d.getTotalProductsStaff();
                int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                request.setAttribute("currentPage", currentPage);
                    request.setAttribute("totalPages", totalPages);
            request.setAttribute("productlist", d.getAllStaffProducts(offset, pageSize));
            request.getRequestDispatcher("stafflistproduct.jsp").forward(request, response);
        
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
