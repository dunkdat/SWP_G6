<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Page</title>
        <link rel="stylesheet" href="css/registerstyle.css"/>
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
            <div class="icons">
                <a href="ProfileServlet?current_user=${sessionScope.current_user}"><img src="images/profile.png" alt="Account"></a>
                <img src="images/cart.png" alt="Cart">
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
        
<section class="nav-bar">
        <a href="homepage">Home Page</a>
        <a href="#">Sale</a>
        <a href="#">Voucher</a>
        <a href="aboutus.jsp">About Us</a>
        <a href="contact.jsp">Contact</a>
    </section>
        <div class="container">
            <div class="form-section">
                <h1>REGISTER</h1>
                <p>Sign up to create your account.</p>
                <form action="register" method="post">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="${name}" required>

                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="${address}" required>

                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" required>
                        <option value="" disabled selected>Select Gender</option>
                        <option value="1" ${gender == 1 ? 'selected' : ''}>Male</option>
                        <option value="0" ${gender == 0 ? 'selected' : ''}>Female</option>
                    </select>

                    <label for="phone">Phone:</label>
                    <input type="text" id="phone" name="phone" value="${phone}" required>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="${email}" required>

                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="${password}" required>

                    <label for="confirm-password">Confirm Password:</label>
                    <input type="password" id="confirm-password" name="cfpassword" value="${cfpassword}" required>

                    <input type="submit" class="btn" value="Register">
                </form>

                <div class="signup">
                    Already have an account? <a href="login.jsp">Sign in</a>
                </div>
            </div>
        </div>
                    
                    
            <!-- Modal Notification -->
        <div id="messageModal" class="modal">
            <div class="modal-content">
                <h2>Notification</h2>
                <p id="modalMessage">${message}</p>
                <button class="close-btn" onclick="closeModal()">Close</button>
            </div>
        </div>
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
            // Function to close the modal
            function closeModal() {
                document.getElementById('messageModal').style.display = 'none';
            }

            // Show modal if message is not null
            window.onload = function() {
                var message = "${message}";
                if (message && message.trim() !== "") {
                    document.getElementById('messageModal').style.display = 'flex';
                }
            };
        </script>
    </body>
</html>
