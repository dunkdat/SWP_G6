/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Lenovo
 */
public class Address {
    private int id, user_id;
    private String city, district, ward, detail;

    public Address(int id, int user_id, String city, String district, String ward, String detail) {
        this.id = id;
        this.user_id = user_id;
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.detail = detail;
    }

    public Address(String city, String district, String ward, String detail, int user_id) {
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.detail = detail;
        this.user_id = user_id;
    }

    public Address(int id, String city, String district, String ward, String detail) {
        this.id = id;
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.detail = detail;
    }

    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    @Override
    public String toString() {
        return "Address{" + "id=" + id + ", user_id=" + user_id + ", city=" + city + ", district=" + district + ", ward=" + ward + ", detail=" + detail + '}';
    }
}
