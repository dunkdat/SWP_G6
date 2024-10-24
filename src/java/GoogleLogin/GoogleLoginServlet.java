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
public class GoogleLoginServlet extends HttpServlet {
   
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
            String code = request.getParameter("code");
            GoogleLogin gg = new GoogleLogin();
            String acessToken = gg.getToken(code);
            GoogleAccount acc = gg.getUserInfo(acessToken);
            DAOUser u = new DAOUser();
            HttpSession ss = request.getSession();
            if(acc.getName()==null) return;
            if(!u.existedEmail(acc.getEmail())){
                SendVerify s = new SendVerify();
                Encode e = new Encode();
                String pass = e.toSHA1(s.getRandom());
                u.addUser(new User(acc.getName(),null,1 ,null, acc.getEmail(), pass, "Customer"));
                ss.setAttribute("user_email", acc.getEmail());
                request.getRequestDispatcher("homepage").forward(request, response);
            }else{
                User user = u.getUserByEmail(acc.getEmail());
                if(user.getStatus().equals("inactive")){
                    request.setAttribute("message", "Your account no more available!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
                }
                ss.setAttribute("current_user", user);
            switch (user.getRole()) {
                case "Customer":
                    request.getRequestDispatcher("homepage").forward(request, response);
                    break;
                case "Admin":
                    request.getRequestDispatcher("userlist").forward(request, response);
                    break;
                case "Staff":
                    request.getRequestDispatcher("staffproductlist").forward(request, response);
                    break;
                case "Staff Manager":
                    request.getRequestDispatcher("CustomerManager").forward(request, response);
                    break;
                default:
                    break;
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
