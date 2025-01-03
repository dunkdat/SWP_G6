/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package GoogleLogin;

import dal.DAOUser;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.Encode;

/**
 *
 * @author DAT
 */
public class CheckCode extends HttpServlet {
   
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
            HttpSession ss = request.getSession(false);
            String name =(String) ss.getAttribute("name");
        String address =(String) ss.getAttribute("address");
        int gender = (int) ss.getAttribute("gender");
        String phone = (String)ss.getAttribute("phone");
        String email = (String)ss.getAttribute("email");
        String password =(String) ss.getAttribute("password");
            String authcode = (String) ss.getAttribute("authcode");
            String code = request.getParameter("code");
            
            if(code.equals(authcode)){
                request.setAttribute("message", "Verify successfully!");
                DAOUser u = new DAOUser();
                Encode e = new Encode();
                u.addUser(new User(name, address,gender, phone, email, e.toSHA1(password), "Customer"));
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }else{
                request.setAttribute("message", "Wrong verify code!");
                request.setAttribute("email", email);
                request.getRequestDispatcher("verify.jsp").forward(request, response);
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
