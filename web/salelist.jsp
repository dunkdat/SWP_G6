<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                <a href="homepage"><img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px;"></a>
                <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
                <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
            </div>
            <div class="right-section">
                <!-- Search Bar Section in the header -->
                <!-- Search Bar Section in the header -->
                <div class="search-bar">
                    <input type="text" id="searchInput" class="searching" placeholder="Tìm sản phẩm..." autocomplete="off">
                    <span class="search-icon">🔍</span>
                </div>


                <div class="icons">
                    <a href="ProfileServlet?current_user=${sessionScope.current_user}">
                        <c:if test="${current_user == null}">
                            <img src="images/profile.png" alt="Account">
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
                </div>        </div>
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
                </div></div>
                <c:if test="${current_user.role == 'Staff'}">
                <div class="dropdown">
                    <a href="dashboard?role=${current_user.role}">Dashboard</a>

                </div>
                <div class="dropdown">

                    <a href="staffproductlist">Products List</a>  
                </div>
                <div class="dropdown">

                    <a href="onsale">On Sale Product</a>
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
                <p>We are stronger, we are better !!!</p>
            </section>

            <section class="nav-bar">
                <a href="homepage">Home Page</a>
                <a href="salelist">Sale</a>
                <a href="#">Voucher</a>
                <a href="aboutus.jsp">About Us</a>
                <a href="contact.jsp">Contact</a>
            </section>
            <div class="main-content">
                <!-- Left Filter Section -->
                <div class="filter-section">
                    <h3>Filter by</h3>

                    <!-- Filter by Brand -->
                    
                    <form action="productlist" method="get" id="filterForm">
                        <h4>Category</h4>
                        <!-- Filter by Category -->
                        <input type="radio" name="category" value="racket" <c:if test="${param.category == 'racket'}">checked</c:if> /> Racket<br>
                        <input type="radio" name="category" value="shoes" <c:if test="${param.category == 'shoes'}">checked</c:if> /> Shoes<br>
                        <input type="radio" name="category" value="net" <c:if test="${param.category == 'net'}">checked</c:if> /> Net<br>
                        <input type="radio" name="category" value="grip" <c:if test="${param.category == 'grip'}">checked</c:if> /> Grip<br>
                        <input type="radio" name="category" value="backpack" <c:if test="${param.category == 'backpack'}">checked</c:if> /> Backpack<br>
                        <input type="radio" name="category" value="shuttlecock" <c:if test="${param.category == 'shuttlecock'}">checked</c:if> /> Shuttlecock<br>
                        <h4>Brand</h4>
                        <!-- Filter by Brand -->
                        <input type="radio" name="brand" value="Yonex" <c:if test="${param.brand == 'Yonex'}">checked</c:if> /> Yonex<br>
                        <input type="radio" name="brand" value="Li-Ning" <c:if test="${param.brand == 'Li-Ning'}">checked</c:if> /> Li-Ning<br>
                        <input type="radio" name="brand" value="VSE" <c:if test="${param.brand == 'VSE'}">checked</c:if> /> VSE<br>

                            <!-- Filter by Price Range -->
                            <h4>Price</h4>
                            <input type="radio" name="price" value="0-50" <c:if test="${param.price == '0-50'}">checked</c:if> /> 0-50$<br>
                        <input type="radio" name="price" value="50-100" <c:if test="${param.price == '50-100'}">checked</c:if> /> 50-100$<br>
                        <input type="radio" name="price" value="100-150" <c:if test="${param.price == '100-150'}">checked</c:if> /> 100-150$<br>
                        <input type="radio" name="price" value="150-200" <c:if test="${param.price == '150-200'}">checked</c:if> /> 150-200$<br>
                        </form>

                        <!-- Clear Filters Button -->
                        <button type="button" class="clear-filter-btn">Clear Filters</button>
                    </div>        
                    <!-- Right Products Section -->
                    <div class="products-section">
                        <div class="mess">${message}</div>
                    <section class="products">
                        <c:forEach items="${requestScope.productlist}" var="product">
                            <a href="productdetails?id=${product.id}" >
                            <div class="product">
                                <img src="${product.link_picture}" alt="${product.name}">
                                <c:if test="${product.salePercent > 0}">
                                    <!-- Hiển thị salePercent trên ảnh -->
                                    <div class="sale-badge">-${product.salePercent}%</div>
                                </c:if>
                                <h2>${product.name}</h2>

                                <c:if test="${product.salePercent > 0}">
                                    <!-- Hiển thị giá cũ bị gạch bỏ và giá mới -->
                                    <div  class="price-container">
                                        <p class="original-price">$${product.price}</p>
                                        <p class="sale-price">$<fmt:formatNumber value="${product.price - (product.price * product.salePercent / 100)}" minFractionDigits="2" maxFractionDigits="2" /></p>
                                    </div>
                                </c:if>

                                <c:if test="${product.salePercent == 0}">
                                    <!-- Hiển thị giá bình thường khi không có giảm giá -->
                                    <p class="sale-price">$${product.price}</p>
                                </c:if>



                                <div class="product-rating">
            <c:set var="averageRating" value="${averageRatings[product.name]}" />
            <c:forEach begin="1" end="5" var="star">
                <c:if test="${star <= averageRating}">
                    <span class="star filled">⭐</span>
                </c:if>
                <c:if test="${star > averageRating}">
                    <span class="star empty">⭐</span>
                </c:if>
            </c:forEach>
                <c:if test="${averageRatings[product.name] != null}">
                    <span class="rating-value">(${averageRating})</span>
                </c:if>
            
        </div>
                               
                            </div> 
                            </a>
                        </c:forEach>
                    </section>
                    <div class="pagination">

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
            document.addEventListener("DOMContentLoaded", function () {
                // Attach the pagination handler
                loadPagination();

                // Add event listeners for the filter options
                document.querySelectorAll('input[name="category"],input[name="brand"], input[name="price"]').forEach(input => {
                    input.addEventListener('change', filterProducts);
                });
                document.getElementById('searchInput').addEventListener('input', filterProducts);
                // Attach the clear filter button event
                document.querySelector('.clear-filter-btn').addEventListener('click', clearFilters);
                function clearFilters() {
                    // Get the filter form
                    const filterForm = document.getElementById('filterForm');

                    // Clear all checked radio buttons for both brand and price
                    const categoryRadios = filterForm.querySelectorAll('input[name="category"]');
                    const brandRadios = filterForm.querySelectorAll('input[name="brand"]');
                    const priceRadios = filterForm.querySelectorAll('input[name="price"]');

                    // Uncheck brand and price radio buttons
                    categoryRadios.forEach(radio => radio.checked = false);
                    brandRadios.forEach(radio => radio.checked = false);
                    priceRadios.forEach(radio => radio.checked = false);

                    // Remove brand and price from URL by reloading products without those parameters
                    const xhr = new XMLHttpRequest();
                    const url = `LoadOnsaleLists?`;
                    console.log('Clear Filters URL:', url); // Debug the URL

                    xhr.open('GET', url, true);

                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            // Update the product section with the cleared filters (no brand or price filters)
                            document.querySelector('.products-section').innerHTML = xhr.responseText;

                            // Reattach pagination and other listeners if needed
                            loadPagination();
                        } else {
                            console.error('Failed to load products after clearing filters. Status:', xhr.status);
                        }
                    };

                    xhr.onerror = function () {
                        console.error('Error while clearing filters.');
                    };

                    xhr.send();
                }

                function filterProducts() {
                    const searchQuery = document.getElementById('searchInput').value; // Search query
                    const category = document.querySelector('input[name="category"]:checked') ? document.querySelector('input[name="category"]:checked').value : '';
                    const brand = document.querySelector('input[name="brand"]:checked') ? document.querySelector('input[name="brand"]:checked').value : '';
                    const price = document.querySelector('input[name="price"]:checked') ? document.querySelector('input[name="price"]:checked').value : '';

                    const xhr = new XMLHttpRequest();
                    const url = `LoadOnsaleLists?brand=` + brand+ `&category=` + category + `&price=` + price + `&query=` + searchQuery;
                    console.log(url);
                    xhr.open('GET', url, true);

                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            // Update the product section with the filtered products
                            document.querySelector('.products-section').innerHTML = xhr.responseText;

                            // Reattach pagination and other listeners if needed
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

                function loadPagination() {
                    const paginationLinks = document.querySelectorAll('.pagination a');

                    paginationLinks.forEach(link => {
                        link.addEventListener('click', function (e) {
                            e.preventDefault();
                            const page = this.getAttribute('data-page'); // Get the page number
                            console.log('Page clicked:', page);

                            // Load products for the clicked page
                            loadProducts(page);
                        });
                    });
                }

                function loadProducts(page) {
                    const searchQuery = document.getElementById('searchInput').value;
                    const category = document.querySelector('input[name="category"]:checked') ? document.querySelector('input[name="category"]:checked').value : '';
                    const brand = document.querySelector('input[name="brand"]:checked') ? document.querySelector('input[name="brand"]:checked').value : '';
                    const price = document.querySelector('input[name="price"]:checked') ? document.querySelector('input[name="price"]:checked').value : '';

                    const xhr = new XMLHttpRequest();

                    // Correctly format the URL with page, category, brand, and price filters
                    const url = `LoadOnsaleLists?page=` + page+ `&category=` + category + `&brand=` + brand + `&price=` + price + `&query=` + searchQuery;
                    console.log('Request URL:', url); // Debug the URL

                    xhr.open('GET', url, true);

                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            // Update the product section with the new products
                            document.querySelector('.products-section').innerHTML = xhr.responseText;

                            // Update the active page link
                            updateActivePage(page);

                            // Reattach pagination links for the new content
                            loadPagination();
                        } else {
                            console.error('Failed to load products. Status:', xhr.status);
                        }
                    };

                    xhr.onerror = function () {
                        console.error('Error while loading data from the server.');
                    };

                    xhr.send();
                }

                function updateActivePage(page) {
                    const paginationLinks = document.querySelectorAll('.pagination a');

                    // Remove 'active' class from all pagination links
                    paginationLinks.forEach(link => {
                        link.classList.remove('active');
                    });

                    // Add 'active' class to the clicked page link
                    const activeLink = document.querySelector(`.pagination a[data-page="` + page + `"]`);
                    if (activeLink) {
                        activeLink.classList.add('active');
                    }
                }
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
        </script>
    </body>
</html>
