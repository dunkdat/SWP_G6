<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List - Online Shop</title>
    <link rel="stylesheet" href="css/productlist.css"/>
</head>
<body>
    <!-- Copy the header and navbar from homepage -->
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
        <div class="main-content">
            <!-- Left Filter Section -->
            <div class="filter-section">
                <h3>Filter by</h3>

                <!-- Filter by Brand -->
                <div class="filter-brand">
                    <h4>Brand</h4>
                    <form action="productlist" method="get">
                        <input type="hidden" name="category" value="${param.category}">
                        <input type="radio" name="brand" value="Yonex" <c:if test="${param.brand == 'Yonex'}">checked</c:if> /> Yonex<br>
                        <input type="radio" name="brand" value="Li-Ning" <c:if test="${param.brand == 'Li-Ning'}">checked</c:if> /> Li-Ning<br>
                        <input type="radio" name="brand" value="VSE" <c:if test="${param.brand == 'VSE'}">checked</c:if> /> VSE<br>
                    </div>

                    <!-- Filter by Price Range -->
                    <div class="filter-price">
                        <h4>Price Range</h4>
                        <input type="radio" name="price" value="0-50" <c:if test="${param.price == '0-50'}">checked</c:if> /> 0-50$<br>
                        <input type="radio" name="price" value="50-100" <c:if test="${param.price == '50-100'}">checked</c:if> /> 50-100$<br>
                        <input type="radio" name="price" value="100-150" <c:if test="${param.price == '100-150'}">checked</c:if> /> 100-150$<br>
                        <input type="radio" name="price" value="150-200" <c:if test="${param.price == '150-200'}">checked</c:if> /> 150-200$<br>
                    </div>

                    <button type="submit" class="apply-filter-btn" name="submit" value="filter">Apply Filters</button>
                </form>
            </div>

            <!-- Right Products Section -->
            <div class="products-section">
                <div class="mess">${message}</div>
                <section class="products">
                    <c:forEach items="${requestScope.productlist}" var="product">
                        <div class="product">
                            <img src="${product.link_picture}" alt="${product.name}">
                            <h2>${product.name}</h2>
                            <p>${product.price}</p>
                            <a href="productdetails?id=${product.id}" class="view-details-btn">View Details</a>
                        </div>
                    </c:forEach>
                </section>

                <section class="pagination">
                    <c:if test="${pageNumber > 1}">
                        <a href="productlist.jsp?page=${pageNumber - 1}" class="prev">Previous</a>
                    </c:if>
                    <c:if test="${pageNumber < totalPages}">
                        <a href="productlist.jsp?page=${pageNumber + 1}" class="next">Next</a>
                    </c:if>
                </section>
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
