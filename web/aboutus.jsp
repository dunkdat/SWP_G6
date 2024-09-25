<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Learn more about the team behind the best online badminton shop">
    <title>About Us - Badminton Shop</title>
    <link rel="stylesheet" href="css/homestyle.css"/> <!-- Link to homepage CSS -->
    <style>
        /* Specific styles for the About Us page */

        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }

        h1 {
            color: #2c3e50;
            text-align: center;
            margin-top: 20px;
        }
        h2{
            text-align: center;
        }
        p {
            line-height: 1.6;
            margin-bottom: 20px;
            text-align: center;
        }

        .team-section {
            display: flex;
            justify-content: space-around;
            margin-top: 40px;
        }

        .team-member {
            text-align: center;
        }

        .team-member img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
        }

        /* Adjust the footer to match the homepage */
        footer {
            background-color: #ffe5cc; /* Same as homepage */
            color: black;
            text-align: center;
            padding: 1rem;
            position: relative;
            width: 100%;
            bottom: 0;
            z-index: 100;
        }
    </style>
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
        <h1>About Us</h1>
        <p>Welcome to Badminton Shop! We are passionate about badminton and are dedicated to providing high-quality products for players of all levels.</p>
    </section>

    <section class="nav-bar">
        <a href="homepage">Home Page</a>
        <a href="#">Sale</a>
        <a href="#">Voucher</a>
        <a href="aboutus.jsp">About Us</a>
        <a href="contact.jsp">Contact</a>
    </section>

    <div class="container">
        <h1>Our Story</h1>
        <p>We are passionate about badminton and are committed to providing high-quality products to help you perform your best on the court.</p>

        <h2>Why Choose Us?</h2>
        <p>Our team consists of badminton enthusiasts who focus on quality, performance, and customer satisfaction.</p>

        <h2>Meet the Team</h2>
        <div class="team-section">
            <div class="team-member">
                <img src="images/dat.jpg" alt="Team Member 1">
                <h3>Do Dang Dat</h3>
                <p>Founder & CEO</p>
            </div>
            <div class="team-member">
                <img src="images/mark.jpg" alt="Team Member 2">
                <h3>Mark Zuckerberg</h3>
                <p>Head of Sales</p>
            </div>
            <div class="team-member">
                <img src="team-member-3.jpg" alt="Team Member 3">
                <h3>Mike Johnson</h3>
                <p>Customer Support</p>
            </div>
        </div>
    </div>
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
</script>

</body>
</html>
