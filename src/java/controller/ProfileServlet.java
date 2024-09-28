/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import constant.IConstant;
import dal.DAOUser;
import java.io.IOException;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.User;
import util.Validate;

/**
 *
 * @author Lenovo
 */
@MultipartConfig
public class ProfileServlet extends HttpServlet {
           DAOUser daoUser = new DAOUser();

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
        HttpSession session = request.getSession();
        String[] listService = {"Account info", "My order", "Change password"};
        request.setAttribute("listService", listService);
        //gia su dang nhap
        session.setAttribute("currentUser", daoUser.getUserById(1));
        User acc = (User)session.getAttribute("currentUser");
        String service = request.getParameter("Service");
        //neu da dang nhap
        if (acc != null) {
            if (service == null) {
                service = listService[0];
            }
            if(service.equals(listService[1])) {
               
            }
            request.setAttribute("current", service);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        } else {
         response.sendRedirect("login");
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
        String service = request.getParameter("Service");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        System.out.println("currsess: "+user);
        String mess = "";
        String filename = null;
        if(user != null) {
         boolean isSuccess = false;
         if (service.equals("updateInfo")) {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            Part cusImage = request.getPart("accountImage");
            int gender = Integer.parseInt(request.getParameter("gender"));
            String phone = request.getParameter("phone");
            //update not have value in input
            if (name.isEmpty() || address.isEmpty() || phone.isEmpty()) {
                setCommonAttributes(request, response, "please fill all field!", isSuccess, "Account info");
                return;
            }
            
            if (!Validate.isValidName(name)) {
                setCommonAttributes(request, response, "Invalid input your name!", isSuccess, "Account info");
                return;
            }
             
            if (!Validate.isValidPhoneNumber(phone)) {
                setCommonAttributes(request, response, "Invalid input phone num!", isSuccess, "Account info");
                return;
            } 
            if (!Validate.isValidAddress(address)) {
                setCommonAttributes(request, response, "Invalid addres!", isSuccess, "Account info");
                return;
            }
            if (cusImage.equals("") || cusImage == null) {
                cusImage = request.getPart("beforeImage");
            }
            if (cusImage == null || !Validate.isImageFile(cusImage)) {
                 filename = user.getImagePath();
             } else {
                 filename = cusImage.getSubmittedFileName();
             }
             String folderPath = getServletContext().getRealPath("") + File.separator + IConstant.PATH_USER;
             saveImage(cusImage, folderPath, filename);
             User cussChange = new User(user.getId(), name,  address, 
             gender,  phone,  filename);
             
             boolean haveUpdate = daoUser.updateCustomer(cussChange);
             User updatedUser = daoUser.getUserById(user.getId());
             session.removeAttribute("currentUser"); // Xóa đối tượng cũ khỏi phiên
             session.setAttribute("currentUser", updatedUser); // Thêm đối tượng mới vào phiên
            if (haveUpdate) {
                isSuccess = true;
                mess = "update success";
            } else {
                isSuccess = false;
                mess = "update false";
            }
             System.out.println(haveUpdate);
            setCommonAttributes(request, response, mess, isSuccess, "Account info");
        }
        if (service.equals("updatePassword")) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            //check have field empty
              if (currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                mess = "Please fill in all fields.";
                setCommonAttributes(request, response, mess, isSuccess, "Change password");
                return;
               }
             //check valid current password
              if (daoUser.ValidateUsers(user.getEmail(), Validate.getMd5(currentPassword)) == null) {
                mess = "The current password incorrect.";
                setCommonAttributes(request, response, mess, isSuccess, "Change password");
                return;
              }
              
              //check valid format password
              if (!isValidPassword(newPassword)) {
                mess = "Password must have at least 8 characters and combine uppercase letters, lowercase letters, numbers and special characters.";
                setCommonAttributes(request, response, mess, isSuccess, "Change password");
                return;
              }
              //check valid confirm password
              if (!newPassword.equals(confirmPassword)) {
                mess = "The confirm password incorrect.";
                setCommonAttributes(request, response, mess, isSuccess, "Change password");
                return;
              }
               if (newPassword.equals(confirmPassword)) {
                mess = "The new password you just entered is the same as the old password.";
                setCommonAttributes(request, response, mess, isSuccess, "Change password");
                return;
              }
               daoUser.updatePassword(Validate.getMd5(newPassword), user.getId());
               mess = "change password success";
               isSuccess = true;
               setCommonAttributes(request, response, mess, isSuccess, "Change password");
            }
        } else {
          response.sendRedirect("login");
        }
    }
    private boolean isValidPassword(String password) {
        // Kiểm tra độ dài mật khẩu và mức độ mạnh
        return password.matches(IConstant.REGEX_PASSWORD);
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
    private void setCommonAttributes(HttpServletRequest request, 
            HttpServletResponse response, String mess, 
            boolean isSuccess, String current)  throws ServletException, IOException  {
         String[] listService = {"Account info", "My order", "Change password"};
         request.setAttribute("listService", listService);
         request.setAttribute("isSuccess", isSuccess);
         request.setAttribute("current", current);
         request.setAttribute("mess", mess);
         request.getRequestDispatcher("profile.jsp").forward(request, response);
         return;
    }
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static void main(String[] args) {
        String phone = "0356789999"; // Thay thế bằng số điện thoại bạn muốn kiểm tra
        String regex = "^0\\d{9}$"; // Regex cho số điện thoại bắt đầu bằng 0 và có độ dài 10 chữ số
//String phone = "Thanh Hoa2@" ; // Thay thế bằng số điện thoại bạn muốn kiểm tra
//        String regex = "^[A-Za-z0-9 ,]+$"; /
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phone);

        if (Validate.isValidPhoneNumber(phone)) {
            System.out.println("Số điện thoại hợp lệ.");
        } else {
            System.out.println("Số điện thoại không hợp lệ.");
      }
    }
}
