/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Login;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DAT
 */
public class UserDAO extends DBContext{
    public List<User> getAllUser() {
        List<User> t = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Users";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User x = new User(rs.getInt("id"), rs.getString("name"), rs.getString("address"), rs.getInt("gender"), rs.getString("phone"), rs.getString("username"), rs.getString("password"), rs.getString("role"),rs.getString("status"));
                t.add(x);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return t;
    }
    public void addUser(User x){
        try{
            String sql = "insert Users(name, address, gender, phone, username, password, role) values(?,?,?,?,?,?,?);";
            PreparedStatement   statement = connection.prepareStatement(sql);
            statement.setString(1, x.getName());
            statement.setString(2, x.getAddress());
            statement.setInt(3, x.getGender());
            statement.setString(4, x.getPhone());
            statement.setString(5, x.getEmail());
            statement.setString(6, x.getPassword());
            statement.setString(7, x.getRole());
            statement.executeUpdate();
        }catch(SQLException ex){
            System.err.println("");
        }
    }
    public void changePassword(String email, String newpassword){
        try{
            String sql = "update Users set password = ? where username = ?;";
            PreparedStatement   statement = connection.prepareStatement(sql);
            statement.setString(1, newpassword);
            statement.setString(2, email);
            statement.executeUpdate();
        }catch(SQLException ex){
            System.err.println("");
        }
    }
    public boolean existedEmail(String email){
        try{
            String sql = "select * from Users where username = ?";
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
    public static void main(String[] args) {
        UserDAO x = new UserDAO();
        x.addUser(new User("Dat", "Minh Khai",1,"0962906982", "datnb258@gmail.com","1234","customer"));
    }
}
