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
    <div class="dropdown">
        <a href="homepage">Home</a>
    </div>
    <div class="dropdown">
        <a href="#">Category</a> <!-- Mục "Category" chính -->
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

                            </div>
                
                
        </div><div class="pagination">

    <c:forEach begin="1" end="${totalPages}" var="i">
        <c:choose>
            <c:when test="${i == currentPage}">
                <a href="#" data-page="${i}" class="active">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="#" data-page="${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

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
        
        function filterProducts() {
        // Get the search term from the input field and convert it to lowercase for case-insensitive search
        const searchTerm = document.querySelector('.search-bar input').value.toLowerCase();

        // Get all product elements (assumes products are in a section with class .products and each product has class .product)
        const products = document.querySelectorAll('.products .product');

        // Loop through each product
        products.forEach(product => {
            // Get the product name and convert it to lowercase for comparison
            const productName = product.querySelector('h2').textContent.toLowerCase();

            // Check if the search term is found in the product name
            if (productName.includes(searchTerm)) {
                // If it matches, show the product
                product.style.display = 'block';
            } else {
                // If it doesn't match, hide the product
                product.style.display = 'none';
            }
        });
    }

    // Add event listener to the search input to trigger filtering whenever the user types something
    document.querySelector('.search-bar input').addEventListener('input', filterProducts);

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
        document.addEventListener("DOMContentLoaded", function () {
    loadPagination();

    function loadPagination() {
        const paginationLinks = document.querySelectorAll('.pagination a');

        paginationLinks.forEach(link => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                const page = this.getAttribute('data-page'); // Lấy số trang từ thuộc tính data-page
                console.log('Page clicked:', page);
                loadProducts(page);
            });
        });
    }

   function loadProducts(page) {
    const xhr = new XMLHttpRequest();

    // In ra URL đang được gửi đi
    const url = `LoadListProductsServlet?page=` + page+`&category=${param.category}`;
    console.log('Request URL:', url); // Kiểm tra URL trước khi gửi

    xhr.open('GET', url, true);

    xhr.onload = function () {
        if (xhr.status === 200) {
            document.querySelector('.products-section').innerHTML = xhr.responseText;

            // Cập nhật trang hiện tại
            currentPage = page;

            // Cập nhật trạng thái 'active' cho trang hiện tại
            updateActivePage(page);

            // Tải lại phân trang để thêm sự kiện click cho các liên kết mới
            loadPagination();
        } else {
            console.error('Failed to load products. Status:', xhr.status);
        }
    };

    xhr.onerror = function () {
        console.error('Error while loading data from server.');
    };

    xhr.send();
}
function updateActivePage(page) {
    const paginationLinks = document.querySelectorAll('.pagination a');

    // Xóa class 'active' khỏi tất cả các liên kết phân trang
    paginationLinks.forEach(link => {
        link.classList.remove('active');
    });

    // Gán class 'active' cho trang hiện tại
    const activeLink = document.querySelector(`.pagination a[data-page="`+page+`"]`);
    if (activeLink) {
        activeLink.classList.add('active');
    }
}
});
    </script>
</body>
</html>
