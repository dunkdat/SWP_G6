<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Shop</title>
    <style>
       body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            transition: margin-left 0.3s ease-in-out; /* Smooth transition for header */
        }

        .header .left-section {
            display: flex;
            align-items: center;
        }

        .header .left-section img {
            height: 60px;
            margin-right: 1rem;
        }

        .header .hotline {
            font-weight: bold;
            color: #ff0000;
        }

        .header .store-locator {
            margin-left: 2rem;
            font-weight: bold;
            color: #ff6600;
        }

        .header .right-section {
            display: flex;
            align-items: center;
        }
        .header .right-section img {
            height: 30px;
            margin-left: 1rem;
        }

        .header .search-bar {
            position: relative;
            margin-right: 2rem;
        }

        .header .search-bar input {
            padding: 0.5rem;
            border-radius: 20px;
            border: 1px solid #ddd;
            width: 250px;
            padding-right: 40px;
        }

        .header .search-bar .search-icon {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            color: #ff6600;
            cursor: pointer;
        }

        .header .icons {
            display: flex;
            align-items: center;
        }

        .header .icons img {
            margin-right: 1rem;
            cursor: pointer;
        }

        .header .icons span {
            font-size: 12px;
            background-color: #ff6600;
            color: #fff;
            border-radius: 50%;
            padding: 3px 7px;
            position: relative;
            top: -10px;
            left: -10px;
        }

        .navbar {
            background-color: #ff6600; /* Primary orange color */
            color: #fff;
            padding: 1rem;
            width: 200px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: transform 0.3s ease-in-out;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
            z-index: 1000; /* Ensure navbar is on top */
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            margin: 1rem 0;
            font-size: 1.2rem;
            text-transform: uppercase;
            font-weight: bold;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .navbar a:hover {
            background-color: #ff9933; /* Lighter orange on hover */
        }

        .content {
            margin-left: 200px;
            transition: margin-left 0.3s ease-in-out, width 0.3s ease-in-out;
            z-index: 1; /* Ensure content is behind the navbar */
        }

        .hero {
            background-color: #ffe5cc; /* Light orange background */
            padding: 2rem;
            text-align: center;
            color: #ff6600; /* Primary orange text color */
        }

        .hero h1 {
            margin: 0;
        }

        .nav-bar {
            background-color: #ff6600; /* Primary orange color */
            padding: 1rem;
            display: flex;
            justify-content: center;
            box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
            z-index: 1; /* Ensure navigation bar is behind the navbar */
        }

        .nav-bar a {
            color: #fff;
            margin: 0 1.5rem;
            text-decoration: none;
            font-weight: bold;
            text-transform: uppercase;
            padding: 0.5rem;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .nav-bar a:hover {
            background-color: #ff9933; /* Lighter orange on hover */
        }

        .slider {
            position: relative;
            width: 100%;
            max-width: 100%;
            height: auto; /* Adjust height automatically based on the content */
            overflow: hidden;
        }

        .slides {
            display: none;
            width: 100%;
            height: auto; /* Allow height to be auto to maintain aspect ratio */
        }

        .slider img {
            width: 100%;
            height: auto; /* Maintain aspect ratio of the image */
            object-fit: cover; /* Ensure the image covers the slider area */
            display: block; /* Remove extra space below the image */
        }

        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
            background-color: rgba(0,0,0,0.5); /* Semi-transparent background */
            z-index: 2; /* Ensure arrows are on top of slider */
        }

        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }

        .prev {
            left: 0;
            border-radius: 3px 0 0 3px;
        }

        .prev:hover, .next:hover {
            background-color: rgba(0,0,0,0.8);
        }

        .products {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 2rem;
        }

        .product {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 1rem;
            padding: 1rem;
            width: 200px;
            text-align: center;
        }

        .product img {
            max-width: 100%;
            border-bottom: 1px solid #ddd;
            margin-bottom: 1rem;
        }

        .blog-section {
            margin-top: 3rem;
        }

        .blog-post {
            background-color: #fff;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
        }

        .blog-post img {
            width: 150px;
            height: auto;
            margin-right: 1rem;
            border-radius: 5px;
        }

        .blog-post h3 {
            margin-top: 0;
        }

        .footer {
            background-color: #ff6600; /* Primary orange color */
            color: #fff;
            text-align: center;
            padding: 1rem;
            position: relative; /* Changed from fixed to relative */
            width: 100%;
            bottom: 0;
            z-index: 100; /* Ensure footer is above other content */
        }

        /* Hide Navbar initially on small screens */
        .navbar.hidden {
            transform: translateX(-100%);
        }

        /* Adjust content and header when navbar is hidden */
        .header.expanded, .content.expanded {
            margin-left: 200px;
        }

        .header.collapsed, .content.collapsed {
            margin-left: 0;
        }

        .toggle-button {
            background-color: #ff6600; /* Primary orange color */
            color: white;
            padding: 1rem;
            position: fixed;
            top: 0;
            left: 0;
            cursor: pointer;
            z-index: 1100; /* Higher than the navbar */
        }

    </style>
</head>
<body>
    <header class="header collapsed">
        <div class="left-section">
            <img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px;"> <!-- Replace with your logo -->
            <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
            <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
        </div>
        <div class="right-section">
            <div class="search-bar">
                <input type="text" placeholder="Tìm sản phẩm...">
                <span class="search-icon">🔍</span> <!-- This can be replaced with an actual icon -->
            </div>
            <div class="icons">
                <img src="images/profile.png" alt="Account"> <!-- Add account icon image -->
                <img src="images/cart.png" alt="Cart"> <!-- Add cart icon image -->
            </div>
        </div>
    </header>

    <div class="toggle-button" onclick="toggleNavbar()">☰</div>

    <nav class="navbar hidden" id="navbar">
        <div class="logo">Online Shop</div>
        <a href="#">Home</a>
        <a href="#">Products</a>
        <a href="#">Contact</a>
        <a href="#">Cart</a>
    </nav>

    <div class="content collapsed" id="content">
        <section class="hero">
            <h1>Welcome to Our Online Shop</h1>
            <p>Find the best products here!</p>
        </section>

        <!-- Navigation Bar -->
        <section class="nav-bar">
            <a href="#">Home Page</a>
            <a href="#">Sale</a>
            <a href="#">Voucher</a>
            <a href="#">About Us</a>
            <a href="#">Contact</a>
        </section>

        <!-- Slider Section -->
        <section class="slider">
            <c:forEach items="${requestScope.slider}" var="n">
                <c:if test="${n.status.equals('active')}">
                    <div class="slides">
                        <img src="${n.link_thumnail}" alt="Slide">
                    </div>
                </c:if>
            </c:forEach>
            
            <!-- Previous/Next buttons -->
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </section>

        <!-- Blog Post Section -->
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

        <!-- Product Section -->
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

            // Toggle the navbar visibility
            navbar.classList.toggle('hidden');
            navbar.classList.toggle('visible');
            
            // Toggle the content and header margins
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
                slides[i].style.display = "none"; // Hide all slides
            }
            slideIndex++;
            if (slideIndex > slides.length) { slideIndex = 1 } // Loop back to the first slide
            slides[slideIndex - 1].style.display = "block"; // Show the current slide
            setTimeout(showSlides, 3000); // Change image every 3 seconds
        }

        function plusSlides(n) {
            showSpecificSlide(slideIndex += n);
        }

        function showSpecificSlide(n) {
            const slides = document.getElementsByClassName("slides");
            if (n > slides.length) { slideIndex = 1 } // Loop back to the first slide
            if (n < 1) { slideIndex = slides.length } // Loop to the last slide
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none"; // Hide all slides
            }
            slides[slideIndex - 1].style.display = "block"; // Show the specific slide
        }

    </script>
</body>
</html>
