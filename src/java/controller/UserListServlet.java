/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import GoogleLogin.SendVerify;
import constant.IConstant;
import dal.DAOUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import model.User;
import util.Encode;
import util.Validate;

/**
 *
 * @author DAT
 */
@MultipartConfig
public class UserListServlet extends HttpServlet {
   
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
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("current_user");
        Encode e = new Encode();
         DAOUser daoUser = new DAOUser();
        if (session != null && currentUser != null) {
            if (!currentUser.getRole().equals("Admin")) {
                response.sendRedirect("access_denied.jsp");
                return; // Exit if the current user is not an admin
            }
            request.setAttribute("userlist", daoUser.getAllSatff());
            String action = request.getParameter("submit");

            if (action != null) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                int gender = Integer.parseInt(request.getParameter("gender"));
                String phone = request.getParameter("phone");
                String role = request.getParameter("role");
                if(action.equals("add")){
                // Gather user inputs from the form
                 // Set default status
                
                Part avatarPart = request.getPart("avatar");
                if(!Validate.isImageFile(avatarPart)){
                    request.setAttribute("message", "Invalid image file");
                    request.getRequestDispatcher("userlist.jsp").forward(request, response);
                    return;
                }
                if(!Validate.isValidEmail(email)){
                    request.setAttribute("message", "Invalid email");
                    request.getRequestDispatcher("userlist.jsp").forward(request, response);
                    return;
                }
                if(daoUser.existedEmail(email)){
                    request.setAttribute("message", "Existed email");
                    request.getRequestDispatcher("userlist.jsp").forward(request, response);
                    return;
                }
                if(!Validate.isValidName(name)){
                    request.setAttribute("message", "Invalid name");
                    request.getRequestDispatcher("userlist.jsp").forward(request, response);
                    return;
                }
                if(!Validate.isValidPhoneNumber(phone)){
                    request.setAttribute("message", "Invalid phone number");
                    request.getRequestDispatcher("userlist.jsp").forward(request, response);
                    return;
                }
                if(daoUser.existedPhone(phone)){
                    request.setAttribute("message", "Existed phone number");
                    request.getRequestDispatcher("userlist.jsp").forward(request, response);
                    return;
                }
                
                String filename = null;
                filename = avatarPart.getSubmittedFileName();
                String folderPath = getServletContext().getRealPath("") + File.separator + IConstant.PATH_USER;
                saveImage(avatarPart, folderPath, filename);
                // Create a User object
                SendVerify uv = new SendVerify();
                User newUser = new User(name, null, gender, phone,email,e.toSHA1(uv.getRandom()), role, filename);
                // Add user to the database using DAOUser
                
                daoUser.addUser(newUser);
                }
            }
                request.setAttribute("userlist", daoUser.getAllSatff());
                request.getRequestDispatcher("userlist.jsp").forward(request, response);
            
        }
    }
    private void saveImage(Part part, String folderPath, String filename) throws IOException {
        File folder = new File(folderPath);
        if (!folder.exists()) {
            folder.mkdirs();
        }
        String filePath = folderPath + File.separator + filename;
        try ( InputStream inputStream = part.getInputStream()) {
            Path path = Paths.get(filePath);
            Files.copy(inputStream, path, StandardCopyOption.REPLACE_EXISTING);
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
