/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAOProduct;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Products;

/**
 *
 * @author DAT
 */
public class LoadProductsServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoadProductsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadProductsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
    try {
        // Lấy tham số 'page' từ request
        String pageParam = request.getParameter("page");
        int page;
        if (pageParam == null || pageParam.isEmpty()) {
            page = 1; // Mặc định là trang 1 nếu không có tham số
        } else {
            page = Integer.parseInt(pageParam);
        }

        int pageSize = 12; // Số sản phẩm mỗi trang
        int offset = (page - 1) * pageSize;

        DAOProduct productDAO = new DAOProduct();

        // Lấy tổng số sản phẩm và tính tổng số trang
        int totalProducts = productDAO.getTotalProducts();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // Lấy danh sách sản phẩm dựa trên trang hiện tại
        List<Products> productList = productDAO.getProductsByPage(offset, pageSize);
        // Thiết lập nội dung trả về là HTML
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
     
        // Tạo HTML để hiển thị danh sách sản phẩm
        for (Products product : productList) {
            out.println("<div class='product'>");
            out.println("<a href='productdetails?id=" + product.getId() + "'>");
            out.println("<img src='" + product.getLink_picture() + "' alt='" + product.getName() + "'>");
            out.println("</a>");
            out.println("<h2>" + product.getName() + "</h2>");
            out.println("<p>" + product.getDetails() + "</p>");
            out.println("<p style='color: red'>Price: " + product.getPrice() + "</p>");
            out.println("</div>");
        }

        out.println("<div class='pagination'>");

        // Nút "Prev" (chỉ hiển thị nếu không phải là trang đầu tiên)
        if (page > 1) {
    out.println("<a href='#' data-page='" + (page - 1) + "'>Prev</a>");
}

// Tính toán trang bắt đầu và kết thúc
int startPage = Math.max(1, page - 2); // Trang bắt đầu, tối thiểu là 1
int endPage = Math.min(startPage + 4, totalPages); // Trang kết thúc, tối đa là 5 trang
startPage = Math.max(1, endPage - 4); // Điều chỉnh lại trang bắt đầu nếu trang kết thúc quá gần cuối

// Hiển thị các liên kết phân trang
for (int i = startPage; i <= endPage; i++) {
    if (i == page) {
        out.println("<a href='#' data-page='" + i + "' class='active'>" + i + "</a>");
    } else {
        out.println("<a href='#' data-page='" + i + "'>" + i + "</a>");
    }
}

// Nút "Next" (chỉ hiển thị nếu trang hiện tại nhỏ hơn tổng số trang)
if (page < totalPages) {
    out.println("<a href='#' data-page='" + (page + 1) + "'>Next</a>");
}

        out.println("</div>"); // Kết thúc phần phân trang


        out.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra trên server.");
    }
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

}
