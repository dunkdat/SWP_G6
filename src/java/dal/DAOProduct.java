/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Products;
import model.Review;

/**
 *
 * @author DAT
 */
public class DAOProduct extends DBContext {

    public List<Products> getAllProducts() {
        List<Products> t = new ArrayList<>();
        String sql = "SELECT p.*\n"
                + "FROM Products p\n"
                + "INNER JOIN (\n"
                + "    SELECT name, MIN(id) AS min_id\n"
                + "    FROM Products\n"
                + "    GROUP BY name\n"
                + ") AS unique_products\n"
                + "ON p.id = unique_products.min_id\n";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                t.add(new Products(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("brand"),
                        rs.getFloat("price"),
                        rs.getString("color"),
                        rs.getInt("size"),
                        rs.getInt("quantity"),
                        rs.getString("details"),
                        rs.getString("link_picture")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return t;
    }

   public List<Products> getAllProduct(String category, String brand, String lowPrice, String highPrice, String searchQuery, int limit, int offset) {
    List<Products> productList = new ArrayList<>();
    try {
        // Start building the SQL query
        StringBuilder sql = new StringBuilder("SELECT p.*\n"
                + "FROM Products p\n"
                + "INNER JOIN (\n"
                + "    SELECT name, MIN(id) AS min_id\n"
                + "    FROM Products\n"
                + "    GROUP BY name\n"
                + ") AS unique_products\n"
                + "ON p.id = unique_products.min_id\n"
                + "WHERE category = ?");

        // Add brand filter if provided
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND brand = ?");
        }

        // Add price filter if both lowPrice and highPrice are provided
        if (lowPrice != null && highPrice != null) {
            sql.append(" AND price BETWEEN ? AND ?");
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
        st.setString(1, category);

        int paramIndex = 2; // Start index for optional parameters

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
                    rs.getString("link_picture")
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
            "SELECT COUNT(*) \n" +
            "FROM Products p \n" +
            "INNER JOIN ( \n" +
            "    SELECT name, MIN(id) AS min_id \n" +
            "    FROM Products \n" +
            "    GROUP BY name \n" +
            ") AS unique_products \n" +
            "ON p.id = unique_products.min_id \n" +
            "WHERE p.category = ?"
        );

        // Add brand filter if provided
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
        st.setString(1, category);

        int paramIndex = 2;

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

public List<Integer> getProductSizesByNameAndColor(String productName, String color) {
        List<Integer> sizes = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Establish a connection to the database (Assuming you have a method to get a connection)
            
            // SQL query to fetch all sizes for a product with the specified name and color
            String query = "SELECT size FROM Products WHERE name = ? AND color = ? and quantity > 0";
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
                        rs.getString("link_picture"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public float getAverageStarRating(String productId) {
        float averageRating = 0;
        String sql = "SELECT AVG(star_rating) as average_rating FROM Reviews WHERE product_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, productId);
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

    public List<Review> getProductReviews(String productId) {
        List<Review> reviews = new ArrayList<>();

        // SQL query joining Reviews with Users to get customer name
        String sql = "SELECT r.product_id, r.customer_id, r.star_rating, r.comment, r.review_date, u.name AS customer_name "
                + "FROM Reviews r "
                + "JOIN Users u ON r.customer_id = u.id "
                + "WHERE r.product_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, productId);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                // Extract data from ResultSet and create a new Review object
                Review review = new Review(
                        rs.getString("product_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("star_rating"),
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
        String sql = "SELECT DISTINCT color FROM Products WHERE name = ?";
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
        String sql = "SELECT p.*\n"
                + "FROM Products p\n"
                + "INNER JOIN (\n"
                + "    SELECT name, MIN(id) AS min_id\n"
                + "    FROM Products\n"
                + "    GROUP BY name\n"
                + ") AS unique_products\n"
                + "ON p.id = unique_products.min_id\n"
                + "limit ? offset ?";
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
        String sql = "SELECT count(*) \n"
                + "FROM Products p\n"
                + "INNER JOIN (\n"
                + "    SELECT name, MIN(id) AS min_id\n"
                + "    FROM Products\n"
                + "    GROUP BY name\n"
                + ") AS unique_products\n"
                + "ON p.id = unique_products.min_id\n";
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
        String sql = "SELECT count(*) \n"
                + "FROM Products p\n"
                + "INNER JOIN (\n"
                + "    SELECT name, MIN(id) AS min_id\n"
                + "    FROM Products\n"
                + "    GROUP BY name\n"
                + ") AS unique_products\n"
                + "ON p.id = unique_products.min_id\n"
                + "where category = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, cat);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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
        List<Integer> sizes = d.getProductSizesByNameAndColor("Victor A620", "gray");
        for (Integer color : sizes) {
            System.out.println(color);
        }
        int totalProducts = d.getTotalProducts("racket");
        System.out.println(d.getProductLinkPicture("Victor A620", "gray"));
        int totalPages = (int) Math.ceil((double) totalProducts / 12);
        System.out.println(totalPages);
    }

}
