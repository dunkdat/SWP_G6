/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Login;

/**
 *
 * @author DAT
 */
public class User {
    int id;
    String name, address;
    int gender;
    String phone, email, password, role, status;

    public User() {
    }

    public User(int id, String name, String address, int gender, String phone, String email, String password, String role, String status) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    public User(String name, String address, int gender, String phone, String email, String password, String role) {
        this.name = name;
        this.address = address;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
