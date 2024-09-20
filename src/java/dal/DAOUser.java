/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.protocol.Resultset;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 *
 * @author Lenovo
 */
public class DAOUser extends DBContext{
    public User getUserById(int user_id) {
        User cus = null;
        String sql = "SELECT * FROM Users join Role on Users.role = Role.id\n"
                + "WHERE Users.id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user_id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt("id"), 
                        rs.getString("name"),
                        rs.getString("address"), 
                        rs.getInt("gender"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("details"),
                        rs.getString("imagePath"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    
     public User ValidateUsers(String email, String password) {
        String sql = "SELECT * FROM Users\n"
                + "WHERE email = ? and password = ?";
        try {
           PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, email);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt("id"), 
                        rs.getString("name"),
                        rs.getString("address"), 
                        rs.getInt("gender"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("detail"),
                        rs.getString("imagePath"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public boolean updateCustomer(User user) {
        int n = 0;
        String sql = "UPDATE `badminton_shop`.`users`\n"
                + "SET\n"
                + "`name` = ?,\n"
                + "`address` = ?,\n"
                + "`gender` = ?,\n"
                + "`phone` = ?,\n"
                + "`imagePath` = ?\n"
                + "WHERE `id` = ?;";
        try ( PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, user.getName());
            pre.setString(2, user.getAddress());
            pre.setInt(3, user.getGender());
            pre.setString(4, user.getPhone());
            pre.setString(5, user.getImagePath());
            pre.setInt(6, user.getId());
           return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    public boolean updatePassword(String newPassword, int userId) {
        String sql = "UPDATE Users\n"
                + " SET password = ?\n"
                + " WHERE id = ?";
        int n = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setInt(2, userId);
            n = st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n > 0;
    }
}
