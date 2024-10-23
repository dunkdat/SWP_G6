/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAT
 */
public class Products {
    String id, name, category, brand;
    float price;
    String color;
    int size, quantity, salePercent;
    String details, link_picture,status;
    public int getSalePercent() {
        return salePercent;
    }

    public Products(String id, String name, String category, String brand, float price, String color, int size, int quantity, String link_picture) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.price = price;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
        this.link_picture = link_picture;
    }

    public void setSalePercent(int salePercent) {
        this.salePercent = salePercent;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    

    public Products() {
    }

    public Products(String id, String name, String category, String brand, float price, String color, int size, int quantity, String details, String link_picture) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.price = price;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
        this.details = details;
        this.link_picture = link_picture;
    }
    public Products(String id, String name, String category, String brand, float price, String color, int size, int quantity, String details, String link_picture,String status, int salePercent) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.price = price;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
        this.details = details;
        this.link_picture = link_picture;
        this.status = status;
        this.salePercent = salePercent;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getLink_picture() {
        return link_picture;
    }

    public void setLink_picture(String link_picture) {
        this.link_picture = link_picture;
    }

    @Override
    public String toString() {
        return "Products{" + "id=" + id + ", name=" + name + ", category=" + category + ", brand=" + brand + ", price=" + price + ", color=" + color + ", size=" + size + ", quantity=" + quantity + ", salePercent=" + salePercent + ", details=" + details + ", link_picture=" + link_picture + ", status=" + status + '}';
    }
    
    
}