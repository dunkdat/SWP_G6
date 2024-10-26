/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Lenovo
 */
import model.Products;

/**
 *
 * @author Lenovo
 */
public class OrderItem {
    private int id, productId, quantity, getRated;
    private double price;
    private Products products;

    public OrderItem() {
    }

    public OrderItem(int id, int quantity, double price, Products products, int getRated) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.products = products;
        this.getRated = getRated;
    }

    public int getGetRated() {
        return getRated;
    }

    public void setGetRated(int getRated) {
        this.getRated = getRated;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Products getProducts() {
        return products;
    }

    public void setProducts(Products products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "OrderItem{" + "id=" + id + ", productId=" + productId + ", quantity=" + quantity + ", price=" + price + ", products=" + products + '}';
    }
    
    
}
