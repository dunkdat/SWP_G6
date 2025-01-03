/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import constant.IConstant;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import model.Order;
import model.OrderItem;
import model.OrderManager;
import model.Products;

/**
 *
 * @author Lenovo
 */
public class DAOOrder extends DBContext{
    public int insertOrder(Order order) {
        String sql = "INSERT INTO `badminton_shop`.`orders`\n"
                + "(`customer_id`,\n"
                + "`shipper_id`,\n"
                + "`address`,\n"
                + "`status`,\n"
                + "`name`,\n"
                + "`phone`, `createAt`)\n"
                + "VALUES\n"
                + "(?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setInt(1, order.getCustomer_id());
            st.setInt(2, order.getShipper_id());
            st.setString(3, order.getAddress());
            st.setString(4, order.getStatus());
            st.setString(5, order.getName());
            st.setString(6, order.getPhone());
            st.setTimestamp(7, Timestamp.valueOf(getFormatDate()));
            int affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try ( ResultSet generatedKeys = st.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
            return -1;
        }
    }
      public String getFormatDate() {
        LocalDateTime myDateObj = LocalDateTime.now();  
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
        String formattedDate = myDateObj.format(myFormatObj);  
        return formattedDate;
   }
    public void insertOrderItem(Vector<Products> list, int orderId) {
        String sql = "INSERT INTO `badminton_shop`.`orderitem`\n"
                + "(`product_id`,\n"
                + "`price`,\n"
                + "`quantity`,\n"
                + "`orderId`)\n"
                + "VALUES\n"
                + "(?, ?, ?, ?);";
        try {
            for (Products item : list) {
                PreparedStatement st = connection.prepareStatement(sql);
                 st.setString(1, item.getId());
                 st.setDouble(2, item.getPrice());
                 st.setInt(3, item.getQuantity());
                 st.setInt(4, orderId);
                st.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public void getRated(String product_id, int orderId, int star) {
        String sql = "update `badminton_shop`.`orderitem`\n"
                + "set `getRated` = ?\n"
                + "WHERE product_id = ? and orderId = ?";
        try {
                PreparedStatement st = connection.prepareStatement(sql);
                 st.setInt(1, star);
                 st.setString(2, product_id);
                 st.setInt(3, orderId);
                st.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public float getShipPriceOfOrder(int orderId){
        String query = "SELECT s.price FROM Orders o " +
                       "JOIN Shippers s ON o.shipper_id = s.id " +
                       "WHERE o.id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, orderId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getFloat("price");
                } 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public Vector<Order> getAllOrderByCus(int cusId) {
        String sql = "Select * FROM `badminton_shop`.`orders` where customer_id = ?";
        Vector<Order> list = new Vector<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, cusId);
            ResultSet rs = pre.executeQuery();
           
            while (rs.next()) 
                {
                    list.add(new Order(
                            rs.getInt("id"),
                            rs.getString("address"),
                            rs.getString("status"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            getAllOrderItem(rs.getInt("id")),
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
    DAOProduct daoPro = new DAOProduct();
    
    public Vector<OrderItem> getAllOrderItem(int orderId) {
        String sql = "Select * FROM `badminton_shop`.`orderitem` where orderId = ?";
        Vector<OrderItem> list = new Vector<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderId);
            ResultSet rs = pre.executeQuery();
            
            while (rs.next()) {
                list.add(new OrderItem(
                           rs.getInt("id") , 
                     rs.getInt("quantity"),
                        rs.getDouble("price"), 
                     daoPro.getProductById(rs.getString("product_id")), rs.getInt("getRated")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    } 
    
    public List<OrderManager> getAllOrders(int page, int pageSize, String service, String service2, String service3, String statusOrder, String querry4) {
        List<OrderManager> orders = new ArrayList<>();

        try {
            int offset = (page - 1) * pageSize;

            // Thay đổi query sử dụng LIMIT và OFFSET của MySQL
            String query = "SELECT o.id, c.email AS mail, c.phone, o.createAt, o.status, o.customer_id, "
                    + "SUM(oi.quantity * p.price) AS totalAmount "
                    + "FROM orders o "
                    + "JOIN users c ON o.customer_id = c.id "
                    + "JOIN orderitem oi ON o.id = oi.orderId "
                    + "JOIN products p ON oi.product_id = p.id "
                    + " WHERE o.status LIKE N'%"+statusOrder+"%' "
                    + service2 + service3+querry4
                    + " GROUP BY o.id, c.email, c.phone, o.createAt, o.status, o.customer_id "
                    + "ORDER BY " + service + " o.id " // Thêm sắp xếp
                    + " LIMIT ? OFFSET ?;"; // Sử dụng LIMIT và OFFSET
System.out.println("qqqq "+query);
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, pageSize); // Số lượng bản ghi muốn lấy
                statement.setInt(2, offset);   // Vị trí bắt đầu
                try ( ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int orderId = resultSet.getInt("id");
                        int customerId = resultSet.getInt("customer_id");
                        String mail = resultSet.getString("mail");
                        String phone = resultSet.getString("phone");
                        double total = resultSet.getDouble("totalAmount");
                        String status = resultSet.getString("status");

                        Timestamp orderDateTimestamp = resultSet.getTimestamp("createAt");
                        java.util.Date utilDate = new java.util.Date(orderDateTimestamp.getTime());
                        SimpleDateFormat desiredFormat = new SimpleDateFormat("dd/MM/yyyy");
                        String formattedDate = desiredFormat.format(utilDate);

                        orders.add(new OrderManager(
                                orderId, mail, phone, formattedDate, 
                                total, status, customerId)
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }
    
    public List<OrderManager> getAllOrders() {
        List<OrderManager> orders = new ArrayList<>();
        try {
            String query = "SELECT id, customer_id, phone, createAt, status"
                    + " FROM orders";
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                try ( ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int orderId = resultSet.getInt("id");
                        int customerId = resultSet.getInt("customer_id");

                        String phone = resultSet.getString("phone");

                        String orderDate = resultSet.getString("creatAt");

                        double total = findTotalPrice(orderId);
                        String status = resultSet.getString("status");
                        orders.add(new OrderManager(orderId, phone, 
                                orderDate, total, status, customerId));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }
    
     public double findTotalPrice(int orderId) {
        double rs = 0;
        try {
            String query = "SELECT price, quantity "
                    + "FROM orderitem WHERE orderId = ?";
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, orderId);
                try ( ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        double price = resultSet.getDouble("price");
                        int quantity = resultSet.getInt("quantity");
                        rs += quantity * price;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rs;
    }
     
     //lấy tổng tất cả trang của orderManager
    public int getTotalPagesDetails(int pageSize, int orderId) {
        try {

            String query = "SELECT COUNT(*) as total FROM orderitem WHERE orderId = ? "; // Đếm số lượng đơn hàng
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, orderId);
                try ( ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        int totalOrders = resultSet.getInt("total");
                        return (int) Math.ceil((double) totalOrders / pageSize);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    
    //lấy tổng tất cả trang của orderManager
    public int getTotalPages(int pageSize, String querry) {
        try {

            String query = "SELECT COUNT(*) as total FROM orders " + querry; // Đếm số lượng đơn hàng
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                try ( ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        int totalOrders = resultSet.getInt("total");
                        return (int) Math.ceil((double) totalOrders / pageSize);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public void deleteOrder(int orderId) {
        deleteOrderItems(orderId);
        try {
            String query = "DELETE FROM orders WHERE id = ?";
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, orderId);
                int affectedRows = statement.executeUpdate();

                // Kiểm tra xem có bao nhiêu dòng bị ảnh hưởng (đã bị xóa)
                if (affectedRows > 0) {
                    System.out.println(affectedRows + " row(s) deleted successfully.");
                } else {
                    System.out.println("No rows deleted. The specified orderId may not exist.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteOrderItems(int orderId) {
        try {
            String query = "DELETE FROM orderitem WHERE orderId = ?";
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, orderId);
                int affectedRows = statement.executeUpdate();

                // Kiểm tra xem có bao nhiêu dòng bị ảnh hưởng (đã bị xóa)
                if (affectedRows > 0) {
                    System.out.println(affectedRows + " row(s) deleted successfully.");
                } else {
                    System.out.println("No rows deleted. The specified orderId may not exist.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean changeStatusBank(int orderId) {
        String sql = "UPDATE `badminton_shop`.`orders`\n"
                + "SET `status` = ?\n"
                + " WHERE id = ?";
        try {
                PreparedStatement st = connection.prepareStatement(sql);
                 st.setString(1, "Chờ xác nhận");
                 st.setInt(3, orderId);
                return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    } 
    // hàm sửa status
    public boolean changeStatus(int orderId, String status) {
        try {
            String query = "UPDATE `badminton_shop`.`orders`\n"
                + "SET `status` = ?\n"
                + " WHERE id = ?";
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, status);
                statement.setInt(2, orderId);
                return statement.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
      // hàm filter
    public List<OrderManager> getAllOrdersFilterDateAndWord(String fromDate, String toDate) {
        List<OrderManager> orders = new ArrayList<>();

        try {
            String query = "SELECT o.id, o.createAt, c.email AS mail, c.phone, o.createAt, o.status, o.customer_id "
                    + "FROM orders o "
                    + "JOIN users c ON o.customer_id = c.customer_id " // Chú ý điều chỉnh trường join
                    + "WHERE c.name LIKE '%' "
                    + "  AND (o.createAt BETWEEN ? AND ?)";

            try (PreparedStatement statement = connection.prepareStatement(query)) {

                statement.setString(1, fromDate);
                statement.setString(2, toDate);
                try ( ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int orderId = resultSet.getInt("id");
                        String mail = resultSet.getString("mail");
                        String phone = resultSet.getString("phone");
                        int customerId = resultSet.getInt("customer_id");

                        String orderDate = resultSet.getString("createAt");

                        double total = findTotalPrice(orderId);
                        String status = resultSet.getString("status");
                        orders.add(new OrderManager(orderId, mail, phone, orderDate, total, status, customerId));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;

    }
    
     public List<OrderItem> getAllOrdersDetail(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        DAOProduct daoPro = new DAOProduct();
        try {
            String query = " Select od.id, od.price, od.quantity, p.color, p.id as proId, p.category,"
                    + " p.name, p.link_picture from orderitem od\n"
                    + " join orders o on o.id = od.orderId\n"
                    + " join users u on u.id = o.customer_id\n"
                    + " join products p on p.id = od.product_id\n"
                    + " where o.id = ?";
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, orderId);
                try ( ResultSet rs = statement.executeQuery()) {
                    while (rs.next()) {
                       Products pro = daoPro.getProductById(rs.getString("proId"));
                        orderItems.add(new OrderItem(rs.getInt("id"), 
                                rs.getInt("quantity"), rs.getDouble("price"), pro, rs.getInt("getRated")));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }
     
      public Order getOrdersByOid(int orderId) {
        try {
            String query = "SELECT * FROM orders  where id = ?";
            try ( PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, orderId);
                try ( ResultSet rs = statement.executeQuery()) {
                    while (rs.next()) {
                       return  new Order(rs.getInt("id"), 
                               rs.getString("address"), 
                               rs.getString("status"), 
                               rs.getString("name"), 
                               rs.getString("phone"), null,
                               rs.getTimestamp("createAt"),
                               rs.getTimestamp("reciverAt"),
                               rs.getTimestamp("cancelAt"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
       public int getPendingOrderCount(){
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Chờ xác nhận' AND createAt >= ?";
        
        // Lấy ngày hiện tại và tính ngày 7 ngày trước
        LocalDate sevenDaysAgo = LocalDate.now().minusDays(7);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, sevenDaysAgo.format(formatter));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về tổng số đơn hàng
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
                
        return 0;
    }
       public int getConfirmOrderCount(){
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Đã xác nhận' AND createAt >= ?";
        
        // Lấy ngày hiện tại và tính ngày 7 ngày trước
        LocalDate sevenDaysAgo = LocalDate.now().minusDays(7);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, sevenDaysAgo.format(formatter));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về tổng số đơn hàng
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
                
        return 0;
    }
       public int getCancelOrderCount(){
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Đã hủy' AND createAt >= ?";
        
        // Lấy ngày hiện tại và tính ngày 7 ngày trước
        LocalDate sevenDaysAgo = LocalDate.now().minusDays(7);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, sevenDaysAgo.format(formatter));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về tổng số đơn hàng
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
                
        return 0;
    }
       public int getSoldCount(){
        String query = "SELECT COUNT(*) FROM orders WHERE status = 'Đã giao' AND createAt >= ?";
        
        // Lấy ngày hiện tại và tính ngày 7 ngày trước
        LocalDate sevenDaysAgo = LocalDate.now().minusDays(7);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, sevenDaysAgo.format(formatter));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về tổng số đơn hàng
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
                
        return 0;
    }
       public double getTotalRevenueInLast7Days() {
        double totalRevenue = 0;

        // SQL query để tính tổng doanh thu từ các đơn hàng 'Đã giao' trong 7 ngày gần đây
        String query = "SELECT oi.price, oi.quantity " +
                       "FROM orderitem oi " +
                       "JOIN orders o ON oi.orderId = o.id " +
                       "WHERE o.status = 'Đã giao' AND o.createAt >= ?";

        // Tính ngày 7 ngày trước từ ngày hiện tại
        LocalDate sevenDaysAgo = LocalDate.now().minusDays(7);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            // Đặt giá trị cho parameter là ngày 7 ngày trước
            statement.setString(1, sevenDaysAgo.format(formatter));

            try (ResultSet resultSet = statement.executeQuery()) {
                // Duyệt qua các kết quả để tính tổng doanh thu
                while (resultSet.next()) {
                    double price = resultSet.getDouble("price");
                    int quantity = resultSet.getInt("quantity");
                    totalRevenue += price * quantity;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalRevenue;
    }
        public List<Integer> getOrderCountInLast7Days() {
    List<Integer> orderCountList = new ArrayList<>();

    // SQL query để lấy tổng số đơn hàng của từng ngày trong 7 ngày gần nhất, bao gồm cả ngày hôm nay
    String sql = "SELECT DATE(o.createAt) as date, COUNT(*) as total_orders " +
                 "FROM orders o " +
                 "WHERE o.createAt >= CURDATE() - INTERVAL 6 DAY " + // Thay đổi từ 7 thành 6 để bao gồm ngày hôm nay
                 "GROUP BY DATE(o.createAt) " +
                 "ORDER BY DATE(o.createAt)";

    try (PreparedStatement statement = connection.prepareStatement(sql)) {
        ResultSet rs = statement.executeQuery();

        // Khởi tạo một mảng 7 phần tử với giá trị mặc định là 0
        for (int i = 0; i < 7; i++) {
            orderCountList.add(0);
        }

        // Lấy ngày hiện tại
        LocalDate currentDate = LocalDate.now();
        
        // Duyệt qua kết quả query
        while (rs.next()) {
            LocalDate date = rs.getDate("date").toLocalDate();
            int totalOrders = rs.getInt("total_orders");

            // Tính khoảng cách giữa ngày hiện tại và ngày trong result set
            int daysAgo = (int) currentDate.minusDays(6).until(date).getDays(); // Chỉnh từ 7 thành 6
            
            // Cập nhật tổng số đơn hàng cho ngày đó trong danh sách
            if (daysAgo >= 0 && daysAgo < 7) {
                orderCountList.set(daysAgo, totalOrders);
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return orderCountList;
}

        public List<Integer> getSuccessOrderCountInLast7Days() {
        List<Integer> orderCountList = new ArrayList<>();

        // SQL query để lấy tổng số đơn hàng của từng ngày trong 7 ngày gần nhất
        String sql = "SELECT DATE(o.createAt) as date, COUNT(*) as total_orders " +
                     "FROM orders o " +
                     "WHERE o.status = 'Đã giao' AND o.createAt >= CURDATE() - INTERVAL 6 DAY " +
                     "GROUP BY DATE(o.createAt) " +
                     "ORDER BY DATE(o.createAt)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();

            // Khởi tạo một mảng 7 phần tử với giá trị mặc định là 0
            for (int i = 0; i < 7; i++) {
                orderCountList.add(0);
            }

            // Lấy ngày hiện tại
            LocalDate currentDate = LocalDate.now();
            
            // Duyệt qua kết quả query
            while (rs.next()) {
                LocalDate date = rs.getDate("date").toLocalDate();
                int totalOrders = rs.getInt("total_orders");

                // Tính khoảng cách giữa ngày hiện tại và ngày trong result set
                int daysAgo = (int) currentDate.minusDays(6).until(date).getDays();
                
                // Cập nhật tổng số đơn hàng cho ngày đó trong danh sách
                if (daysAgo >= 0 && daysAgo < 7) {
                    orderCountList.set(daysAgo, totalOrders);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderCountList;
    }
        public int getTotalSoldQuantity() {
        int totalQuantity = 0;
        String sql = "SELECT SUM(quantity) AS totalQuantity FROM orderitem";

        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                totalQuantity = resultSet.getInt("totalQuantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalQuantity;
    }
    public String getDate(Timestamp orderDateTimestamp) {
        java.util.Date utilDate = new java.util.Date(orderDateTimestamp.getTime());
        SimpleDateFormat desiredFormat = new SimpleDateFormat("dd/MM/yyyy");
        String formattedDate = desiredFormat.format(utilDate);
        return formattedDate;
    }
     public Map<String, Integer> getSoldQuantityByCategory() {
        Map<String, Integer> soldQuantityByCategory = new HashMap<>();
        String sql = """
                SELECT c.id AS category, SUM(oi.quantity) AS total_sold
                FROM orderItem oi
                JOIN Products p ON oi.product_id = p.id
                JOIN Categories c ON p.category = c.id
                WHERE p.status = 'active' AND c.status = 'active'
                GROUP BY c.id;
                """;

        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                String category = resultSet.getString("category");
                int totalSold = resultSet.getInt("total_sold");
                soldQuantityByCategory.put(category, totalSold);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return soldQuantityByCategory;
    }
    public static void main(String[] args) {
        // Create an instance of DAOOrder
        DAOOrder daoOrder = new DAOOrder();
        
         Map<String, Integer> soldQuantityByCategory = daoOrder.getSoldQuantityByCategory();
            for (Map.Entry<String, Integer> entry : soldQuantityByCategory.entrySet()) {
                System.out.println("Category: " + entry.getKey() + ", Total Sold Quantity: " + entry.getValue());
            }
    }
}
