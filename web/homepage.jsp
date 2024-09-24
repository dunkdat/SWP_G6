<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Shop</title>
    <link rel="stylesheet" href="css/homestyle.css"/>
</head>
<body>
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
                <img src="images/profile.png" alt="Account">
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
        <a href="">Contact</a>
        <a href="">Cart</a>
    </nav>

    <div class="content collapsed" id="content">
        <section class="hero">
            <h1>Welcome to Our Online Shop</h1>
            <p>Find the best products here!</p>
        </section>

        <section class="nav-bar">
            <a href="#">Home Page</a>
            <a href="#">Sale</a>
            <a href="#">Voucher</a>
            <a href="#">About Us</a>
            <a href="#">Contact</a>
        </section>

        <section class="slider">
            <c:forEach items="${requestScope.slider}" var="n">
                <c:if test="${n.status.equals('active')}">
                    <div class="slides">
                        <img src="${n.link_thumnail}" alt="Slide">
                    </div>
                </c:if>
            </c:forEach>
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </section>

        <section class="blog-section">
            <h2>Latest Blog Posts</h2>
            <div class="blog-post">
                <img src="https://via.placeholder.com/150" alt="Blog Post 1">
                <div>
                    <h3>How to Find the Best Deals</h3>
                    <p>Discover tips and tricks to save money on your favorite products. Learn how to compare prices and find the best deals online.</p>
                </div>
            </div>
            <div class="blog-post">
                <img src="https://via.placeholder.com/150" alt="Blog Post 2">
                <div>
                    <h3>Top 10 Products of 2024</h3>
                    <p>Check out our curated list of the top products to watch in 2024. From gadgets to household items, these products are a must-have.</p>
                </div>
            </div>
        </section>

        <section class="products">
            <div class="product">
                <img src="" alt="Product 1">
                <h2>Product 1</h2>
                <p>$10.00</p>
            </div>
            <div class="product">
                <img src="" alt="Product 2">
                <h2>Product 2</h2>
                <p>$20.00</p>
            </div>
            <div class="product">
                <img src="" alt="Product 3">
                <h2>Product 3</h2>
                <p>$30.00</p>
            </div>
        </section>
    </div>

    <footer class="footer">
        © 2024 Online Shop. All rights reserved.
    </footer>

    <script>
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
        // Slider functionality
        let slideIndex = 0;
        showSlides();

        function showSlides() {
            const slides = document.getElementsByClassName("slides");
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > slides.length) { slideIndex = 1 }
            slides[slideIndex - 1].style.display = "block";
            setTimeout(showSlides, 3000);
        }

        function plusSlides(n) {
            showSpecificSlide(slideIndex += n);
        }

        function showSpecificSlide(n) {
            const slides = document.getElementsByClassName("slides");
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slides[slideIndex - 1].style.display = "block";
        }
    </script>
</body>
</html>
