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
        <!-- Header Section -->
        <header class="header collapsed">
            <div class="left-section">
                <img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px;">
                <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
                <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
            </div>
            <div class="right-section">
                <div class="icons">
    <a href="ProfileServlet?current_user=${sessionScope.current_user}">
        <c:if test="${current_user == null}">
            <img src="images/profile.png" alt="Account" class="avatar">
        </c:if>
        <c:if test="${current_user != null}">
            <img src="images/User_img/${current_user.imagePath}" alt="Account" class="avatar">
        </c:if>
    </a>
        <c:if test="${current_user != null}">
            <div class="dropdown-content">
             <img src="images/User_img/${current_user.imagePath}" alt="Avatar" class="dropdown-avatar">
        <a href="ProfileServlet?current_user=${sessionScope.current_user}">
            Profile
        </a>
        <a href="logout">Logout</a>
    </div>
        </c:if>
    
    <img src="images/cart.png" alt="Cart">
</div>            </div>
        </header>

        <div class="toggle-button" onclick="toggleNavbar()">☰</div>

        <!-- Navbar -->
        <nav class="navbar hidden" id="navbar">
            <div class="logo">Online Shop</div>
            <div class="dropdown">
                <a href="homepage">Home</a>
            </div>
            <div class="dropdown">
                <a href="#">Category</a> <!-- Main Category -->
                <div class="dropdown-content">
                    <a href="productlist?category=racket">Racket</a>
                    <a href="productlist?category=shoes">Shoes</a>
                    <a href="productlist?category=net">Net</a>
                    <a href="productlist?category=grip">Grip</a>
                    <a href="productlist?category=backpack">Back Pack</a>
                    <a href="productlist?category=shuttlecock">Shuttlecock</a>
                </div>
            </div>
        </nav>

        <div class="content collapsed" id="content">
            <section class="hero">
                <h1>${product.name}</h1>
                <p>Find everything you need to know about ${product.name} below.</p>
            </section>
            <section class="nav-bar">
                <a href="homepage">Home Page</a>
                <a href="#">Sale</a>
                <a href="#">Voucher</a>
                <a href="aboutus.jsp">About Us</a>
                <a href="contact.jsp">Contact</a>
            </section>
            <!-- Main Product Details Section -->
            <div class="product-details-section">
                <div class="product-images">
                    <!-- Change picture here -->
                    <img src="${product.link_picture}" alt="${product.name}">
                </div>
                <div class="product-info">
                    <h2>${product.name}</h2>
                    <p style="color: red"><strong style="color: black; font-weight: bold;">Price:</strong>${product.price}</p>
                    <p><strong>Description:</strong> ${product.details}</p>

                    <!-- Add to Cart Section -->
                    <form action="cart" method="post">
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
                                <input type="hidden" name="selectedSize" id="selected-size" value="">
                            </div>
                        </c:if>
                        <!-- Hidden fields for color and product name -->
                        <input type="hidden" name="color" id="selected-color" value="">
                        <input type="hidden" name="name" value="${product.name}">

                        <!-- Add to Cart Button -->
                        <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                    </form>
                </div>

                <!-- Promotions Section -->
                <section class="product-promotions">
                    <h3>🎁 Promotions and Special Offers</h3>
                    <ul>
                        <li>Receive 2 free racket grips: VNB 001, VS002, or Joto 001</li>
                        <li>✅ Guaranteed authentic product</li>
                        <li>✅ Some products come with a single cover or velvet racket protector</li>
                        <li>✅ Pay after inspection and receiving the item (Frame only delivery)</li>
                        <li>✅ Official warranty from the manufacturer (Excluding domestic or hand-carried goods)</li>
                    </ul>

                    <h3>🎁 Additional Benefits at VNB Premium:</h3>
                    <ul>
                        <li>Free racket logo painting</li>
                        <li>✅ 72-hour string warranty</li>
                        <li>✅ Free lifetime racket grommet replacement</li>
                        <li>✅ Earn Premium membership points</li>
                        <li>✅ Discount voucher for the next purchase</li>
                    </ul>
                </section>
            </div>

            <!-- Related Products Section -->
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
            // Function to select a color
            // Function to select a color
            function selectColor(color) {
                document.getElementById('selected-color').value = color;

                // UI feedback to show selected color
                const colorBoxes = document.querySelectorAll('.color-box');
                colorBoxes.forEach(box => box.classList.remove('selected'));
                event.target.classList.add('selected');

                // Gọi hàm để cập nhật ảnh sản phẩm dựa trên màu đã chọn
                loadProductImage(color);
                loadSizes(color);

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
                document.getElementById('selected-size').value = size;

                // UI feedback to show selected size
                const sizeBoxes = document.querySelectorAll('.size-box');
                sizeBoxes.forEach(box => box.classList.remove('selected'));
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
            document.querySelector('.avatar').addEventListener('mouseover', function () {
                document.querySelector('.dropdown-content').style.display = 'block';
            });

            document.querySelector('.dropdown-content').addEventListener('mouseleave', function () {
                document.querySelector('.dropdown-content').style.display = 'none';
            });
        </script>

    </body>
</html>
