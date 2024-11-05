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
import model.Address;
import model.Review;

/**
 *
 * @author Lenovo
 */
public class DAOAddress extends DBContext{
    
    public List<Address> getAddressOfUser(int userId) {
        List<Address> list = new ArrayList<>();
        String sql = "SELECT * from orderAddress where user_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userId);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                Address address = new Address(
                        rs.getInt("id"),
                        rs.getString("city"),
                        rs.getString("district"),
                        rs.getString("ward"),
                        rs.getString("detail")
                );
                list.add(address);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public void deleteAddress(int id) {
        List<Address> list = new ArrayList<>();
        String sql = "Delete from orderAddress where id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    
    public boolean isExistAddressOfUser(int userId, Address add) {
        String sql = "SELECT * from orderAddress where user_id = ? and city = ? and district = ? and ward = ? and detail = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userId);
            pre.setString(2, add.getCity());
            pre.setString(3, add.getDistrict());
            pre.setString(4, add.getWard());
            pre.setString(5, add.getDetail());
            
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    
    public boolean insertAddress(Address add) {
        String sql = "INSERT INTO `badminton_shop`.`orderaddress`\n"
                + "(`city`,\n"
                + "`district`,\n"
                + "`ward`,\n"
                + "`detail`,\n"
                + "`user_id`)\n"
                + "VALUES(?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, add.getCity());
            pre.setString(2, add.getDistrict());
            pre.setString(3, add.getWard());
            pre.setString(4, add.getDetail());
            pre.setInt(5, add.getUser_id());
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}
