package model;
import java.util.Date;

public class Review {
    private String id;
    private int customerId;
    private int starRating;
    String productName;
    private String comment;
    private String customerName; // New field for customer name
    private Date reviewDate;

    public Review(String id, int customerId, int starRating,String producName, String comment, String customerName, Date reviewDate) {
        this.id = id;
        this.customerId = customerId;
        this.starRating = starRating;
        this.productName = producName;
        this.comment = comment;
        this.customerName = customerName;
        this.reviewDate = reviewDate;
    }

    public Review(String id, int customerId, int starRating, String productName, String comment, Date reviewDate) {
        this.id = id;
        this.customerId = customerId;
        this.starRating = starRating;
        this.productName = productName;
        this.comment = comment;
        this.reviewDate = reviewDate;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getStarRating() {
        return starRating;
    }

    public void setStarRating(int starRating) {
        this.starRating = starRating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }
}
