/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import java.util.ArrayList;
import model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author DAT
 */
public class DAOCategory extends DBContext{
    public List<Category> getAllCategoryQuantities() {
        List<Category> categoryQuantities = new ArrayList<>();
        String query = "SELECT c.id, c.details, COALESCE(SUM(p.quantity), 0) AS total_quantity, c.status " +
                       "FROM C c " +
                       "LEFT JOIN Products p ON c.id = p.category " +
                       "GROUP BY c.id, c.details, c.status";

        try (
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String categoryId = rs.getString("id");
                String categoryDetails = rs.getString("details");
                int totalQuantity = rs.getInt("total_quantity");
                String categoryStatus = rs.getString("status");

                // Create a new CategoryQuantity object to store the result
                Category categoryQuantity = new Category(categoryId, categoryDetails, totalQuantity,categoryStatus);
                categoryQuantities.add(categoryQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categoryQuantities;
    }
    public List<Category> getAllCategory() {
        List<Category> categoryQuantities = new ArrayList<>();
        String query = "SELECT * from Categories where status = 'active'";

        try (
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String categoryId = rs.getString("id");
                String categoryDetails = rs.getString("details");
                String categoryStatus = rs.getString("status");
                // Create a new CategoryQuantity object to store the result
                Category categoryQuantity = new Category(categoryId, categoryDetails,categoryStatus);
                categoryQuantities.add(categoryQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categoryQuantities;
    }
    public List<Category> getAllCategoryQuantities(int offset, int limit) {
        List<Category> categoryQuantities = new ArrayList<>();
        String query = "SELECT c.id, c.details, COALESCE(SUM(p.quantity), 0)AS total_quantity, c.status  " +
                       "FROM Categories c " +
                       "LEFT JOIN Products p ON c.id = p.category " +
                       "GROUP BY c.id, c.details, c.status limit ? offset ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String categoryId = rs.getString("id");
                String categoryDetails = rs.getString("details");
                int totalQuantity = rs.getInt("total_quantity");
                String categoryStatus = rs.getString("status");
                // Create a new CategoryQuantity object to store the result
                Category categoryQuantity = new Category(categoryId, categoryDetails, totalQuantity,categoryStatus);
                categoryQuantities.add(categoryQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categoryQuantities;
    }
    public List<Category> getAllCategoryQuantities(String status, String query, int offset, int limit) {
    List<Category> categoryQuantities = new ArrayList<>();
    
    // Tạo câu truy vấn động
    StringBuilder sql = new StringBuilder("SELECT c.id, c.details, COALESCE(SUM(p.quantity), 0) AS total_quantity, c.status " +
                                          "FROM Categories c " +
                                          "LEFT JOIN Products p ON c.id = p.category " +
                                          "WHERE 1=1");
    
    // Thêm điều kiện cho status nếu có
    if (status != null && !status.isEmpty()) {
        sql.append(" AND c.status = ?");
    }

    // Thêm điều kiện cho query (tìm kiếm theo tên hoặc chi tiết) nếu có
    if (query != null && !query.isEmpty()) {
        sql.append(" AND c.id LIKE ?");
    }

    // Thêm GROUP BY và phân trang
    sql.append(" GROUP BY c.id, c.details, c.status LIMIT ? OFFSET ?");

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
        int parameterIndex = 1;

        // Gán giá trị cho tham số status nếu có
        if (status != null && !status.isEmpty()) {
            ps.setString(parameterIndex++, status);
        }

        // Gán giá trị cho tham số query nếu có
        if (query != null && !query.isEmpty()) {
            ps.setString(parameterIndex++, "%" + query + "%"); // Sử dụng LIKE để tìm kiếm chuỗi con
        }

        // Gán giá trị cho limit và offset
        ps.setInt(parameterIndex++, limit);
        ps.setInt(parameterIndex++, offset);

        // Thực hiện truy vấn
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String categoryId = rs.getString("id");
            String categoryDetails = rs.getString("details");
            int totalQuantity = rs.getInt("total_quantity");
            String categoryStatus = rs.getString("status");
            
            // Tạo đối tượng Category và thêm vào danh sách
            Category categoryQuantity = new Category(categoryId, categoryDetails, totalQuantity, categoryStatus);
            categoryQuantities.add(categoryQuantity);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return categoryQuantities;
}
    public boolean addCategory(String id, String details) {
        String query = "INSERT INTO Categories (id, details) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, id);
            ps.setString(2, details);

            // Execute the insert query
            int rowsAffected = ps.executeUpdate();

            // If rowsAffected is greater than 0, the category was added successfully
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Return false if there was an error
        return false;
    }
    public boolean updateCategory(String id, String newDetails, String newStatus) {
    String query = "UPDATE Categories SET details = ?, status = ? WHERE id = ?";

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, newDetails);
        ps.setString(2, newStatus);
        ps.setString(3, id);
        // Execute the update query
        int rowsAffected = ps.executeUpdate();

        // If rowsAffected is greater than 0, the category was updated successfully
        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Return false if there was an error
    return false;
}
    public boolean updateProducts(String status, String category) {
    String query = "UPDATE Products SET status = ? WHERE category = ?";

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, status);
        ps.setString(2, category);
        // Execute the update query
        int rowsAffected = ps.executeUpdate();

        // If rowsAffected is greater than 0, the category was updated successfully
        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Return false if there was an error
    return false;
}
public boolean deleteCategory(String id) {
    String query = "DELETE FROM Categories WHERE id = ?";
                    

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, id);
        // Execute the delete query
        int rowsAffected = ps.executeUpdate();

        // If rowsAffected is greater than 0, the category was deleted successfully
        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Return false if there was an error
    return false;
}
public boolean deleteCategoryWithProducts(String category) {
    String query = "delete from Products WHERE category = ?";
                    

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, category);
        // Execute the delete query
        int rowsAffected = ps.executeUpdate();

        // If rowsAffected is greater than 0, the category was deleted successfully
        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Return false if there was an error
    return false;
}
    public int countAllCategories() {
        String query = "SELECT COUNT(*) AS category_count FROM Categories";
        int count = 0;

        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("category_count");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
    public int countAllCategories(String status, String query) {
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS category_count FROM Categories WHERE 1=1");
    
    // Thêm điều kiện nếu status có giá trị
    if (status != null && !status.isEmpty()) {
        sql.append(" AND status = ?");
    }

    // Thêm điều kiện nếu query (tên) có giá trị
    if (query != null && !query.isEmpty()) {
        sql.append(" AND id LIKE ?");
    }

    int count = 0;

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
        int parameterIndex = 1;

        // Gán giá trị cho tham số status nếu có
        if (status != null && !status.isEmpty()) {
            ps.setString(parameterIndex++, status);
        }

        // Gán giá trị cho tham số query nếu có
        if (query != null && !query.isEmpty()) {
            ps.setString(parameterIndex++, "%" + query + "%"); // Sử dụng LIKE để tìm kiếm
        }

        // Thực hiện truy vấn
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt("category_count");
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return count;
}

    public static void main(String[] args) {
        DAOCategory d = new DAOCategory();
        for(Category c : d.getAllCategoryQuantities()){
            System.out.println(c.getId());System.out.println(c.getInventory());
        }
    }
}

