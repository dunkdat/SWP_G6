/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.Order;

/**
 *
 * @author Lenovo
 */
public class DAODashboard extends DBContext {
      DAOOrder daoOrrder = new DAOOrder();
     public Vector<Order> getAllOrder(String startDate, String endDate) {
         String sql = "SELECT * FROM badminton_shop.orders where Date(createAt) >= '"+startDate+"' \n"
                 + "and Date(createAt) <= '"+endDate+"';";
        Vector<Order> list = new Vector<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) 
                {
                    list.add(new Order(
                            rs.getInt("id"),
                            rs.getString("address"),
                            rs.getString("status"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            daoOrrder.getAllOrderItem(rs.getInt("id")),
                            rs.getDate("createAt"),
                            rs.getDate("reciverAt"),
                            rs.getDate("cancelAt"))
                    );
                }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    } 
}
