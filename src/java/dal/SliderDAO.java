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
import model.Slider;

/**
 *
 * @author DAT
 */
public class SliderDAO extends DBContext{
    public List<Slider> getAllSlider() {
        List<Slider> t = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Slider";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Slider x = new Slider(rs.getString("id"), rs.getString("product_id"), rs.getString("details"), rs.getString("link_thumnail"), rs.getString("status"));
                t.add(x);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return t;
    }
    public static void main(String[] args) {
        SliderDAO p = new SliderDAO();
        for(Slider k : p.getAllSlider()){
            if(k.getStatus().equals("active")){
                System.out.println(k.getLink_thumnail());
            }
        }
    }
}
