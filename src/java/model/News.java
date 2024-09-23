/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class News {

    private int newsId;
    private String newsTitle;
    private String description;
    private String shortContent;
    private String adminName;
    private int newsGroupId;
    private String newsGroupName;
    private Date createDate;
    private Date modifiedDate;
    private int createBy;
    private int modifiedBy;
    private String imagePath;
    private int viewCount;
    private User admin;
    private long timeDifferenceInDays;

    public long getTimeDifferenceInDays() {
        return timeDifferenceInDays;
    }

    public void setTimeDifferenceInDays(long timeDifferenceInDays) {
        this.timeDifferenceInDays = timeDifferenceInDays;
    }

   

    public News() {
    }

    public User getAdmin() {
        return admin;
    }

    public void setAdmin(User admin) {
        this.admin = admin;
    }

    public News(int newsId, String newsTitle, String shortContent, String adminName, int newsGroupId, String newsGroupName, Date createDate, Date modifiedDate, int createBy, int modifiedBy, String imagePath) {
        this.newsId = newsId;
        this.newsTitle = newsTitle;
        this.shortContent = shortContent;
        this.adminName = adminName;
        this.newsGroupId = newsGroupId;
        this.newsGroupName = newsGroupName;
        this.createDate = createDate;
        this.modifiedDate = modifiedDate;
        this.createBy = createBy;
        this.modifiedBy = modifiedBy;
        this.imagePath = imagePath;
    }

    public News(int newsId, String newsTitle, String shortContent, String adminName, int newsGroupId, String newsGroupName, Date createDate, Date modifiedDate, int createBy, int modifiedBy, String imagePath, User admin) {
        this.newsId = newsId;
        this.newsTitle = newsTitle;
        this.shortContent = shortContent;
        this.adminName = adminName;
        this.newsGroupId = newsGroupId;
        this.newsGroupName = newsGroupName;
        this.createDate = createDate;
        this.modifiedDate = modifiedDate;
        this.createBy = createBy;
        this.modifiedBy = modifiedBy;
        this.imagePath = imagePath;
        this.admin = admin;

    }

    public News(int newsId, String newsTitle, String description, String adminName, int newsGroupId, String newsGroupName, Date createDate, int createBy, User admin) {
        this.newsId = newsId;
        this.newsTitle = newsTitle;
        this.description = description;
        this.adminName = adminName;
        this.newsGroupId = newsGroupId;
        this.newsGroupName = newsGroupName;
        this.createDate = createDate;
        this.createBy = createBy;
        this.admin = admin;
    }

    public News(int newsId, String newsTitle, String description, String shortContent, String adminName, int newsGroupId, String newsGroupName, Date createDate, Date modifiedDate, int createBy, int modifiedBy, String imagePath) {
        this.newsId = newsId;
        this.newsTitle = newsTitle;
        this.description = description;
        this.shortContent = shortContent;
        this.adminName = adminName;
        this.newsGroupId = newsGroupId;
        this.newsGroupName = newsGroupName;
        this.createDate = createDate;
        this.modifiedDate = modifiedDate;
        this.createBy = createBy;
        this.modifiedBy = modifiedBy;
        this.imagePath = imagePath;
    }

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getShortContent() {
        return shortContent;
    }

    public void setShortContent(String shortContent) {
        this.shortContent = shortContent;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
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

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    public int getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(int modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    @Override
    public String toString() {
        return "News{" + "newsId=" + newsId + ", newsTitle=" + newsTitle + ", description=" + description + ", shortContent=" + shortContent + ", adminName=" + adminName + ", newsGroupId=" + newsGroupId + ", newsGroupName=" + newsGroupName + ", createDate=" + createDate + ", modifiedDate=" + modifiedDate + ", createBy=" + createBy + ", modifiedBy=" + modifiedBy + ", imagePath=" + imagePath + ", admin=" + admin + '}';
    }

}
