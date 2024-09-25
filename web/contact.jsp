<%-- 
    Document   : contact
    Created on : Sep 25, 2024, 6:47:18 PM
    Author     : DAT
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Contact the team at the best online badminton shop">
    <title>Contact Us - Badminton Shop</title>
    <link rel="stylesheet" href="css/homestyle.css"/> <!-- Link to homepage CSS -->
    <style>
        /* Specific styles for the Contact Us page */

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

        p {
            line-height: 1.6;
            margin-bottom: 20px;
            text-align: center;
        }

        form {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        button {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #ff9933;
        }

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
        <h1>Contact Us</h1>
        <p>Have questions? Reach out to us and we'll be happy to assist you.</p>
    </section>

    <section class="nav-bar">
        <a href="homepage">Home Page</a>
        <a href="#">Sale</a>
        <a href="#">Voucher</a>
        <a href="aboutus.jsp">About Us</a>
        <a href="contact.jsp">Contact</a>
    </section>

    <div class="container">
        <h1>Get in Touch</h1>
        <p>Feel free to contact us using the form below, and we will get back to you as soon as possible.</p>

        <form action="submit_form.jsp" method="POST">
            <label for="name">Your Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your name" required>

            <label for="email">Your Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="message">Your Message</label>
            <textarea id="message" name="message" rows="5" placeholder="Write your message here..." required></textarea>

            <button type="submit">Send Message</button>
        </form>
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

