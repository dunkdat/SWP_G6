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
            <h1>Welcome to Our Online Shop</h1>
            <p>Find the best products here!</p>
        </section>

        <section class="nav-bar">
            <a href="homepage">Home Page</a>
            <a href="#">Sale</a>
            <a href="#">Voucher</a>
            <a href="aboutus.jsp">About Us</a>
            <a href="contact.jsp">Contact</a>
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
            <c:forEach var="blog" items="${bloglist}" varStatus="status">
                <c:if test="${status.index < 2}">
                    <div class="blog-post">
                        <a href="NewsServlet"><img src="${blog.imagePath}" alt="Blog Post Image"></a>
                        <div>
                            <h3>${blog.newsTitle}</h3>
                            <p>${blog.shortContent}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </section>

        <section class="products">
            
            <div class="product">
                <a href="productlist?category=racket">
                    <img src="images/racket.jpg" alt="Product 1">
                </a>
                <h2>Rackets</h2>
                <p>Choose your partner !!!</p>
            </div>
            
            <div class="product">
                <a href="productlist?category=backpack">
                    <img src="images/bag.jpg" alt="Product 2">
                </a>
                <h2>Back Packs</h2>
                <p>Be professional</p>
            </div>
            <div class="product">
                <a href="productlist?category=shoes">
                    <img src="images/shoes.jpg" alt="Product 3">
                </a>
                <h2>Shoes</h2>
                <p>Confident and speed</p>
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
            setTimeout(showSlides, 3000); // Change slide every 3 seconds
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
