/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import GoogleLogin.SendVerify;
import GoogleLogin.SendVerify;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author DAT
 */
public class UserVerify extends HttpServlet {
   
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
           String email = request.getParameter("email");
           
           SendVerify s = new SendVerify();
           String code = s.getRandom();
           String content = "<html>" +
                 "<head><style>" +
                 "body { font-family: Arial, sans-serif; margin: 0; padding: 20px;}" +
                 "h1 { color: #333; text-align: center; }" +
                 "p { font-size: 16px; color: #555; text-align: center; }" +
                 ".container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; background-color: #f9f9f9; text-align: center; }" +
                 ".code { font-size: 36px; font-weight: bold; color: #007bff; margin: 20px 0; }" +
                 "</style></head>" +
                 "<body>" +
                 "<div class='container'>" +
                 "<h1>Hello!</h1>" +
                 "<p>Thank you for registering. Please use the following verification code to complete your registration:</p>" +
                 "<p class='code'>" + code + "</p>" +
                 "<p>If you did not request this code, please ignore this email.</p>" +
                 "</div>" +
                 "</body>" +
                 "</html>";
           boolean test = s.sendEmail(email, content, "Your Verification Code");
           
           if(test){
               HttpSession ss = request.getSession();
               ss.setAttribute("authcode", code);
               request.setAttribute("verify", "true");
               request.setAttribute("email", email);
               request.setAttribute("message", "Registered successfully, please verify your email!");
               request.getRequestDispatcher("verify.jsp").forward(request, response);
           }
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
