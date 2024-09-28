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

    public List<Products> getAllProduct(String category, String brand, String lowPrice, String highPrice) {
        List<Products> t = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT p.*\n"
                    + "FROM Products p\n"
                    + "INNER JOIN (\n"
                    + "    SELECT name, MIN(id) AS min_id\n"
                    + "    FROM Products\n"
                    + "    GROUP BY name\n"
                    + ") AS unique_products\n"
                    + "ON p.id = unique_products.min_id\n"
                    + "where category = ?");

            // Add brand filter if not null
            if (brand != null && !brand.isEmpty()) {
                sql.append(" AND brand = ?");
            }

            // Add price filter if not null
            if (lowPrice != null && highPrice != null) {
                sql.append(" AND price BETWEEN ? AND ?");
            }

            PreparedStatement st = connection.prepareStatement(sql.toString());
            st.setString(1, category);

            int paramIndex = 2;  // Start index for additional parameters

            if (brand != null && !brand.isEmpty()) {
                st.setString(paramIndex++, brand);
            }

            if (lowPrice != null && highPrice != null) {
                st.setFloat(paramIndex++, Float.parseFloat(lowPrice));
                st.setFloat(paramIndex, Float.parseFloat(highPrice));
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products x = new Products(
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
                t.add(x);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return t;
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
    String sql = "SELECT r.product_id, r.customer_id, r.star_rating, r.comment, r.review_date, u.name AS customer_name " +
                 "FROM Reviews r " +
                 "JOIN Users u ON r.customer_id = u.id " +
                 "WHERE r.product_id = ?";
    
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
    public static void main(String[] args) {
        DAOProduct d = new DAOProduct();
        List<String> sizes = d.getShoesSize();
        for (String color : sizes) {
            System.out.println("Available color: " + color);
        }
        System.out.println(d.getProductById("R001-B").getName());
    }

}
