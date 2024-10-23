package controller;

import constant.IConstant;
import dal.DAOProduct;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import util.Validate;

@MultipartConfig
public class StaffProductDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("submit");
        DAOProduct d = new DAOProduct();

        if (action != null) {
            request.setAttribute("productlist", d.getAllStaffProducts());
            
            
            String thumbnail = request.getParameter("link_picture");
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            Float price = Float.valueOf(request.getParameter("price"));
            String color = request.getParameter("color");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String details = request.getParameter("details");
            String status = request.getParameter("status");
            int salePercent = Integer.parseInt(request.getParameter("salePercent"));

            if (action.equals("update")) {
                if (!category.equals("shoes")) {
                    if(thumbnail!=null && !thumbnail.isBlank()){
                       d.updateProductWithThumnail(name,  category,  brand,  price,  color, quantity,  details, thumbnail,  status,  salePercent,  id); 
                    }else{
                        d.updateProduct(name, category, brand, price, color, quantity, details, status, salePercent, id);
                    }
                    
                } else {
                    int size = Integer.parseInt(request.getParameter("size"));
                    if((thumbnail!=null)&& !thumbnail.isBlank()){
                        d.updateShoesWithThumnail(name, category, brand, price, color, size, quantity, details,thumbnail, status, salePercent, id);
                    
                    }else{
                        d.updateShoes(name, category, brand, price, color,size, quantity, details, status, salePercent, id);
                    }
                }
            }

            if (action.equals("delete")) {
                d.deleteProductByid(id);
            }
int currentPage =  1;
                int pageSize = 10; // Số sản phẩm trên mỗi trang
                int offset = (currentPage - 1) * pageSize;

                // Lấy tổng số sản phẩm và tính tổng số trang
                int totalProducts = d.getTotalProductsStaff();
                int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                request.setAttribute("page", currentPage);
                    request.setAttribute("totalPages", totalPages);
            request.setAttribute("productlist", d.getAllStaffProducts(offset, pageSize));
            request.getRequestDispatcher("stafflistproduct.jsp").forward(request, response);
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
