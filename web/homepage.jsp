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
    
    <c:if test="${current_user == 'Customer'}">
        <img src="images/cart.png" alt="Cart">
    </c:if>
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
                    <a href="productlist">All</a>
                    <a href="productlist?category=racket">Racket</a>
                    <a href="productlist?category=shoes">Shoes</a>
                    <a href="productlist?category=net">Net</a>
                    <a href="productlist?category=grip">Grip</a>
                    <a href="productlist?category=backpack">Back Pack</a>
                    <a href="productlist?category=shuttlecock">Shuttlecock</a>
                </div>
            </div>
                <c:if test="${current_user.role == 'Staff'}">
                    <div class="dropdown">
                        <a href="dashboard?role=${current_user.role}">Dashboard</a>

                    </div>
                    <div class="dropdown">

                        <a href="staffproductlist">Products List</a>  
                    </div>
                    <div class="dropdown">

                        <a href="onsale">On Sale Products</a>
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
            <h1>Welcome to Bad Sport Shop</h1>
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

        <!-- Products Section (Hiển thị toàn bộ sản phẩm dưới slider và phân trang) -->
        <section class="products-section">
            <h2>Our Products</h2>
            
            <!-- Hiển thị danh sách sản phẩm -->
            <div class="products-grid">
                <c:forEach var="product" items="${productlist}" varStatus="status">
                    <div class="product">
                        <a href="productdetails?id=${product.id}">
                            <img src="${product.link_picture}" alt="${product.name}">
                        </a>
                        <h2>${product.name}</h2>
                        <p>${product.details}</p>
                        <p style="color: red">Price: ${product.price}</p>
                    </div>
                </c:forEach>
            

            <div class="pagination">
    <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}" />
    <c:set var="endPage" value="${startPage + 4 <= totalPages ? startPage + 4 : totalPages}" />
    
    <!-- Previous Button -->
    <c:if test="${currentPage > 1}">
        <a href="#" data-page="${currentPage - 1}">&laquo; Prev</a>
    </c:if>
    
    <!-- Page Numbers -->
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${i == currentPage}">
                <a href="#" class="active">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="#" data-page="${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <!-- Next Button -->
    <c:if test="${currentPage < totalPages}">
        <a href="#" data-page="${currentPage + 1}">Next &raquo;</a>
    </c:if>
</div>
</div>
        </section>

        <section class="blog-section">
            <h2>Latest Blog Posts</h2>
            <c:forEach var="blog" items="${bloglist}" varStatus="status">
                <c:if test="${status.index < 2}">
                    <div class="blog-post">
                        <a href="NewsServlet"><img src="images/News_img/${blog.imagePath}" alt="Blog Post Image"></a>
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
const avatarElement = document.querySelector('.avatar');
if (avatarElement) {
    avatarElement.addEventListener('mouseover', function () {
        document.querySelector('.dropdown-content').style.display = 'block';
    });
}
            document.querySelector('.dropdown-content').addEventListener('mouseleave', function () {
                document.querySelector('.dropdown-content').style.display = 'none';
            });
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
    const url = `LoadProductsServlet?page=` + page;
    console.log('Request URL:', url); // Kiểm tra URL trước khi gửi

    xhr.open('GET', url, true);

    xhr.onload = function () {
        if (xhr.status === 200) {
            document.querySelector('.products-grid').innerHTML = xhr.responseText;
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
