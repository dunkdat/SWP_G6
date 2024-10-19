package model;
import java.util.Date;

public class Review {
    private String productId;
    private int customerId;
    private int starRating;
    private String comment;
    private String customerName; // New field for customer name
    private Date reviewDate;

    public Review(String productId, int customerId, int starRating, String comment, String customerName, Date reviewDate) {
        this.productId = productId;
        this.customerId = customerId;
        this.starRating = starRating;
        this.comment = comment;
        this.customerName = customerName;
        this.reviewDate = reviewDate;
    }

    // Getters and Setters
    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
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

