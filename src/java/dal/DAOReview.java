/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.security.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author DAT
 */
public class DAOReview extends DBContext{
    public boolean addReview(int customerId, String productName, int starRating, String comment) {
        String sql = "INSERT INTO Reviews (customer_id, product_name, star_rating, comment) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, customerId);
            statement.setString(2, productName);
            statement.setInt(3, starRating);
            statement.setString(4, comment);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0; // Trả về true nếu chèn thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static void main(String[] args) {
        DAOReview r = new DAOReview();
        r.addReview(7, "Yonex Power Cushion 8900", 4, "adasdasd");
    }
}
