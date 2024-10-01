/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.protocol.Resultset;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;
import util.Encode;

/**
 *
 * @author Lenovo
 */
public class DAOUser extends DBContext{
    
            Encode e = new Encode();
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
                        rs.getString("detail"),
                        rs.getString("imagePath"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    public User getUserByEmail(String email) {
        User cus = null;
        String sql = "SELECT * FROM Users WHERE email = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt("id"), 
                        rs.getString("name"),
                        rs.getString("address"), 
                        rs.getInt("gender"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("role"),
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
            pre.setString(2, e.toSHA1(password));
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt("id"), 
                        rs.getString("name"),
                        rs.getString("address"), 
                        rs.getInt("gender"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("imagePath"),
                        rs.getString("detail"));
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
    public List<User> getAllUser() {
        List<User> t = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Users";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User x = new User(rs.getInt("id"), rs.getString("name"), rs.getString("address"), rs.getInt("gender"), rs.getString("phone"), rs.getString( "email"), rs.getString("password"), rs.getString("role"),rs.getString("status"));
                t.add(x);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return t;
    }
     public void updateUser(int id,String newRole, String newStatus) {
        String sql = "UPDATE Users SET status = ?, role = ? WHERE id = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, newStatus);  // Set new status (either 'online' or 'offline')
            preparedStatement.setString(2, newRole);
            preparedStatement.setInt(3, id);        // Set user ID

            // Execute the update
           preparedStatement.executeUpdate();
            
            // Return true if one or more rows were updated
        } catch (SQLException e) {
            System.out.println("Error updating user status: " + e.getMessage());
        }

    }
     public void deleteUser(int id) {
        String sql = "Delete from Users WHERE id = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, id);        // Set user ID

            // Execute the update
           preparedStatement.executeUpdate();
            
            // Return true if one or more rows were updated
        } catch (SQLException e) {
            System.out.println("Error updating user status: " + e.getMessage());
        }

    }
    public List<User> getAllSatff() {
        List<User> t = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Users where role = 'Staff' or role = 'Staff Manager'";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User x = new User(rs.getInt("id"), 
                        rs.getString("name"), 
                        rs.getString("address"), 
                        rs.getInt("gender"), 
                        rs.getString("phone"), 
                        rs.getString( "email"),
                        rs.getString("role"),
                        rs.getString("status"), 
                        rs.getString("imagePath"),
                        rs.getString("detail"));
                t.add(x);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return t;
    }
    public void addUser(User x){
        try{
            String sql = "insert Users(name, address, gender, phone, email, password, role, status,imagePath) values(?,?,?,?,?,?,?,'inactive',? );";
            PreparedStatement   statement = connection.prepareStatement(sql);
            statement.setString(1, x.getName());
            statement.setString(2, x.getAddress());
            statement.setInt(3, x.getGender());
            statement.setString(4, x.getPhone());
            statement.setString(5, x.getEmail());
            statement.setString(6, x.getPassword());
            statement.setString(7, x.getRole());
            statement.setString(8, x.getImagePath());
            statement.executeUpdate();
        }catch(SQLException ex){
            System.err.println("");
        }
    }
    
    public void changePassword(String email, String newpassword){
        try{
            String sql = "update Users set password = ? where email = ?;";
            PreparedStatement   statement = connection.prepareStatement(sql);
            statement.setString(1, e.toSHA1(newpassword));
            statement.setString(2, email);
            statement.executeUpdate();
        }catch(SQLException ex){
            System.err.println("");
        }
    }
    public boolean existedEmail(String email){
        try{
            String sql = "select * from Users where email = ?";
            PreparedStatement   statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                  return true;
                 
            }
            
        }catch(SQLException ex){
            System.err.println("");
        }
        return false;
    }
    public boolean existedPhone(String phone){
        try{
            String sql = "select * from Users where phone = ?";
            PreparedStatement   statement = connection.prepareStatement(sql);
            statement.setString(1, phone);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                  return true;
                 
            }
            
        }catch(SQLException ex){
            System.err.println("");
        }
        return false;
    }
    public static void main(String[] args) {
    DAOUser daoUser = new DAOUser();
Encode e = new Encode();

    // Create one staff manager
    User manager = new User("Chu Quang Dang", null, 1, "0912333546", "chuquangdang04@gmail.com", e.toSHA1("333"), "Staff", "dvbvb at.jpg");
    daoUser.addUser(manager);
        
}

}
