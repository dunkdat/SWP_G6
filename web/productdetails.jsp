<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="constant.*" %>
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
        <!-- Header Section -->
        <header class="header collapsed">
            <div class="left-section">
                <a href="homepage"><img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px;"></a>
                <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
                <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
            </div>
            <div class="right-section">
            <div class="icons">
    <a href="ProfileServlet?current_user=${sessionScope.current_user}">
        <c:if test="${current_user == null}">
            <img src="images/profile.png" alt="Account" >
            </c:if>
        <c:if test="${current_user != null}">
            <c:if test="${current_user.imagePath == null}">
                <img src="images/profile.png" alt="Account" class="avatar">
            </c:if>
                <c:if test="${current_user.imagePath != null}">
                 <img src="${IConstant.PATH_USER}/${current_user.imagePath}" alt="Account" class="avatar">   
            </c:if>
            
        </c:if>
    </a>
        <c:if test="${current_user != null}">
            <div class="dropdown-content">
                <c:if test="${current_user.imagePath != null}">
                    <img src="${IConstant.PATH_USER}/${current_user.imagePath}" alt="Avatar" class="dropdown-avatar">
            </c:if>
             
        <a href="ProfileServlet?current_user=${sessionScope.current_user}">
            Profile
        </a>
        <a href="logout">Logout</a>
    </div>
        </c:if>
    
    <c:if test="${current_user.role == 'Customer'}">
        <img src="images/cart.png" alt="Cart">
    </c:if>
</div>
        </div>
        </header>

        <div class="toggle-button" onclick="toggleNavbar()">☰</div>

        <!-- Navbar -->
        <nav class="navbar hidden" id="navbar">
            <div class="logo">Online Shop</div>
            <div class="dropdown">
                <a href="homepage">Home</a>
            </div>
            <div class="dropdown">
                <a href="#">Category</a> <!-- Mục "Category" chính -->
                <div class="dropdown-content">
                    <a href="productlist">All</a>
                    <c:forEach items="${requestScope.categoryList}" var="n">
                        <a href="productlist?category=${n.id}">${n.id.toUpperCase()}</a>
                    </c:forEach>
                </div></div>
                <c:if test="${current_user.role == 'Staff'}">
                    <div class="dropdown">
                        <a href="dashboard?role=${current_user.role}">Dashboard</a>

                    </div>
                    <div class="dropdown">

                        <a href="staffproductlist">Products List</a>  
                    </div>
                    <div class="dropdown">

                        <a href="onsale">On Sale Product</a>
                    </div>

                </c:if>
                <c:if test="${current_user.role == 'Admin'}">
                    <div class="dropdown">
                        <a href="dashboard?role=${current_user.role}">Dashboard</a>

                    </div>
                    <div class="dropdown">

                        <a href="userlist">User Management</a>
                
                    </div>
                    <div class="dropdown">

                        <a href="settinglist">Setting Management</a>
                    </div>

                </c:if>
            
        </nav>

        <div class="content collapsed" id="content">
            <section class="hero">
                <h1>${product.name}</h1>
                <p>Find everything you need to know about ${product.name} below.</p>
            </section>
            <section class="nav-bar">
                <a href="homepage">Home Page</a>
                <a href="salelist">Sale</a>
                <a href="#">Voucher</a>
                <a href="aboutus.jsp">About Us</a>
                <a href="contact.jsp">Contact</a>
            </section>
            <!-- Main Product Details Section -->
            <div class="product-details-section">
                <div></div>
                <div class="product-images">
                    <!-- Change picture here -->
                    <img src="${product.link_picture}" alt="${product.name}">
                </div>
                <div class="product-info">
                    <h2>${product.name}</h2>
                    <p style="color: red">
    <strong style="color: black; font-weight: bold;">Price:</strong>
    <c:if test="${product.salePercent > 0}">
        <span style="text-decoration: line-through; color:grey; font-size: 14px;">$<fmt:formatNumber value="${product.price + (product.price * product.salePercent / 100)}" minFractionDigits="2" maxFractionDigits="2" /></span>
        <span style="font-size: 24px; font-weight: bold;">
            $<fmt:formatNumber value="${product.price}" minFractionDigits="2" maxFractionDigits="2" />
        </span>
        <span style="color: green;">(${product.salePercent}% off)</span>
    </c:if>
    <c:if test="${product.salePercent == 0}">
        <span>${product.price}</span>
    </c:if>
</p>
                    <p><strong>Description:</strong> ${product.details}</p>

                    <!-- Add to Cart Section -->
                    <form action="cart" method="post">
                        <input type="hidden" id="product-type" value="${product.category}">
                        <input name="Service" value="addToCart" hidden/>
                        <div class="quantity-wrapper">
                            <label for="quantity" style="font-weight: bold;">Quantity:</label>
                            <div class="quantity-control">
                                <button type="button" class="quantity-btn" onclick="changeQuantity(-1)">-</button>
                                <input type="input" id="quantity" name="quantity" value="1" min="1" max="10">
                                <button type="button" class="quantity-btn" onclick="changeQuantity(1)">+</button>
                            </div>
                        </div>
                        <!-- Color Selection Section -->
                        <div class="color-wrapper" ${product.category != "shuttlecock" ? '' : 'hidden'}>
                            <label for="color" style="font-weight: bold;">Choose color: </label>
                            <div class="color-options">
                                <c:forEach items="${requestScope.colors}" var="color">
                                    <div class="color-box" style="background-color: ${color};" 
                                         onclick="selectColor('${color}')"></div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Size Selection Section -->
                        <c:if test="${product.category.equals('shoes')}">
                            <div class="size-wrapper">

                                <div class="size-options" id="size-options">
                                    <!-- Size options will be loaded here via AJAX -->
                                </div>
                                <input type="hidden" name="size" id="selected-size" value="">
                            </div>
                        </c:if>
                        <!-- Hidden fields for color and product name -->
                        <input type="hidden" name="color" id="selected-color" value="">
                        <input type="hidden" name="pid" value="${product.id}">
                        <input type="hidden" name="name" value="${product.name}">
                        <!-- Add to Cart Button -->
                        <button type="submit" class="add-to-cart-btn" id="add-to-cart-button">Add to Cart</button>
                    </form>
                </div>

                <!-- Promotions Section -->
                <section class="product-promotions">
    <h3>Promotions and Special Offers</h3>
    <ul>
        <li>✔ Receive 2 free racket grips: VNB 001, VS002, or Joto 001</li>
        <li>✔ Guaranteed authentic product</li>
        <li>✔ Some products come with a single cover or velvet racket protector</li>
        <li>✔ Pay after inspection and receiving the item (Frame only delivery)</li>
        <li>✔ Official warranty from the manufacturer (Excluding domestic or hand-carried goods)</li>
    </ul>
    <h4>🎁 Additional Benefits at VNB Premium:</h4>
    <ul>
        <li>✅ Free racket logo painting</li>
        <li>✅ 72-hour string warranty</li>
        <li>✅ Free lifetime racket grommet replacement</li>
        <li>✅ Earn Premium membership points</li>
        <li>✅ Discount voucher for the next purchase</li>
    </ul>
</section>
        </div>
        <!-- Product Description and Feedback Section -->
        <div class="product-description-feedback">
            <!-- Product Description -->
            <section class="product-description">
    <h3>More About ${product.name}</h3>
    
    <c:choose>
        <c:when test="${product.category == 'racket'}">
            <p>Badminton rackets are designed with specific features to enhance a player's performance, offering a blend of power, control, and maneuverability.</p>
            <p><strong>Specifications:</strong></p>
            <ul>
                <li>Weight: 85g</li>
                <li>Balance Point: 295mm (Head-Heavy)</li>
                <li>Frame Material: High Modulus Graphite</li>
                <li>String Tension: 24-30 lbs</li>
            </ul>
            <p><strong>Strengths:</strong></p>
            <ul>
                <li>Provides excellent power for smashes</li>
                <li>Highly durable and lightweight construction</li>
                <li>Offers great stability and control during fast rallies</li>
            </ul>
            <p><strong>Play Style:</strong> This racket is designed for offensive players, with a head-heavy balance that aids in powerful smashes. It's ideal for players looking to dominate with aggressive shots, yet it offers enough control for defensive plays when needed.</p>
        </c:when>
        <c:when test="${product.category == 'shoes'}">
            <p>Badminton shoes are engineered to provide players with excellent grip, cushioning, and lateral support during quick movements on the court.</p>
            <p><strong>Specifications:</strong></p>
            <ul>
                <li>Weight: 300g</li>
                <li>Material: Breathable mesh and synthetic leather</li>
                <li>Sole: Non-marking rubber</li>
                <li>Special Feature: Enhanced ankle support</li>
            </ul>
            <p><strong>Strengths:</strong></p>
            <ul>
                <li>Provides excellent grip for quick footwork</li>
                <li>Lightweight and breathable material for comfort</li>
                <li>Durable sole with extra traction for improved stability</li>
            </ul>
            <p><strong>Play Style:</strong> These shoes are perfect for players looking for agility and speed on the court, while offering great cushioning for prolonged matches.</p>
        </c:when>
        <c:when test="${product.category == 'net'}">
            <p>Badminton nets are designed to meet official size requirements and offer durability for both indoor and outdoor play.</p>
            <p><strong>Specifications:</strong></p>
            <ul>
                <li>Length: 6.1 meters (20 feet)</li>
                <li>Material: Nylon with reinforced edges</li>
                <li>Height: 1.55 meters (5 feet 1 inch)</li>
                <li>Weather Resistance: Suitable for outdoor use</li>
            </ul>
            <p><strong>Strengths:</strong></p>
            <ul>
                <li>Durable material for long-term use</li>
                <li>Lightweight and easy to set up</li>
                <li>Weather-resistant for outdoor matches</li>
            </ul>
        </c:when>
            <c:when test="${product.category == 'grip'}">
            <p>Badminton racket grips provide players with improved comfort and control, reducing slippage during intense rallies.</p>
            <p><strong>Specifications:</strong></p>
            <ul>
                <li>Material: PU (Polyurethane) for extra tackiness</li>
                <li>Length: 1100mm</li>
                <li>Thickness: 0.75mm</li>
                <li>Special Feature: Sweat-absorbing and non-slip</li>
            </ul>
            <p><strong>Strengths:</strong></p>
            <ul>
                <li>Improves grip and comfort</li>
                <li>Absorbs sweat to reduce slippage</li>
                <li>Long-lasting and durable</li>
            </ul>
        </c:when>
        <c:when test="${product.category == 'backpack'}">
            <p>Badminton racket bags are designed to store and protect your equipment, providing space for rackets, shoes, and accessories.</p>
            <p><strong>Specifications:</strong></p>
            <ul>
                <li>Capacity: Fits up to 6 rackets</li>
                <li>Material: Water-resistant polyester</li>
                <li>Compartments: 2 main compartments, 1 shoe compartment</li>
                <li>Straps: Adjustable padded shoulder straps</li>
            </ul>
            <p><strong>Strengths:</strong></p>
            <ul>
                <li>Spacious design with multiple compartments</li>
                <li>Water-resistant material for added protection</li>
                <li>Padded straps for comfortable carrying</li>
            </ul>
        </c:when>
        <c:when test="${product.category == 'shuttlecock'}">
            <p>Badminton shuttlecocks are a vital part of the game, available in both feather and synthetic varieties, each offering different flight characteristics.</p>
            <p><strong>Specifications:</strong></p>
            <ul>
                <li>Type: Feather or Nylon</li>
                <li>Feather Material: Goose or duck feathers</li>
                <li>Cork Material: Natural or composite cork</li>
                <li>Flight Accuracy: High precision for consistent performance</li>
            </ul>
            <p><strong>Strengths:</strong></p>
            <ul>
                <li>Feather shuttlecocks offer better flight and speed control</li>
                <li>Synthetic shuttlecocks are more durable and cost-effective</li>
                <li>Accurate flight trajectory for professional play</li>
            </ul>
            <p><strong>Play Style:</strong> Feather shuttlecocks are preferred in competitive matches for their precise flight characteristics, while synthetic ones are ideal for training and casual play due to their durability.</p>
        </c:when>
        <c:otherwise>
            <p>Product information is currently unavailable.</p>
        </c:otherwise>
    </c:choose>
</section>
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
                            </c:when>
                    <c:otherwise>
                        <p>(No feedback yet)</p>
                    </c:otherwise>
                </c:choose>
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
            <div class="footer-content">
                <p>© 2024 Online Shop. All rights reserved.</p>
                <ul class="footer-links">
                    <li><a href="/privacy-policy">Privacy Policy</a></li>
                    <li><a href="/terms-of-service">Terms of Service</a></li>
                    <li><a href="/contact-us">Contact Us</a></li>
                    <li><a href="/about-us">About Us</a></li>
                </ul>
                <div class="social-media">
                    <a href="https://facebook.com" target="_blank">Facebook</a> |
                    <a href="https://twitter.com" target="_blank">Twitter</a> |
                    <a href="https://instagram.com" target="_blank">Instagram</a>
                </div>
            </div>
        </footer>

        <!-- JavaScript Section -->
        <script>
            const avatarElement = document.querySelector('.avatar');
if (avatarElement) {
    avatarElement.addEventListener('mouseover', function () {
        document.querySelector('.dropdown-content').style.display = 'block';
    });
}
            document.querySelector('.dropdown-content').addEventListener('mouseleave', function () {
                document.querySelector('.dropdown-content').style.display = 'none';
            });
            // Function to select a color
            // Function to select a color
            function changeQuantity(delta) {
                const quantityInput = document.getElementById('quantity');
                let currentQuantity = parseInt(quantityInput.value);
                const newQuantity = currentQuantity + delta;

                if (newQuantity >= 1 && newQuantity <= 10) {
                    quantityInput.value = newQuantity;
                }
            }
            function selectColor(color) {
    document.getElementById('selected-color').value = color;

    // UI feedback to show selected color
    const colorBoxes = document.querySelectorAll('.color-box');
    colorBoxes.forEach(box => box.classList.remove('selected'));
    event.target.classList.add('selected');

    // Gọi hàm để cập nhật ảnh sản phẩm dựa trên màu đã chọn
    loadProductImage(color);
    loadSizes(color);

    // Call to update the visibility of the Add to Cart button after color is selected
}

    // Hàm này gửi yêu cầu đến servlet để lấy ảnh tương ứng với màu đã chọn
            function loadProductImage(selectedColor) {
                const productName = "${product.name}"; // Lấy tên sản phẩm từ JSP
                const xhr = new XMLHttpRequest();
                const url = `GetColorOfProduct?color=` + selectedColor + `&name=` + productName;
                console.log(url);
                xhr.open('GET', url, true);

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        // Cập nhật ảnh sản phẩm trong div 'product-image-container'
                        document.querySelector('.product-images').innerHTML = xhr.responseText;
                    }
                };

                xhr.send();
            }

    // Function to load available sizes for the selected color (HTML format)
            function loadSizes(selectedColor) {
                const productName = "${product.name}"; // Get product name dynamically from JSP
                const xhr = new XMLHttpRequest();
                const url = `GetAvailableSizesServlet?color=` + selectedColor + `&name=` + productName;
                console.log(url); // Check if the URL is correct
                xhr.open('GET', url, true);

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        document.querySelector('.size-options').innerHTML = xhr.responseText; // Insert the HTML returned by the servlet
                    }
                };

                xhr.send();
            }
    // Function to select a size
    function selectSize(size) {
    // Update hidden input with selected size value
    document.getElementById('selected-size').value = size;

    // UI feedback to show selected size
    const sizeBoxes = document.querySelectorAll('.size-box');
    sizeBoxes.forEach(box => box.classList.remove('selected'));
    event.target.classList.add('selected');

    // Call to update the visibility of the Add to Cart button after size is selected
    updateAddToCartButtonVisibility();
}    
function updateAddToCartButtonVisibility() {
    const addToCartButton = document.getElementById('add-to-cart-button');
        const selectedColorInput = document.getElementById('selected-color');
        const selectedSizeInput = document.getElementById('selected-size');
        const productCategory = "${product.category}";

        // Initially hide the Add to Cart button
        addToCartButton.style.display = 'none';
            if (productCategory === 'shoes') {
                console.log(selectedColorInput.value);
                console.log(selectedSizeInput.value);
                // For shoes, show the button only if both color and size are selected
                if (selectedColorInput.value && selectedSizeInput.value) {
                    addToCartButton.style.display = 'block';
                } else {
                    addToCartButton.style.display = 'none';
                }
            } else {
                // For other products, show the button only if color is selected
                if (selectedColorInput.value) {
                    addToCartButton.style.display = 'block';
                } else {
                    addToCartButton.style.display = 'none';
                }
            }
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
             document.addEventListener('DOMContentLoaded', function () {
        const addToCartButton = document.getElementById('add-to-cart-button');
        const selectedColorInput = document.getElementById('selected-color');
        const selectedSizeInput = document.getElementById('selected-size');
        const productCategory = "${product.category}";

        // Initially hide the Add to Cart button
        addToCartButton.style.display = 'none';
       
        // Function to show the Add to Cart button if conditions are met
        function updateAddToCartButtonVisibility() {
            if (productCategory === 'shoes') {
                console.log(selectedColorInput.value);
                console.log(selectedSizeInput.value);
                // For shoes, show the button only if both color and size are selected
                if (selectedColorInput.value && selectedSizeInput.value) {
                    addToCartButton.style.display = 'block';
                } else {
                    addToCartButton.style.display = 'none';
                }
            } else {
                // For other products, show the button only if color is selected
                if (selectedColorInput.value) {
                    addToCartButton.style.display = 'block';
                } else {
                    addToCartButton.style.display = 'none';
                }
            }
        }

        // Add event listeners for color and size selection
        document.querySelectorAll('.color-box').forEach(function (colorBox) {
            colorBox.addEventListener('click', function () {
                updateAddToCartButtonVisibility();
            });
        });

        document.querySelectorAll('.size-box').forEach(function (sizeBox) {
            sizeBox.addEventListener('click', function () {
                updateAddToCartButtonVisibility();
            });
        });
    });
        </script>

    </body>
</html>
