/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author Lenovo
 */
public class Order {
    private String address, status, name, phone;
    private int id, customer_id, shipper_id;
    private Date createAt, reciverAt, cancelAt;
    
    private List<OrderItem> orders;

    public Order() {
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getReciverAt() {
        return reciverAt;
    }

    public void setReciverAt(Date reciverAt) {
        this.reciverAt = reciverAt;
    }

    public Date getCancelAt() {
        return cancelAt;
    }

    public void setCancelAt(Date cancelAt) {
        this.cancelAt = cancelAt;
    }

    public Order(int id, String address, String status, String name, String phone, List<OrderItem> orders, Date createAt, Date reciverAt, Date cancelAt) {
        this.id = id;
        this.address = address;
        this.status = status;
        this.name = name;
        this.phone = phone;
        this.orders = orders;
        this.createAt = createAt;
        this.reciverAt = reciverAt;
        this.cancelAt = cancelAt;
    }

    public Order(int id, String address, String status, int customer_id, int shipper_id) {
        this.id = id;
        this.address = address;
        this.status = status;
        this.customer_id = customer_id;
        this.shipper_id = shipper_id;
    }

    public Order(String address, String status, String name, String phone, int customer_id, int shipper_id) {
        this.address = address;
        this.status = status;
        this.name = name;
        this.phone = phone;
        this.customer_id = customer_id;
        this.shipper_id = shipper_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<OrderItem> getOrders() {
        return orders;
    }

    public void setOrders(List<OrderItem> orders) {
        this.orders = orders;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getShipper_id() {
        return shipper_id;
    }

    public void setShipper_id(int shipper_id) {
        this.shipper_id = shipper_id;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", address=" + address + ", status=" + status + ", name=" + name + ", phone=" + phone + ", customer_id=" + customer_id + ", shipper_id=" + shipper_id + '}';
    }

}
