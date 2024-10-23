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
import model.Role;

/**
 *
 * @author DAT
 */
public class DAORole extends DBContext {

    public List<Role> getAllRoleQuantities() {
        List<Role> roleQuantities = new ArrayList<>();
        String query = "SELECT r.id , r.details , r.status, COUNT(u.id) AS employee\n"
                + "FROM Role r\n"
                + "LEFT JOIN Users u ON r.id = u.role \n"
                + "GROUP BY r.id, r.details "
                + " HAVING r.details != 'Admin';";

        try (
                PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String roleId = rs.getString("id");
                String roleDetails = rs.getString("details");
                String roleStatus = rs.getString("status");
                int totalQuantity = rs.getInt("employee");

                // Create a new roleQuantity object to store the result
                Role roleQuantity = new Role(roleId, roleDetails, roleStatus, totalQuantity);
                roleQuantities.add(roleQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roleQuantities;
    }

    public List<Role> getAllRoleQuantities(String status, String query, int offset, int limit) {
        List<Role> roleQuantities = new ArrayList<>();

        // Tạo câu truy vấn động
        StringBuilder sql = new StringBuilder("SELECT r.id, r.details, r.status, COUNT(u.id) AS employee "
                + "FROM Role r "
                + "LEFT JOIN Users u ON r.id = u.role "
                + "WHERE r.details != 'Admin'");

        // Thêm điều kiện cho status nếu có
        if (status != null && !status.isEmpty()) {
            sql.append(" AND r.status = ?");
        }

        // Thêm điều kiện cho query (tìm kiếm theo tên hoặc chi tiết) nếu có
        if (query != null && !query.isEmpty()) {
            sql.append(" AND r.id LIKE ?");
        }

        // Thêm GROUP BY để nhóm theo ID và chi tiết vai trò
        sql.append(" GROUP BY r.id, r.details LIMIT ? OFFSET ?");

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
            ps.setInt(parameterIndex++, limit);
            ps.setInt(parameterIndex++, offset);
            // Thực hiện truy vấn
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String roleId = rs.getString("id");
                String roleDetails = rs.getString("details");
                String roleStatus = rs.getString("status");
                int totalQuantity = rs.getInt("employee");

                // Tạo đối tượng Role và thêm vào danh sách
                Role roleQuantity = new Role(roleId, roleDetails, roleStatus, totalQuantity);
                roleQuantities.add(roleQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roleQuantities;
    }

    public List<Role> getAllRoles() {
        List<Role> roleQuantities = new ArrayList<>();
        String query = "Select * from Role where status = 'active' and id != 'Admin' and id != 'Customer'";

        try (
                PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String roleId = rs.getString("id");
                String roleDetails = rs.getString("details");
                String roleStatus = rs.getString("status");

                // Create a new roleQuantity object to store the result
                Role roleQuantity = new Role(roleId, roleDetails, roleStatus);
                roleQuantities.add(roleQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roleQuantities;
    }

    public int countAllRoles() {
        String query = "SELECT COUNT(*) AS role_count FROM Role";
        int count = 0;

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("role_count");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public int countAllRoles(String status, String query) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) AS role_count FROM Role WHERE 1=1");

        // Thêm điều kiện cho status nếu có
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }

        // Thêm điều kiện cho query nếu có
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
                ps.setString(parameterIndex++, "%" + query + "%"); // Sử dụng LIKE để tìm kiếm chuỗi con
            }

            // Thực hiện truy vấn
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("role_count");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public boolean addRole(String id, String details) {
        String query = "INSERT INTO Role (id, details) VALUES (?, ?)";

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

    public boolean updateRole(String id, String newDetails, String newStatus) {
        String query = "UPDATE Role SET details = ?, status = ? WHERE id = ?";

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

    public boolean updateUsers(String status, String role) {
        String query = "UPDATE Users SET status = ? WHERE role = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setString(2, role);
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

    public boolean deleteRole(String id) {
        String query = "DELETE FROM Role WHERE id = ?";

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

    public boolean deleteUsersWithRole(String role) {
        String query = "delete from Users WHERE role = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, role);
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

    public static void main(String[] args) {
        DAORole d = new DAORole();
        for (Role r : d.getAllRoleQuantities("admin", "a", 0, 10)) {
            System.out.println(r.getId());
        }
    }
}
