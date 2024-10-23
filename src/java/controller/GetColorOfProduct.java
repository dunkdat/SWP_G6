package controller;

import dal.DAOProduct;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class GetColorOfProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GetColorOfProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetColorOfProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tham số màu và tên sản phẩm từ yêu cầu
        String selectedColor = request.getParameter("color");
        String productName = request.getParameter("name");
        DAOProduct d = new DAOProduct();
        // Tạo đường dẫn ảnh dựa trên màu và tên sản phẩm
        String imageLink = d.getProductLinkPicture(productName, selectedColor);

        try (PrintWriter out = response.getWriter()) {
            // Trả về HTML với thẻ <img> chứa đường dẫn đến ảnh mới
            out.println("<img src='" + imageLink + "' alt='" + productName + "' id='product-image'>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for getting product image based on selected color";
    }
}
