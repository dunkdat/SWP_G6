<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details - Online Shop</title>
    <link rel="stylesheet" href="css/productdetail.css"/>
</head>
<body>
    <!-- Copy the header and navbar from product list page -->
    <header class="header collapsed">
        <div class="left-section">
            <img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px;">
            <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
            <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
        </div>
        <div class="right-section">
            <div class="search-bar">
                <input type="text" placeholder="Tìm sản phẩm...">
                <span class="search-icon">🔍</span>
            </div>
            <div class="icons">
                <a href="ProfileServlet?current_user=${sessionScope.current_user}"><img src="images/profile.png" alt="Account"></a>
                <img src="images/cart.png" alt="Cart">
            </div>
        </div>
    </header>

    <div class="toggle-button" onclick="toggleNavbar()">☰</div>

    <nav class="navbar hidden" id="navbar">
        <div class="logo">Online Shop</div>
        <a href="homepage">Home</a>
        <a href="productlist?category=racket">Racket</a>
        <a href="productlist?category=shoes">Shoes</a>
        <a href="productlist?category=net">Net</a>
        <a href="productlist?category=grip">Grip</a>
        <a href="productlist?category=backpack">Back Pack</a>
        <a href="productlist?category=shuttlecock">Shuttlecock</a>
    </nav>

    <div class="content collapsed" id="content">
        <section class="hero">
            <h1>Product Details</h1>
            <p>Find everything you need to know about this product below.</p>
        </section>

        <!-- Main Product Details Section -->
        <div class="product-details-section">
            <div class="product-images">
                <img src="${product.link_picture}" alt="${product.name}">
            </div>
            <div class="product-info">
                <h2>${product.name}</h2>
                <p><strong>Price:</strong> ${product.price}</p>
                <p><strong>Description:</strong> ${product.details}</p>

                <!-- Add to Cart Section -->
                <form action="cart" method="post">
                    <!-- Quantity Section -->
                    <div class="quantity-wrapper">
                        <label for="quantity">Quantity:</label>
                        <div class="quantity-control">
                            <button type="button" class="quantity-btn" onclick="changeQuantity(-1)">-</button>
                            <input type="input" id="quantity" name="quantity" value="1" min="1" max="10">
                            <button type="button" class="quantity-btn" onclick="changeQuantity(1)">+</button>
                        </div>
                    </div>

                    <!-- Color Selection -->
                    <div class="color-wrapper">
                        <label>Select Color:</label>
                        <div class="color-options">
                            <c:forEach items="${requestScope.colors}" var="color">
                                <div class="color-box" style="background-color: ${color};" onclick="selectColor('${color}')"></div>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <input type="hidden" name="color" id="selected-color" value="">
                    <input type="hidden" name="productId" value="${product.id}">
                    <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- Product Description and Feedback Section -->
        <div class="product-description-feedback">
            <!-- Product Description -->
            <section class="product-description">
                <h3>More About ${product.name}</h3>
                <p>...</p> <!-- Assuming there is a long description for the product -->
            </section>

            <!-- Average Rating Display Section -->
            <section class="rating-display">
                <label>Average Rating:</label>
                <div class="stars">
                    <c:choose>
                        <c:when test="${averageRating > 0}">
                            <c:forEach var="i" begin="1" end="5">
                                <c:choose>
                                    <c:when test="${i <= averageRating}">
                                        <span class="star full">★</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="star empty">☆</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <span class="star empty">☆</span>
                            <span class="star empty">☆</span>
                            <span class="star empty">☆</span>
                            <span class="star empty">☆</span>
                            <span class="star empty">☆</span>
                            <p>(No ratings yet)</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <!-- Customer Feedback Section -->
            <section class="product-feedback">
                <h3>Customer Feedback</h3>
                <c:choose>
                    <c:when test="${not empty productReviews}">
                        <div class="customer-reviews">
                            <c:forEach items="${productReviews}" var="review">
                                <div class="review">
                                    <p><strong>${review.customerName}</strong> rated it ${review.starRating}/5</p>
                                    <p>${review.comment}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p>(No feedback yet)</p>
                    </c:otherwise>
                </c:choose>
            </section>
        </div>

        <section class="related-products">
            <h3>Related Products</h3>
            <div class="products">
                <c:forEach items="${relatedProducts}" var="relatedProduct">
                    <div class="product">
                        <img src="${relatedProduct.link_picture}" alt="${relatedProduct.name}">
                        <h4>${relatedProduct.name}</h4>
                        <p>${relatedProduct.price}</p>
                        <a href="productdetails?id=${relatedProduct.id}" class="view-details-btn">View Details</a>
                    </div>
                </c:forEach>
            </div>
        </section>
    </div>

    <footer class="footer">
        © 2024 Online Shop. All rights reserved.
    </footer>

    <script>
        // Function to handle quantity increment and decrement
        function changeQuantity(delta) {
            const quantityInput = document.getElementById('quantity');
            let currentQuantity = parseInt(quantityInput.value);
            const newQuantity = currentQuantity + delta;

            if (newQuantity >= 1 && newQuantity <= 10) {
                quantityInput.value = newQuantity;
            }
        }

        // Function to select a color
        function selectColor(color) {
            document.getElementById('selected-color').value = color;
            // Optionally add some UI feedback to show the selected color
            const colorBoxes = document.querySelectorAll('.color-box');
            colorBoxes.forEach(box => box.classList.remove('selected'));
            event.target.classList.add('selected');
        }
        function toggleNavbar() {
            const navbar = document.getElementById('navbar');
            const content = document.getElementById('content');
            const header = document.querySelector('.header');

            navbar.classList.toggle('hidden');
            navbar.classList.toggle('visible');
            content.classList.toggle('expanded');
            header.classList.toggle('expanded');
            content.classList.toggle('collapsed');
            header.classList.toggle('collapsed');
        }
    </script>
    
</body>
</html>
