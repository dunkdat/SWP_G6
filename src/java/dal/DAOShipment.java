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
import model.Shipper;

/**
 *
 * @author Lenovo
 */
public class DAOShipment extends DBContext{
    public List<Shipper> getAllShipper() {
        String sql = "SELECT * FROM Shippers";
        List<Shipper> list = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Shipper(rs.getInt("id"),
                        rs.getInt("price"),
                        rs.getString("type"),
                        rs.getString("name"),
                        rs.getString("company")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
}
