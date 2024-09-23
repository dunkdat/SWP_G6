/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class NewsGroup {
    private int newsGroupId;
    private String newsGroupName;

    public NewsGroup() {
    }

    public NewsGroup(int newsGroupId, String newsGroupName) {
        this.newsGroupId = newsGroupId;
        this.newsGroupName = newsGroupName;
    }

    public int getNewsGroupId() {
        return newsGroupId;
    }

    public void setNewsGroupId(int newsGroupId) {
        this.newsGroupId = newsGroupId;
    }

    public String getNewsGroupName() {
        return newsGroupName;
    }

    public void setNewsGroupName(String newsGroupName) {
        this.newsGroupName = newsGroupName;
    }

    @Override
    public String toString() {
        return "NewsGroup{" + "newsGroupId=" + newsGroupId + ", newsGroupName=" + newsGroupName + '}';
    }
    
}
    
