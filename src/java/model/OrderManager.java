/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.List;


/**
 *
 * @author Mr Viet
 */
public class OrderManager implements Comparable<OrderManager> {

    int orderId;
    int customerId;
    String email;
    String phone;
    String orderDate;
    double total;
    String status;

    public OrderManager(int orderId, String email, String phone, String orderDate, double total, String status, int customerId) {
        this.orderId = orderId;
        this.phone = phone;
        this.orderDate = orderDate;
        this.total = total;
        this.status = status;
        this.email = email;
        this.customerId = customerId;
    }

    public OrderManager(int orderId, String phone, String orderDate, double total, String status, int customerId) {
        this.orderId = orderId;
        this.phone = phone;
        this.orderDate = orderDate;
        this.total = total;
        this.status = status;
        this.customerId = customerId;
    }
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public int compareTo(OrderManager otherOrder) {
        // Mặc định sắp xếp theo thứ tự tăng dần của total
        return Double.compare(this.total, otherOrder.getTotal());
    }

    // Phương thức sắp xếp theo thứ tự giảm dần của total
    public int compareToDescByTotal(OrderManager otherOrder) {
        return Double.compare(otherOrder.getTotal(), this.total);
    }

    // Phương thức sắp xếp theo thứ tự tăng dần của orderDate
    public int compareToAscByOrderDate(OrderManager otherOrder) {
        return compareByOrderDate(this.getOrderDate(), otherOrder.getOrderDate());
    }

    // Phương thức sắp xếp theo thứ tự giảm dần của orderDate
    public int compareToDescByOrderDate(OrderManager otherOrder) {
        return compareByOrderDate(otherOrder.getOrderDate(), this.getOrderDate());
    }

    public static void sortByTotalAscending(List<OrderManager> orderList) {
        Collections.sort(orderList);
    }

    public static void sortByTotalDescending(List<OrderManager> orderList) {
        orderList.sort(OrderManager::compareToDescByTotal);
    }

    public static void sortByOrderDateAscending(List<OrderManager> orderList) {
        Collections.sort(orderList, OrderManager::compareToAscByOrderDate);
    }

    public static void sortByOrderDateDescending(List<OrderManager> orderList) {
        orderList.sort(OrderManager::compareToDescByOrderDate);
    }

    private int compareByOrderDate(String date1, String date2) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            java.util.Date thisOrderDate = dateFormat.parse(date1);
            java.util.Date otherOrderDate = dateFormat.parse(date2);

            return thisOrderDate.compareTo(otherOrderDate);
        } catch (ParseException e) {
            e.printStackTrace();
            return 0;
        }
    }

}
//

/*
  public static void main(String[] args) {
        List<OrderManager> orderList = new ArrayList<>();
        // Thêm các đối tượng OrderManager vào danh sách

        // Sắp xếp danh sách theo orderDate (tăng dần)
        Collections.sort(orderList);

        // Sắp xếp danh sách theo orderDate (giảm dần)
        Collections.sort(orderList, OrderManager::compareToDesc);

        // Sắp xếp danh sách theo email (tăng dần)
        Collections.sort(orderList, OrderManager::compareToByEmail);

        // Sắp xếp danh sách theo email (giảm dần)
        Collections.sort(orderList, OrderManager::compareToByEmailDesc);

        // In danh sách đã sắp xếp
        for (OrderManager order : orderList) {
            System.out.println("Order ID: " + order.getOrderId() + ", Email: " + order.getEmail());
            // In các thông tin khác nếu cần
        }
 */
