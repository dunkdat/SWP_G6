/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Products;
import model.Review;

/**
 *
 * @author DAT
 */
public class DAOProduct extends DBContext {

    public boolean addProduct(String id, String linkPicture, String name, String category, String brand, String color, int quantity, String details, int size, double price) {
        String query = "INSERT INTO Products (id, link_picture, name, category, brand, color, quantity, details, size, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {

            // Thiết lập các giá trị cho câu truy vấn
            ps.setString(1, id);
            ps.setString(2, linkPicture);
            ps.setString(3, name);
            ps.setString(4, category);
            ps.setString(5, brand);
            ps.setString(6, color);
            ps.setInt(7, quantity);
            ps.setString(8, details);

            // Kiểm tra nếu sản phẩm có size thì set, nếu không thì set null
            if (size != 0) {
                ps.setInt(9, size);
            } else {
                ps.setNull(9, java.sql.Types.INTEGER);  // Đặt null nếu không phải là giày
            }

            ps.setDouble(10, price);

            // Thực thi câu lệnh
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu thêm thành công

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
   public boolean updateShoes(String name, String category, String brand, double price, String color, int size, int quantity, String details, String status, int salePercent, String id) {
        String sql = "UPDATE Products SET category = ?, brand = ?, price = ?, color = ?, size = ?, quantity = ?, details = ?, status = ?, salePercent = ?, name = ? WHERE id = ? ";
        int rowsUpdated = 0;
        try  {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category);
            statement.setString(2, brand);
            statement.setDouble(3, price);
            statement.setString(4, color);
            statement.setInt(5, size);
            statement.setInt(6, quantity);
            statement.setString(7, details);
            statement.setString(8, status);
            statement.setInt(9, salePercent);
            statement.setString(10, name);
            statement.setString(11, id);
            
             rowsUpdated = statement.executeUpdate();
            // returns true if the update was successful
        }catch(Exception e){
            System.out.println(e);
        }
      return rowsUpdated > 0; 
   }
   public boolean updateProduct(String name, String category, String brand, double price, String color, int quantity, String details, String status, int salePercent, String id) {
        String sql = "UPDATE Products SET category = ?, brand = ?, price = ?, color = ?, quantity = ?, details = ?, status = ?, salePercent = ?, name = ? WHERE id = ? ";
        int rowsUpdated = 0;
        try  {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category);
            statement.setString(2, brand);
            statement.setDouble(3, price);
            statement.setString(4, color);
            statement.setInt(5, quantity);
            statement.setString(6, details);
            statement.setString(7, status);
            statement.setInt(8, salePercent);
            statement.setString(9, name);
            statement.setString(10, id);
            
             rowsUpdated = statement.executeUpdate();
            // returns true if the update was successful
        }catch(Exception e){
            System.out.println(e);
        }
      return rowsUpdated > 0; 
   }
   public boolean updateProductWithThumnail(String name, String category, String brand, double price, String color, int quantity, String details, String linkPicture, String status, int salePercent, String id) {
        String sql = "UPDATE Products SET category = ?, brand = ?, price = ?, color = ?, quantity = ?, details = ?, link_picture = ?, status = ?, salePercent = ?, name = ? WHERE id = ? ";
        int rowsUpdated = 0;
        try  {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category);
            statement.setString(2, brand);
            statement.setDouble(3, price);
            statement.setString(4, color);
            statement.setInt(5, quantity);
            statement.setString(6, details);
            statement.setString(7, linkPicture);
            statement.setString(8, status);
            statement.setInt(9, salePercent);
            statement.setString(10, name);
            statement.setString(11, id);
            
             rowsUpdated = statement.executeUpdate();
            // returns true if the update was successful
        }catch(Exception e){
            System.out.println(e);
        }
      return rowsUpdated > 0; 
   }
   public boolean updateShoesWithThumnail(String name, String category, String brand, double price, String color, int size, int quantity, String details, String linkPicture, String status, int salePercent, String id) {
        String sql = "UPDATE Products SET category = ?, brand = ?, price = ?, color = ?, size = ?, quantity = ?, details = ?, link_picture = ?, status = ?, salePercent = ?, name = ? WHERE id = ? ";
        int rowsUpdated = 0;
        try  {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category);
            statement.setString(2, brand);
            statement.setDouble(3, price);
            statement.setString(4, color);
            statement.setInt(5, size);
            statement.setInt(6, quantity);
            statement.setString(7, details);
            statement.setString(8, linkPicture);
            statement.setString(9, status);
            statement.setInt(10, salePercent);
            statement.setString(11, name);
            statement.setString(12, id);
            
             rowsUpdated = statement.executeUpdate();
            // returns true if the update was successful
        }catch(Exception e){
            System.out.println(e);
        }
      return rowsUpdated > 0; 
   }
public boolean deleteProductByid( String id) {
        String sql = "delete from Products WHERE id = ? ";
        int rowsUpdated = 0;
        try  {
            PreparedStatement statement = connection.prepareStatement(sql);
            
            statement.setString(1, id);
            
             rowsUpdated = statement.executeUpdate();
            // returns true if the update was successful
        }catch(Exception e){
            System.out.println(e);
        }
      return rowsUpdated > 0; 
   }
    // Method to get all products by id
    public boolean updateSale(String name, String salePercent) {
    // SQL statement to update salePercent and price
    String sql = "UPDATE Products SET salePercent = ?, price = price * ((100 - ?) / 100.0) WHERE name = ?";
    int rowsUpdated = 0;
    try {
        PreparedStatement statement = connection.prepareStatement(sql);
        
        // Set the salePercent value and use it for the price calculation
        statement.setInt(1, Integer.parseInt(salePercent)); // Assuming salePercent is an integer percentage
        statement.setInt(2, Integer.parseInt(salePercent)); // Use the same value for the price calculation
        statement.setString(3, name); // Set the product name
        
        rowsUpdated = statement.executeUpdate();
    } catch (Exception e) {
        System.out.println(e);
    }
    
    // Returns true if the update was successful
    return rowsUpdated > 0;
}

public List<Products> getAllProducts() {
    List<Products> products = new ArrayList<>();
    
    // Query to select distinct names along with other information
    String sql = "SELECT p.* FROM Products p INNER JOIN ( SELECT name, MIN(id) AS min_id FROM Products where status = 'active' GROUP BY name) AS unique_products\n" +
"                   ON p.id = unique_products.min_id";
    
    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            // Map the result set to Product object
            Products product = new Products(
                    resultSet.getString("id"),
                    resultSet.getString("name"),
                    resultSet.getString("category"),
                    resultSet.getString("brand"),
                    resultSet.getFloat("price"),
                    resultSet.getString("color"),
                    resultSet.getInt("size"),
                    resultSet.getInt("quantity"),
                    resultSet.getString("details"),
                    resultSet.getString("link_picture"),
                    resultSet.getString("status"),
                    resultSet.getInt("salePercent")
            );
            products.add(product);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return products;
}
public List<Products> getAllStaffProducts() {
    List<Products> products = new ArrayList<>();
    
    // Query to select distinct names along with other information
    String sql = "SELECT * From products";
    
    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            // Map the result set to Product object
            Products product = new Products(
                    resultSet.getString("id"),
                    resultSet.getString("name"),
                    resultSet.getString("category"),
                    resultSet.getString("brand"),
                    resultSet.getFloat("price"),
                    resultSet.getString("color"),
                    resultSet.getInt("size"),
                    resultSet.getInt("quantity"),
                    resultSet.getString("details"),
                    resultSet.getString("link_picture"),
                    resultSet.getString("status"),
                    resultSet.getInt("salePercent")
            );
            products.add(product);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return products;
}
public List<Products> getAllStaffProducts(int offset, int limit) {
    List<Products> products = new ArrayList<>();
    
    // Query để lấy sản phẩm với danh mục có trạng thái 'active'
    String sql = "SELECT p.* FROM products p " +
                 "JOIN categories c ON p.category = c.id " +
                 "WHERE c.status = 'active' " +
                 "LIMIT ? OFFSET ?";
    
    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
        preparedStatement.setInt(1, limit);
        preparedStatement.setInt(2, offset);
        ResultSet resultSet = preparedStatement.executeQuery();
      
        while (resultSet.next()) {
            // Ánh xạ kết quả thành đối tượng Products
            Products product = new Products(
                    resultSet.getString("id"),
                    resultSet.getString("name"),
                    resultSet.getString("category"),
                    resultSet.getString("brand"),
                    resultSet.getFloat("price"),
                    resultSet.getString("color"),
                    resultSet.getInt("size"),
                    resultSet.getInt("quantity"),
                    resultSet.getString("details"),
                    resultSet.getString("link_picture"),
                    resultSet.getString("status"),
                    resultSet.getInt("salePercent")
            );
            products.add(product);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return products;
}

public List<Products> getAllFilterProductsStaff(String category, String status, String searchQuery, int limit, int offset) {
    List<Products> productList = new ArrayList<>();
    try {
        // Bắt đầu xây dựng câu truy vấn SQL
        StringBuilder sql = new StringBuilder("SELECT p.* FROM Products p " +
                                              "JOIN Categories c ON p.category = c.id " +
                                              "WHERE c.status = 'active'"); // Chỉ lấy danh mục có trạng thái 'active'

        // Thêm bộ lọc dựa trên các tham số được cung cấp
        if (category != null && !category.isEmpty()) {
            sql.append(" AND p.category = ?");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND p.status = ?");
        }

        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND p.name LIKE ?");
        }

        // Thêm limit và offset cho phân trang
        sql.append(" LIMIT ? OFFSET ?");

        // Chuẩn bị câu lệnh
        PreparedStatement st = connection.prepareStatement(sql.toString());

        int paramIndex = 1; // Chỉ số bắt đầu cho các tham số

        // Thiết lập các tham số dựa trên các bộ lọc
        if (category != null && !category.isEmpty()) {
            st.setString(paramIndex++, category);
        }

        if (status != null && !status.isEmpty()) {
            st.setString(paramIndex++, status);
        }

        if (searchQuery != null && !searchQuery.isEmpty()) {
            st.setString(paramIndex++, "%" + searchQuery + "%"); // Sử dụng LIKE với ký tự đại diện
        }

        // Thiết lập limit và offset cho phân trang
        st.setInt(paramIndex++, limit);
        st.setInt(paramIndex, offset);

        // Thực thi truy vấn và xử lý kết quả
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Products product = new Products(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getString("brand"),
                    rs.getFloat("price"),
                    rs.getString("color"),
                    rs.getInt("size"),
                    rs.getInt("quantity"),
                    rs.getString("details"),
                    rs.getString("link_picture"),
                    rs.getString("status"),
                    rs.getInt("salePercent")
            );
            productList.add(product);
        }
    } catch (SQLException e) {
        // Ghi log lỗi SQL để phục vụ việc gỡ lỗi
        System.err.println("SQL Error: " + e.getMessage());
    }
    return productList;
}



   public List<Products> getAllProduct(String category, String brand, String lowPrice, String highPrice, String searchQuery, int limit, int offset) {
    List<Products> productList = new ArrayList<>();
    try {
        // Start building the SQL query 
        StringBuilder sql = new StringBuilder("SELECT p.* FROM Products p INNER JOIN "
                + "( SELECT name, MIN(id) AS min_id FROM Products WHERE status = 'active' GROUP BY name ) AS unique_products\n" +
"                   ON p.id = unique_products.min_id "
                + "WHERE 1=1");

        // Add brand filter if provided
        if(category != null && !category.isEmpty()){
            sql.append(" AND p.category = ?");
        }
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND p.brand = ?");
        }

        // Add price filter if both lowPrice and highPrice are provided
        if (lowPrice != null && highPrice != null) {
            sql.append(" AND p.price BETWEEN ? AND ?");
        }

        // Add search query filter if provided
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND p.name LIKE ?");
        }

        // Add limit and offset for pagination
        sql.append(" LIMIT ? OFFSET ?");

        // Prepare the statement
        PreparedStatement st = connection.prepareStatement(sql.toString());

        // Set the category

        int paramIndex = 1; // Start index for optional parameters
        
        if (category != null && !category.isEmpty()){
            st.setString(paramIndex++, category);
        }
        // Set brand parameter if provided
        if (brand != null && !brand.isEmpty()) {
            st.setString(paramIndex++, brand);
        }

        // Set price range parameters if provided
        if (lowPrice != null && highPrice != null) {
            st.setFloat(paramIndex++, Float.parseFloat(lowPrice));
            st.setFloat(paramIndex++, Float.parseFloat(highPrice));
        }

        // Set search query parameter if provided
        if (searchQuery != null && !searchQuery.isEmpty()) {
            st.setString(paramIndex++, "%" + searchQuery + "%"); // Using LIKE with wildcards
        }

        // Set the limit and offset for pagination
        st.setInt(paramIndex++, limit);
        st.setInt(paramIndex, offset);

        // Execute the query and process the results
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Products product = new Products(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getString("brand"),
                    rs.getFloat("price"),
                    rs.getString("color"),
                    rs.getInt("size"),
                    rs.getInt("quantity"),
                    rs.getString("details"),
                    rs.getString("link_picture"),
                    rs.getString("status"),
                    rs.getInt("salePercent")
            );
            productList.add(product);
        }
    } catch (SQLException e) {
        // Log the exception for debugging
        System.err.println("SQL Error: " + e.getMessage());
    }
    return productList;
}
public List<Products> getAllSaleProduct(String category, String brand, String lowPrice, String highPrice, String searchQuery, int limit, int offset) {
    List<Products> productList = new ArrayList<>();
    try {
        // Start building the SQL query 
        StringBuilder sql = new StringBuilder("SELECT p.* FROM Products p INNER JOIN "
                + "( SELECT name, MIN(id) AS min_id FROM Products WHERE status = 'active' GROUP BY name ) AS unique_products\n" +
"                   ON p.id = unique_products.min_id "
                + "WHERE salePercent > 0");

        // Add brand filter if provided
        if(category != null && !category.isEmpty()){
            sql.append(" AND p.category = ?");
        }
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND p.brand = ?");
        }

        // Add price filter if both lowPrice and highPrice are provided
        if (lowPrice != null && highPrice != null) {
            sql.append(" AND p.price BETWEEN ? AND ?");
        }

        // Add search query filter if provided
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND p.name LIKE ?");
        }

        // Add limit and offset for pagination
        sql.append(" LIMIT ? OFFSET ?");

        // Prepare the statement
        PreparedStatement st = connection.prepareStatement(sql.toString());

        // Set the category

        int paramIndex = 1; // Start index for optional parameters
        
        if (category != null && !category.isEmpty()){
            st.setString(paramIndex++, category);
        }
        // Set brand parameter if provided
        if (brand != null && !brand.isEmpty()) {
            st.setString(paramIndex++, brand);
        }

        // Set price range parameters if provided
        if (lowPrice != null && highPrice != null) {
            st.setFloat(paramIndex++, Float.parseFloat(lowPrice));
            st.setFloat(paramIndex++, Float.parseFloat(highPrice));
        }

        // Set search query parameter if provided
        if (searchQuery != null && !searchQuery.isEmpty()) {
            st.setString(paramIndex++, "%" + searchQuery + "%"); // Using LIKE with wildcards
        }

        // Set the limit and offset for pagination
        st.setInt(paramIndex++, limit);
        st.setInt(paramIndex, offset);

        // Execute the query and process the results
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Products product = new Products(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getString("brand"),
                    rs.getFloat("price"),
                    rs.getString("color"),
                    rs.getInt("size"),
                    rs.getInt("quantity"),
                    rs.getString("details"),
                    rs.getString("link_picture"),
                    rs.getString("status"),
                    rs.getInt("salePercent")
            );
            productList.add(product);
        }
    } catch (SQLException e) {
        // Log the exception for debugging
        System.err.println("SQL Error: " + e.getMessage());
    }
    return productList;
}

    public int getTotalFilteredProducts(String category, String brand, String lowPrice, String highPrice, String searchQuery) {
    int totalProducts = 0;
    try {
        // Start building the SQL query
        StringBuilder sql = new StringBuilder(
            "SELECT Count(*) FROM Products p INNER JOIN ( SELECT name, MIN(id) AS min_id FROM Products GROUP BY name) AS unique_products ON p.id = unique_products.min_id where 1=1"
        );

        // Add brand filter if provided
        if(category != null && !category.isEmpty()){
            sql.append(" AND p.category = ?");
        }
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND p.brand = ?");
        }

        // Add price filter if both lowPrice and highPrice are provided
        if (lowPrice != null && highPrice != null) {
            sql.append(" AND p.price BETWEEN ? AND ?");
        }
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND p.name LIKE ?");
        }

        // Prepare the statement
        PreparedStatement st = connection.prepareStatement(sql.toString());
        

        int paramIndex = 1;
         if (category != null && !category.isEmpty()){
            st.setString(paramIndex++, category);
        }
        // Set brand parameter if provided
        if (brand != null && !brand.isEmpty()) {
            st.setString(paramIndex++, brand);
        }

        // Set price range parameters if provided
        if (lowPrice != null && highPrice != null) {
            st.setFloat(paramIndex++, Float.parseFloat(lowPrice));
            st.setFloat(paramIndex++, Float.parseFloat(highPrice));
        }
        if (searchQuery != null && !searchQuery.isEmpty()) {
            st.setString(paramIndex++, "%" + searchQuery + "%"); // Using LIKE with wildcards
        }

        // Execute query and get total number of products
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            totalProducts = rs.getInt(1); // Get the total count of filtered products
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return totalProducts;
}
    
    public int getTotalFilteredSaleProducts(String category, String brand, String lowPrice, String highPrice, String searchQuery) {
    int totalProducts = 0;
    try {
        // Start building the SQL query
        StringBuilder sql = new StringBuilder(
            "SELECT Count(*) FROM Products p INNER JOIN ( SELECT name, MIN(id) AS min_id FROM Products GROUP BY name) AS unique_products ON p.id = unique_products.min_id where p.salePercent > 0"
        );

        // Add brand filter if provided
        if(category != null && !category.isEmpty()){
            sql.append(" AND p.category = ?");
        }
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND p.brand = ?");
        }

        // Add price filter if both lowPrice and highPrice are provided
        if (lowPrice != null && highPrice != null) {
            sql.append(" AND p.price BETWEEN ? AND ?");
        }
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND p.name LIKE ?");
        }

        // Prepare the statement
        PreparedStatement st = connection.prepareStatement(sql.toString());
        

        int paramIndex = 1;
         if (category != null && !category.isEmpty()){
            st.setString(paramIndex++, category);
        }
        // Set brand parameter if provided
        if (brand != null && !brand.isEmpty()) {
            st.setString(paramIndex++, brand);
        }

        // Set price range parameters if provided
        if (lowPrice != null && highPrice != null) {
            st.setFloat(paramIndex++, Float.parseFloat(lowPrice));
            st.setFloat(paramIndex++, Float.parseFloat(highPrice));
        }
        if (searchQuery != null && !searchQuery.isEmpty()) {
            st.setString(paramIndex++, "%" + searchQuery + "%"); // Using LIKE with wildcards
        }

        // Execute query and get total number of products
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            totalProducts = rs.getInt(1); // Get the total count of filtered products
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return totalProducts;
}
     public Products getProductByNameColorSize(String name, String color, String size) {
        Products product = null;
        String sql = "SELECT * FROM Products WHERE name = ? AND color = ?";
        
        // If size is provided, append the condition to the query
        if (size != null) {
            sql += " AND size = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, color);
            
            if (size != null && !size.isBlank()) {
                ps.setInt(3, Integer.parseInt(size));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    product = new Products();
                    product.setId(rs.getString("id"));
                    product.setName(rs.getString("name"));
                    product.setCategory(rs.getString("category"));
                    product.setBrand(rs.getString("brand"));
                    product.setPrice(rs.getFloat("price"));
                    product.setColor(rs.getString("color"));
                    product.setSize(rs.getInt("size"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setDetails(rs.getString("details"));
                    product.setLink_picture(rs.getString("link_picture"));
                    product.setStatus(rs.getString("status"));
                    product.setSalePercent(rs.getInt("salePercent"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Proper exception handling/logging
        }
        return product;
    }
public int getTotalFilterProductsStaff(String category, String status, String searchQuery) {
    int totalProducts = 0;
    try {
        // Bắt đầu xây dựng câu truy vấn SQL
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products p " +
                                              "JOIN Categories c ON p.category = c.id " +
                                              "WHERE c.status = 'active'"); // Chỉ lấy danh mục có trạng thái 'active'

        // Thêm bộ lọc dựa trên các tham số được cung cấp
        if (category != null && !category.isEmpty()) {
            sql.append(" AND p.category = ?");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND p.status = ?");
        }

        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND p.name LIKE ?");
        }

        // Chuẩn bị câu lệnh
        PreparedStatement st = connection.prepareStatement(sql.toString());

        int paramIndex = 1; // Chỉ số bắt đầu cho các tham số

        // Thiết lập các tham số dựa trên các bộ lọc
        if (category != null && !category.isEmpty()) {
            st.setString(paramIndex++, category);
        }

        if (status != null && !status.isEmpty()) {
            st.setString(paramIndex++, status);
        }

        if (searchQuery != null && !searchQuery.isEmpty()) {
            st.setString(paramIndex++, "%" + searchQuery + "%"); // Sử dụng LIKE với ký tự đại diện
        }

        // Thực thi truy vấn và xử lý kết quả
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            totalProducts = rs.getInt(1);
        }
    } catch (SQLException e) {
        // Ghi log lỗi SQL để phục vụ việc gỡ lỗi
        System.err.println("SQL Error: " + e.getMessage());
    }
    return totalProducts;
}

public List<Integer> getProductSizesByNameAndColor(String productName, String color) {
        List<Integer> sizes = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Establish a connection to the database (Assuming you have a method to get a connection)
            
            // SQL query to fetch all sizes for a product with the specified name and color
            String query = "SELECT size FROM Products WHERE name = ? AND color = ? and quantity > 0 and status = 'active' order by size";
            pstmt = connection.prepareStatement(query);
            pstmt.setString(1, productName);
            pstmt.setString(2, color);

            // Execute the query
            rs = pstmt.executeQuery();

            // Add all sizes to the list
            while (rs.next()) {
                sizes.add(rs.getInt("size"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } 
        

        return sizes;
    }
    public Products getProductById(String id) {
        Products prd = null;
        String sql = "SELECT * FROM Products where id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new Products(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("brand"),
                        rs.getFloat("price"),
                        rs.getString("color"),
                        rs.getInt("size"),
                        rs.getInt("quantity"),
                        rs.getString("details"),
                        rs.getString("link_picture"),
                        rs.getString("status"),
                rs.getInt("salePercent"));
                
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
public List<Products> getProductsByNameColorSize(String name, String color, Integer size) {
    List<Products> productsList = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE name = ? AND color = ?");
    
    // Kiểm tra nếu kích thước được cung cấp thì thêm điều kiện size vào SQL query
    if (size != null ) {
        sql.append(" AND size = ?");
    }
    
    try {
        PreparedStatement pre = connection.prepareStatement(sql.toString());
        pre.setString(1, name);
        pre.setString(2, color);
        
        // Nếu kích thước không null thì set thêm tham số cho nó
        if (size != null) {
            pre.setInt(3, size);
        }
        
        ResultSet rs = pre.executeQuery();
        
        while (rs.next()) {
            Products prd = new Products(
                rs.getString("id"),
                rs.getString("name"),
                rs.getString("category"),
                rs.getString("brand"),
                rs.getFloat("price"),
                rs.getString("color"),
                rs.getInt("size"),
                rs.getInt("quantity"),
                rs.getString("details"),
                rs.getString("link_picture"),
                rs.getString("status"),
                rs.getInt("salePercent")
            );
            productsList.add(prd);
        }
        
    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }
    
    return productsList;
}

    public float getAverageStarRating(String productName) {
        float averageRating = 0;
        String sql = "SELECT AVG(star_rating) as average_rating FROM Reviews WHERE product_name = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, productName);
            ResultSet rs = pre.executeQuery();

            // Check if there are any ratings
            if (rs.next()) {
                averageRating = rs.getFloat("average_rating");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        // If no ratings are found, return 0
        return averageRating == 0 ? 0 : averageRating;
    }
    public float getAverageStarRatingTotal() {
        float averageRating = 0;
        String sql = "SELECT AVG(star_rating) as average_rating FROM Reviews";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();

            // Check if there are any ratings
            if (rs.next()) {
                averageRating = rs.getFloat("average_rating");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        // If no ratings are found, return 0
        return averageRating == 0 ? 0 : averageRating;
    }
    public int countAllReviews() {
    int reviewCount = 0;
    String sql = "SELECT COUNT(*) as review_count FROM Reviews";

    try {
        PreparedStatement pre = connection.prepareStatement(sql);
        ResultSet rs = pre.executeQuery();

        // Check if any reviews are found
        if (rs.next()) {
            reviewCount = rs.getInt("review_count");
        }
    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }

    return reviewCount;
}
public Map<String, Float> getAllAverageStarRatings() {
    Map<String, Float> averageRatingsMap = new HashMap<>();
    String sql = "SELECT product_name, AVG(star_rating) as average_rating FROM Reviews GROUP BY product_name";

    try {
        PreparedStatement pre = connection.prepareStatement(sql);
        ResultSet rs = pre.executeQuery();

        // Loop through the result set and store product name and its average rating
        while (rs.next()) {
            String productName = rs.getString("product_name");
            float averageRating = rs.getFloat("average_rating");
            averageRatingsMap.put(productName, averageRating);
        }
    } catch (SQLException e) {
        System.out.println(e.getMessage());
    }

    return averageRatingsMap;
}
    public List<Products> getRelatedProductsByBrand(String brand, String cat, String excludeProductId) {
        List<Products> relatedProducts = new ArrayList<>();
        String sql = "SELECT p.*\n"
                + "FROM Products p\n"
                + "INNER JOIN (\n"
                + "    SELECT name, MIN(id) AS min_id\n"
                + "    FROM Products\n"
                + "    GROUP BY name\n"
                + ") AS unique_products\n"
                + "ON p.id = unique_products.min_id\n"
                + "where brand = ? and category = ? and id != ? LIMIT 3"; // Exclude current product and limit results to 5
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, brand);
            pre.setString(2, cat);
            pre.setString(3, excludeProductId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Products product = new Products(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("brand"),
                        rs.getFloat("price"),
                        rs.getString("color"),
                        rs.getInt("size"),
                        rs.getInt("quantity"),
                        rs.getString("details"),
                        rs.getString("link_picture"));
                relatedProducts.add(product);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return relatedProducts;
    }

    public List<Review> getProductReviews(String productName) {
        List<Review> reviews = new ArrayList<>();

        // SQL query joining Reviews with Users to get customer name
        String sql = "SELECT r.id, r.customer_id, r.star_rating,r.product_name, r.comment, r.review_date, u.name AS customer_name "
                + "FROM Reviews r "
                + "JOIN Users u ON r.customer_id = u.id "
                + "WHERE r.product_name = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, productName);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                // Extract data from ResultSet and create a new Review object
                Review review = new Review(
                        rs.getString("id"),
                        rs.getInt("customer_id"),
                        rs.getInt("star_rating"),
                        rs.getString("product_name"),
                        rs.getString("comment"),
                        rs.getString("customer_name"), // Fetch customer name from Users table
                        rs.getTimestamp("review_date")
                );

                // Add the Review object to the list
                reviews.add(review);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return reviews;
    }

    public List<String> getColorsByProductName(String productName) {
        List<String> colors = new ArrayList<>();
        String sql = "SELECT DISTINCT color FROM Products WHERE name = ? and status = 'active'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, productName);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                colors.add(rs.getString("color"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return colors;
    }

    public List<String> getShoesSize() {
        List<String> sizes = new ArrayList<>();
        String sql = "SELECT DISTINCT size FROM Products WHERE category = 'shoes'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                sizes.add(rs.getString("size"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return sizes;
    }

    // Phương thức lấy danh sách sản phẩm với phân trang
    public List<Products> getProductsByPage(int offset, int pageSize) {
        List<Products> productList = new ArrayList<>();
        String sql = "SELECT p.* FROM Products p INNER JOIN "
                + "( SELECT name, MIN(id) AS min_id FROM Products where status = 'active' GROUP BY name) AS unique_products\n" +
"                   ON p.id = unique_products.min_id "
                + " limit ? offset ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String id = rs.getString("id");
                String name = rs.getString("name");
                String category = rs.getString("category");
                String brand = rs.getString("brand");
                float price = rs.getFloat("price");
                String color = rs.getString("color");
                int size = rs.getInt("size");
                int quantity = rs.getInt("quantity");
                String details = rs.getString("details");
                String linkPicture = rs.getString("link_picture");

                Products product = new Products(id, name, category, brand, price, color, size, quantity, details, linkPicture);
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public int getTotalProducts() {
        String sql = "SELECT Count(*) FROM Products p INNER JOIN "
                + "( SELECT name, MIN(id) AS min_id FROM Products GROUP BY name) AS unique_products\n" +
"                   ON p.id = unique_products.min_id ";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public int getTotalSaleProducts() {
        String sql = "SELECT Count(*) FROM Products p INNER JOIN "
                + "( SELECT name, MIN(id) AS min_id FROM Products GROUP BY name) AS unique_products\n" +
"                   ON p.id = unique_products.min_id where p.salePercent > 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public int getTotalProductsStaff() {
    String sql = "SELECT COUNT(*) FROM Products p " +
                 "JOIN Categories c ON p.category = c.id " +
                 "WHERE c.status = 'active'"; // Chỉ lấy các sản phẩm có danh mục 'active'
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

    public int getTotalProducts(String cat) {
    StringBuilder sql = new StringBuilder("SELECT Count(*) FROM Products p INNER JOIN ( SELECT name, MIN(id) AS min_id FROM Products GROUP BY name) AS unique_products ON p.id = unique_products.min_id");
    
    // Append the WHERE clause before creating the PreparedStatement
    if(cat != null && !cat.isEmpty()){
        sql.append(" WHERE p.category = ?");  // Assuming 'category' is a column in the Products table
    }
    
    try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
        // Set the value for the category if needed
        if(cat != null && !cat.isEmpty()){
            stmt.setString(1, cat);
        }

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);  // Return the count
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return 0;  // Return 0 if no result or an error occurred
}

public String getProductLinkPicture(String nameProduct, String color) {
        String linkPicture = null;
        String sql = "SELECT link_picture FROM Products WHERE name = ? AND color = ?";
        
        // Assuming you have a method to get a connection to your database
             try{
                 PreparedStatement statement = connection.prepareStatement(sql);
                     
            
            // Set parameters for the query
            statement.setString(1, nameProduct);
            statement.setString(2, color);
            
            // Execute the query
            ResultSet resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    // Get the link_picture from the result set
                    linkPicture = resultSet.getString("link_picture");
                }
            }
         catch (SQLException e) {
            e.printStackTrace();
        }
        
        return linkPicture;  // Return the link_picture or null if not found
    }
    public static void main(String[] args) {
        DAOProduct d = new DAOProduct();
        System.out.println(d.getAverageStarRatingTotal());
    }

}
