/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constant.IConstant;
import dal.DAOUser;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import model.User;
import util.Validate;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CustomerManager", urlPatterns = {"/CustomerManager"})
@MultipartConfig
public class CustomerManager extends HttpServlet {

    String st = "";

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOUser dao = new DAOUser();
        try ( PrintWriter out = response.getWriter()) {
            String service = request.getParameter("Service");
            if (service == null) {
                service = "listAllCustomer";
            }

            switch (service) {
                case "listAllCustomer":
                    listAllCustomers(request, response, dao);
                    break;
                case "deleteCustomer":
                    deleteCustomer(request, response, dao);
                    break;
                case "updateCustomer":
                    updateCustomer(request, response, dao);
                    break;
                case "addCustomer":
                    addCustomer(request, response, dao);
                    break;
                case "search":
                    searchCustomer(request, response, dao);
                    break;
                case "sort":
                    sortCustomers(request, response, dao);
                    break;
            }
        }
    }

    private void listAllCustomers(HttpServletRequest request,
            HttpServletResponse response, DAOUser dao)
            throws ServletException, IOException {
        String message = request.getParameter("message");
        String indexPage = request.getParameter("index");
        int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

        String numberOnPage = request.getParameter("numberOnPage");
        int numberOnP = (numberOnPage == null) ? IConstant.ITEMS_PER_PAGE : Integer.parseInt(numberOnPage);

        int count = dao.getTotalCustomer();
        int endPage = count / numberOnP;
        if (count % numberOnP != 0) {
            endPage++;
        }
        List<User> list = dao.pagination(index, numberOnP);

        request.setAttribute("message", message);
        request.setAttribute("endP", endPage);
        request.setAttribute("data", list);
        request.setAttribute("tag", index);
        request.setAttribute("numberOnP", numberOnP);
        dispatch(request, response, "DisplayCustomer.jsp");
    }

    private void deleteCustomer(HttpServletRequest request,
            HttpServletResponse response, DAOUser dao)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int n = dao.deleteUser(id);
        st = (n == 0) ? "Failed to delete Customer (Id  = " + id + ")"
                + " because this customer is associated with an order."
                : "Delete Customer (Id = " + id + ") done!";
        response.sendRedirect("CustomerManager?message=" + st);
    }

    private void updateCustomer(HttpServletRequest request,
            HttpServletResponse response, DAOUser dao)
            throws IOException, ServletException {
        String submit = request.getParameter("submit");

        if (submit == null) {
            int id = Integer.parseInt(request.getParameter("id"));
            User cus = dao.getUserById(id);

            request.setAttribute("data", cus);
            dispatch(request, response, "customerProfile.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String addr = request.getParameter("address");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        Part part = request.getPart("customer_img");
        String filename = null;

        if (part == null || !Validate.isImageFile(part)) {
            st = "Please enter a valid image file";
            request.setAttribute("imageError", st);
            int customerId = Integer.parseInt(request.getParameter("id"));
            User cus = dao.getUserById(customerId);
            request.setAttribute("data", cus);
            dispatch(request, response, "customerProfile.jsp");
            return;
        }

        filename = part.getSubmittedFileName();
        String folderPath = getServletContext().getRealPath("") + File.separator + IConstant.PATH_USER;
        saveImage(part, folderPath, filename);

        if (!Validate.isValidName(name)) {
            String errorMessage = "Invalid input for name. Please check your input and try again.";
            request.setAttribute("errorMessage", errorMessage);
            int customerId = Integer.parseInt(request.getParameter("id"));
            User cus = dao.getUserById(customerId);
            request.setAttribute("data", cus);
            dispatch(request, response, "customerProfile.jsp");
            return;
        }
 if (!Validate.isValidEmail(email)) {
            String errorMessage = "Invalid input for email,. Please check your input and try again.";
            request.setAttribute("errorMessage", errorMessage);
            int customerId = Integer.parseInt(request.getParameter("id"));
            User cus = dao.getUserById(customerId);
            request.setAttribute("data", cus);
            dispatch(request, response, "customerProfile.jsp");
            return;
        }
  if (!Validate.isValidPhoneNumber(phone)) {
            String errorMessage = "Invalid input for phone,. Please check your input and try again.";
            request.setAttribute("errorMessage", errorMessage);
            int customerId = Integer.parseInt(request.getParameter("id"));
            User cus = dao.getUserById(customerId);
            request.setAttribute("data", cus);
            dispatch(request, response, "customerProfile.jsp");
            return;
        }
        try {
            User cus = new User(id, name, addr, Integer.parseInt(gender), phone, email, filename);
            if(!dao.updateCustomer(cus)) {
                st = "Failed to update Customer (Name = " + cus.getName()+ ") because this customer is associated with an order.";
            } else {
                st = "Update Customer (Name = " + cus.getName() + ") done!";
            }
            response.sendRedirect("CustomerManager?message=" + st);
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    private void addCustomer(HttpServletRequest request,
            HttpServletResponse response, DAOUser dao)
            throws IOException, ServletException {
        String submit = request.getParameter("submit");
        if (submit != null) {
            String name = request.getParameter("name");
            String password = request.getParameter("pass");
            String email = request.getParameter("email");
            String addr = request.getParameter("address");
            String phone = request.getParameter("phone");
            Part part = request.getPart("customer_img");
            String filename = null;
            if (part == null) {
                st = "Please enter the file image";
                request.setAttribute("imageError", st);
                dispatch(request, response,
                        "addNewCustomer.jsp");
                return;
            } else {
                filename = part.getSubmittedFileName();
                // Validate if the uploaded file is an image
                if (!Validate.isImageFile(part)) {
                    String errorMessage = "Invalid image file. Please upload a valid image.";
                    request.setAttribute("imageError", errorMessage);
                    dispatch(request, response, "addNewCustomer.jsp");
                    return;
                }
                String folderPath = getServletContext().getRealPath("") + File.separator + IConstant.PATH_USER;
                saveImage(part, folderPath, filename);
            }
            //Validate
            if (Validate.isValidName(name) && Validate.isValidEmail(email)
                    && Validate.isValidPhoneNumber(phone) && Validate.isValidPassword(password)) {
            } else {
                String errorMessage = "Invalid input your name, email or phone."
                        + " Please check your input and try again.";
                request.setAttribute("errorMessage", errorMessage);
                dispatch(request, response,
                        "addNewCustomer.jsp");
                return;
            }
            //Check duplicate input email
            if (dao.getUserByEmail(email) != null) {
                String errorMessage = "Email already exists. Please use a different email.";
                request.setAttribute("errorMessage", errorMessage);
                dispatch(request, response,
                        "addNewCustomer.jsp");
                return;
            }
            User cus = new User();

            if (dao.addUser(cus) == 0) {
                st = "Failed to add Customer (Name  = "
                        + cus.getName() + ") because this customer is"
                        + " associated with an order.";
            } else {
                st = "Add Customer (Name = " + cus.getName()
                        + ") done!";
            }
            request.setAttribute("msg", st);
            dispatch(request, response, "addNewCustomer.jsp");
        } else {
            dispatch(request, response, "addNewCustomer.jsp");
        }
    }

    private void searchCustomer(HttpServletRequest request,
            HttpServletResponse response, DAOUser dao)
            throws IOException, ServletException {
        String searchTxt = request.getParameter("keyword");
        int countSearch = dao.getTotalCustomerSearch(searchTxt);

        if (countSearch == 0) {
            st = "Your keywords do not match with any Customers Name";
            response.sendRedirect("CustomerManager?message=" + st);
        } else {
            String indexPage = request.getParameter("index");
            int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

            String numberOnPage = request.getParameter("numberOnPage");
            int numberOnP = (numberOnPage == null) ? IConstant.ITEMS_PER_PAGE : Integer.parseInt(numberOnPage);

            List<User> listSearch = dao.searchCustomer(searchTxt, index, numberOnP);
            int endPage = countSearch / numberOnP;
            if (countSearch % numberOnP != 0) {
                endPage++;
            }
            if (searchTxt == null) {
                response.sendRedirect("CustomerManager");
                return;
            }
            request.setAttribute("endP", endPage);
            request.setAttribute("data", listSearch);
            request.setAttribute("tag", index);
            request.setAttribute("saveSearch", searchTxt);
            request.setAttribute("numberOnP", numberOnP);
            request.setAttribute("countSearch", countSearch);
            dispatch(request, response, "DisplayCustomer.jsp");
        }
    }

    private void sortCustomers(HttpServletRequest request,
            HttpServletResponse response, DAOUser dao)
            throws ServletException, IOException {
        String sortBy = request.getParameter("sortBy");
        String indexPage = request.getParameter("index");
        int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

        String numberOnPage = request.getParameter("numberOnPage");
        int numberOnP = (numberOnPage == null) ? IConstant.ITEMS_PER_PAGE : Integer.parseInt(numberOnPage);

        int count = dao.getTotalCustomer();
        int endPage = count / numberOnP;
        if (count % numberOnP != 0) {
            endPage++;
        }

        if (sortBy != null) {
            if (sortBy.equals("order-name_asc")) {
                List<User> sortOrderByAsc
                            = dao.sortAndPaginate(index, IConstant.ASC, numberOnP);
                request.setAttribute("data", sortOrderByAsc);
            } else if (sortBy.equals("order-name_des")) {
                List<User>  sortOrderByDesc
                        = dao.sortAndPaginate(index, IConstant.DESC, numberOnP);
                request.setAttribute("data", sortOrderByDesc);
            }
        }
        if (sortBy == null) {
            response.sendRedirect("CustomerManager");
            return;
        }

        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("saveSort", sortBy);
        request.setAttribute("numberOnP", numberOnP);
        dispatch(request, response, "DisplayCustomer.jsp");
    }

    // Phương thức chuyển hướng Request và Response
    private void dispatch(HttpServletRequest request,
            HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(page);
        dispatcher.forward(request, response);
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
public static void main(String[] args) {
    DAOUser dao = new DAOUser();
          User cus = new User(2, "wangaa", "Thanh Hoa", 1, "0123545789", "vuong2@gmail.com", "news_1.jpg");
          System.out.println(dao.updateCustomer(cus));
    }
}
