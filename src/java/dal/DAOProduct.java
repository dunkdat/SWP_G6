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

/**
 *
 * @author DAT
 */
public class DAOProduct extends DBContext{
    public List<Products> getAllProduct(String category, String brand, String lowPrice, String highPrice) {
    List<Products> t = new ArrayList<>();
    try {
        StringBuilder sql = new StringBuilder("SELECT p.*\n" +
"FROM Products p\n" +
"INNER JOIN (\n" +
"    SELECT name, MIN(id) AS min_id\n" +
"    FROM Products\n" +
"    GROUP BY name\n" +
") AS unique_products\n" +
"ON p.id = unique_products.min_id\n" +
"where category = ?");
        
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
    public static void main(String[] args) {
        DAOProduct d = new DAOProduct();
        for(Products p : d.getAllProduct("grip","yonex","0","50")){
            System.out.println(p.getName());
        }
    }
}
