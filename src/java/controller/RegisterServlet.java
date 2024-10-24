package controller;

import constant.IConstant;
import dal.DAOCategory;
import dal.DAOUser;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.Validate;

/**
 * RegisterServlet handles user registration logic.
 */
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP GET and POST methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession ss = request.getSession();
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String genderStr = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cfpassword = request.getParameter("cfpassword");
        
                
        if (name != null && address != null && genderStr != null && phone != null && email != null && password != null && cfpassword != null) {
            try {
                Validate v = new Validate();
                DAOUser u = new DAOUser();
                DAOCategory c = new DAOCategory();
                request.setAttribute("categoryList", c.getAllCategory());
                // Gender validation
                int gender = Integer.parseInt(genderStr);
                 ss.setAttribute("name", name);
                ss.setAttribute("address", address);
                ss.setAttribute("gender", gender);
                ss.setAttribute("phone", phone);
                ss.setAttribute("email", email);
                ss.setAttribute("password", password);
                ss.setAttribute("cfpassword", cfpassword);
                
                // Validate email format
                if (!Validate.isValidEmail(email)) {
                    request.setAttribute("message", "Please enter a valid email format!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
                if(u.existedEmail(email)){
                    request.setAttribute("message", "Existed email");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
                if(!isValidPassword(password)){
                    request.setAttribute("message", "Password must have at least 8 characters and combine uppercase letters, lowercase letters, numbers and special characters !");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
                // Validate password confirmation
                if (!password.equals(cfpassword)) {
                    request.setAttribute("message", "Passwords do not match!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
                
                // Validate phone number length
                if (!Validate.isValidPhoneNumber(phone)) {
                    request.setAttribute("message", "Please enter a valid 10-digit phone number!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
                
                if(u.existedPhone(phone)){
                    request.setAttribute("message", "Existed phone number");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
                
               
                
                for(User x : u.getAllUser()){
                    if(x.getPhone()==null) continue;
                    if(x.getEmail().equals(email)){
                        request.setAttribute("message", "Email are already existed!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                    }
                    if(x.getPhone().equals(phone)){
                        request.setAttribute("message", "Phone are already existed!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                    }
                }
               
                request.getRequestDispatcher("UserVerify").forward(request, response);
                // If all validations pass, you can proceed with further processing like saving to a database.
                // For now, let's just forward to a success page or back to the registration page
            } catch (NumberFormatException e) {
                // Handle invalid number format for gender
                request.setAttribute("message", "Invalid gender value!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
private boolean isValidPassword(String password) {
        // Kiểm tra độ dài mật khẩu và mức độ mạnh
        return password.matches(IConstant.REGEX_PASSWORD);
    }
    /** 
     * Handles the HTTP GET method.
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
     * Handles the HTTP POST method.
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
        return "RegisterServlet handles user registration with validation.";
    }
}
