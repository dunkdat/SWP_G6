/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.NewsGroup;

/**
 *
 * @author ADMIN
 */
public class DAONewsGroup extends DBContext {

    public Vector<NewsGroup> getAllNewsGroup() {
        String sql = "select * from NewsGroup ";
        Vector<NewsGroup> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                NewsGroup newgroup = new NewsGroup(
                        rs.getInt("id"),
                        rs.getString("newsGroupName")
                );
                list.add(newgroup);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
}
