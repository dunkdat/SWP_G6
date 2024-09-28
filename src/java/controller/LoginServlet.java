package controller;

import dal.DAOUser;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.Encode;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember"); // Get the 'Remember Me' checkbox value
        
        DAOUser u = new DAOUser();
        Encode e = new Encode();
        
        if(email != null && password != null){
            // Validate user credentials
            User currentUser = u.ValidateUsers(email, password);
            
            if(currentUser != null){
                HttpSession ss = request.getSession();
                ss.setAttribute("current_user", currentUser);
                
                // Handle Remember Me functionality
                if("on".equals(remember)) { 
                    // Create cookies for email and password
                    Cookie emailCookie = new Cookie("email", email);
                    Cookie passwordCookie = new Cookie("password", password);
                    
                    // Set cookies to expire in 7 days (604800 seconds)
                    emailCookie.setMaxAge(7 * 24 * 60 * 60); 
                    passwordCookie.setMaxAge(7 * 24 * 60 * 60); 
                    
                    // Add cookies to the response
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                }
                if(!currentUser.getRole().equals("Admin")){
                    request.getRequestDispatcher("homepage").forward(request, response);
                }else if(currentUser.getRole().equals("Admin")){
                    request.getRequestDispatcher("userlist").forward(request, response);
                }
                
            } else {
                request.setAttribute("message", "Wrong email or password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Check for Remember Me cookies
        Cookie[] cookies = request.getCookies();
        String email = null;
        String password = null;
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("email".equals(cookie.getName())) {
                    email = cookie.getValue();
                } else if ("password".equals(cookie.getName())) {
                    password = cookie.getValue();
                }
            }
        }
        
        // If cookies are found, prefill the login form
        if (email != null && password != null) {
            request.setAttribute("email", email);
            request.setAttribute("password", password);
        }
        
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
}
