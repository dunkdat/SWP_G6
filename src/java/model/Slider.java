/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAT
 */
public class Slider {
    String id, pro_id, details, link_thumnail, status;

    public Slider() {
    }

    public Slider(String id, String pro_id, String details, String link_thumnail, String status) {
        this.id = id;
        this.pro_id = pro_id;
        this.details = details;
        this.link_thumnail = link_thumnail;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPro_id() {
        return pro_id;
    }

    public void setPro_id(String pro_id) {
        this.pro_id = pro_id;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getLink_thumnail() {
        return link_thumnail;
    }

    public void setLink_thumnail(String link_thumnail) {
        this.link_thumnail = link_thumnail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
