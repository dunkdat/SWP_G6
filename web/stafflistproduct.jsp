<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Products List</title>
        <style>
            /* Basic styling */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            /* Table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                background-color: #fff;
                font-size: 16px;
            }

            table thead {
                background-color: #ffcc99;
                color: white;
            }

            table th, table td {
                padding: 15px;
                border: 1px solid #ddd;
                text-align: left;
            }

            table th {
                cursor: pointer;
                font-weight: bold;
                background-color: #ff6600;
                color: white;
                text-transform: uppercase;
            }

            table tr:hover {
                background-color: #ffcc99; /* Light orange */
            }

            table tr td img {
                border-radius: 5px;
                border: 2px solid #ddd;
                width: 80px;
                height: 80px;
            }

            /* Add new product button */
            .add-new-product {
                text-align: right;
                margin-bottom: 20px;
            }

            .add-new-product a {
                padding: 10px 20px;
                background-color: #ff6600;
                color: white;
                border-radius: 5px;
                text-decoration: none;
                font-size: 16px;
            }

            /* Modal styling */
            /* Modal styling */
.modal {
    display: none;
    position: fixed;
    z-index: 10;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4);
    padding-top: 50px;
}

.modal-content {
    background-color: #fff;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 600px;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
    border-radius: 10px;
    position: relative;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.modal-content h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}

.modal-content input,
.modal-content select,
.modal-content textarea {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

.modal-content input[type="number"] {
    -moz-appearance: textfield;
}

.modal-content input[type="number"]::-webkit-outer-spin-button,
.modal-content input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

/* Buttons inside modal */
.submit-btn {
    background-color: #ff6600;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 10px;
    width: 100%;
    text-align: center;
}

.submit-btn:hover {
    background-color: #ff9933;
    transition: 0.3s;
}

/* Add Product Button */
.add-new-product a {
    display: inline-block;
    background-color: #ff6600;
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    font-size: 16px;
}

.add-new-product a:hover {
    background-color: #ff9933;
}

.message {
    color: green;
    text-align: center;
    margin-top: 10px;
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
            gap: 2rem;
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
.navbar .dropdown {
    position: relative;
    display: inline-block;
    width: 100%; /* Đảm bảo mục "Category" chiếm toàn bộ chiều rộng */
}

.navbar .dropdown a {
    color: #fff; /* Màu trắng cho chữ trong các mục của navbar */
    text-decoration: none;
    padding: 1rem;
    display: block;
    text-align: left;
    font-size: 1.2rem;
    font-weight: bold;
    transition: background-color 0.3s ease, color 0.3s ease;
}

/* Cấu trúc danh sách dropdown */
.navbar .dropdown-content {
    display: none;
    position: absolute;
    background-color: #fff; /* Nền cam nhạt cho dropdown */
    min-width: 160px;
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2); /* Hiệu ứng bóng */
    border-radius: 5px; /* Bo góc nhẹ */
    padding: 0.5rem 0; /* Khoảng cách bên trong */
    z-index: 1;
    width: 100%; /* Chiều rộng danh sách bằng với chiều rộng navbar */
}

.navbar .dropdown-content a {
    color: #333; /* Màu chữ đen cho các mục dropdown */
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left; /* Căn lề trái cho danh sách con */
    font-size: 14px;
    font-weight: normal; /* Mức độ đậm vừa phải */
    gap:1rem;
}

/* Hover vào danh sách con */
.navbar .dropdown-content a:hover {
    background-color: #ff6600; /* Nền cam khi hover */
    color: #fff; /* Chữ trắng khi hover */
}

/* Hiển thị danh sách khi hover vào mục chính */
.navbar .dropdown:hover .dropdown-content {
    display: block; /* Hiển thị danh sách khi hover */
}

/* Hiệu ứng hover cho mục chính */
.navbar .dropdown:hover a {
    color: #ff6600; /* Đổi màu chữ thành cam khi hover vào mục chính */
    background-color: #fff; /* Nền trắng khi hover vào mục chính */
    border-radius: 5px; /* Bo góc nhẹ */
}
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
            /* Detail modal styling */
.detail-modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1000; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    background-color: rgba(0,0,0,0.5); /* Black with opacity */
    overflow: auto; /* Enable scrolling if needed */
}

.detail-modal-content {
    background-color: #fff;
    margin: 5% auto; /* 5% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
    max-width: 600px; /* Maximum width */
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Add shadow for better visual */
}

.detail-modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 15px;
    border-bottom: 1px solid #ddd;
}

.detail-modal-header h2 {
    margin: 0;
    font-size: 24px;
    color: #333;
}

.detail-modal-header .close {
    font-size: 28px;
    font-weight: bold;
    color: #aaa;
    cursor: pointer;
}

.detail-modal-header .close:hover,
.detail-modal-header .close:focus {
    color: black;
}

.detail-modal-body {
    padding: 10px 0;
}

.detail-modal-body table {
    width: 100%;
    border-collapse: collapse;
}

.detail-modal-body table td {
    padding: 10px;
    vertical-align: top;
}

.detail-modal-body table td label {
    font-weight: bold;
}

.detail-modal-body img {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border: 2px solid #ddd;
    border-radius: 5px;
}

/* Buttons for updating and deleting */
.modal-actions {
    display: flex;
    justify-content: flex-end;
    margin-top: 20px;
    gap: 10px;
}

.modal-actions button {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    color: #fff;
}

.btn-update {
    background-color: #28a745;
}

.btn-update:hover {
    background-color: #218838;
}

.btn-delete {
    background-color: #dc3545;
}

.btn-delete:hover {
    background-color: #c82333;
}
.detail-table {
    width: 100%;
    margin-bottom: 20px;
}

.detail-table td {
    padding: 10px;
}

.modal-actions button {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    color: #fff;
    margin-right: 10px;
}

.btn-update {
    background-color: #28a745;
}

.btn-delete {
    background-color: #dc3545;
}

.modal-actions button:hover {
    opacity: 0.9;
}
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 2rem;
    flex-wrap: wrap;
    max-height: 90px; /* Giới hạn chiều cao tối đa để tạo 2 hàng */
    overflow: hidden; /* Ẩn các phần vượt quá */
    gap: 5px; /* Khoảng cách giữa các trang */
}

.pagination a {
    color: #ff6600;
    padding: 0.5rem 1rem;
    text-decoration: none;
    border: 1px solid #ff6600;
    margin: 0 0.25rem;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

.pagination a:hover {
    background-color: #ff6600;
    color: #fff;
}

.pagination a.active {
    background-color: #ff6600;
    color: #fff;
}

/* Fade-in animation for modal */

        </style>
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
            <c:if test="${current_user.imagePath == null}">
                <img src="images/profile.png" alt="Account" class="avatar">
            </c:if>
                <c:if test="${current_user.imagePath != null}">
                 <img src="${IConstant.PATH_USER}/${current_user.imagePath}" alt="Account" class="avatar">   
            </c:if>
            
        </c:if>
    </a>
        <c:if test="${current_user != null}">
            <div class="dropdown-content">
                <c:if test="${current_user.imagePath != null}">
                    <img src="${IConstant.PATH_USER}/${current_user.imagePath}" alt="Avatar" class="dropdown-avatar">
            </c:if>
             
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
            <div class="dropdown"><a href="homepage">HomePage</a></div>
            <div class="dropdown"><a href="dashboard?role=${current_user.role}">Dash Board </a></div>
            <div class="dropdown"><a href="staffproductlist">Products Management</a></div>
            <div class="dropdown"><a href="onsale">On Sale Products</a></div>
            
            
        </nav>
        <div class="container">
            <h1>Products List</h1>
            <div class="filterForm">
    <form id="searchForm" style="width: 100%; display: flex; justify-content: space-between;">
        <input type="text" id="searchInput" placeholder="Search by name">
        <select id="categoryFilter" name="categoryFilter">
            <option value="">All Category</option>
            <option value="racket">Racket</option>
            <option value="shoes">Shoes</option>
            <option value="net">Net</option>
            <option value="grip">Grip</option>
            <option value="backpack">Back Pack</option>
            <option value="shuttlecock">Shuttlecock</option>
        </select>
        <select id="statusFilter" name="statusFilter">
            <option value="">All Statues</option>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
        </select>
    </form>
</div>
            <div class="products-section">
            <!-- Table for Products List -->
            <table id="productTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Thumbnail</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Brand</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="productTableBody">
    <c:forEach var="product" items="${requestScope.productlist}">
        <tr>
            <td>${product.id}</td>
            <td><img src="${product.link_picture}" alt="Product Thumbnail" width="50" height="50"></td>
            <td>${product.name}</td>
            <td>${product.category}</td>
            <td>${product.brand}</td>
            <td>${product.price}</td>
            <td style="color: ${product.status == 'inactive' ? 'red' : 'green'}">${product.status == 'active' ? 'Active' : 'Inactive'}</td>
            <td><button class="details-btn" onclick="showProductDetails(
                '${product.id}',
                '${product.link_picture}',
                '${product.category}',
                '${product.brand}',
                '${product.name}',
                '${product.details}',
                '${product.quantity}',
                '${product.price}',
                '${product.salePercent}',
                '${product.status}',
                '${product.color}',
                '${product.size}'
                )">Details</button></td>
        </tr>
    </c:forEach>
</tbody>
            </table>
<!-- Pagination -->
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
            <!-- Button to Add New Product -->
            <div class="add-new-product">
                <a href="#" class="btn-add" id="openModal">Add New Product</a>
            </div>
        </div>

        <!-- Modal for Adding New Product -->
        <div id="myModal" class="modal" style="display: ${message1 != null ? 'block' : 'none'}">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Add New Product</h2>
        <form action="staffproductlist" method="post" enctype="multipart/form-data">
            <!-- ID Field -->
            <div>
                <label for="id">ID:</label>
                <input type="text" id="id" name="id" required="">
            </div>

            <!-- Thumbnail Field -->
            <div>
                <label for="thumbnail">Thumbnail:</label>
                <input type="text" id="thumbnail" name="link_picture" required="">
            </div>

            <!-- Product Name Field -->
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" required>

            <!-- Category Dropdown -->
            <div>
                <label for="category">Category:</label>
                <select id="category" name="category" required onchange="toggleSizeField()">
                    <option value="">Select Category</option>
                    <option value="racket">Racket</option>
                    <option value="shoes">Shoes</option>
                    <option value="net">Net</option>
                    <option value="grip">Grip</option>
                    <option value="backpack">Back Pack</option>
                    <option value="shuttlecock">Shuttlecock</option>
                </select>
            </div>

            <!-- Brand Field -->
            <div>
                <label for="brand">Brand:</label>
                <input type="text" id="brand" name="brand" required>
            </div>

            <!-- Color Field -->
            <div>
                <label for="color">Color:</label>
                <input type="text" id="color" name="color" required>
            </div>

            <!-- Quantity Field -->
            <div>
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" min="1" required>
            </div>

            <!-- Details Field -->
            <div>
                <label for="details">Details:</label>
                <textarea id="details" name="details" rows="4" required></textarea>
            </div>

            <!-- Size Field (Only for Shoes) -->
            <div id="size-field" style="display: none;">
                <label for="size">Size:</label>
                <input type="number" id="size" name="size" min="1">
            </div>

            <!-- Price Field -->
            <div>
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" required>
            </div>

            <div>
                <button type="submit" name="submit" value="add" class="submit-btn">Add Product</button>
            </div>
        </form>
        <div class="message">${message1}</div>
    </div>
</div>

        <!-- Product Detail Modal -->
        <div id="detailModal" class="detail-modal" style="display: ${message2 != null ? 'block' : 'none'}">
    <div class="detail-modal-content">
        <span class="close" onclick="closeProductDetailModal()">&times;</span>
        <h2>Product Details</h2>
        <form id="productForm" action="staffproductdetail" method="post" enctype="multipart/form-data">
            <table class="detail-table">
                <tr>
                    <td><strong>ID: </strong></td>
                    <td><input type="text" id="detail-id" name="id" value="" readonly=""></td>
                </tr>
                <tr>
                    <td><strong>Thumbnail:</strong></td>
                    <td>
                        <img id="detail-thumbnail" src="" alt="Product Thumbnail" width="100" height="100">
                        <div><label>Change thumbnail: </label></div>
                        <input type="text" id="thumbnail" name="link_picture">
                    </td>
                </tr>
                <tr>
                    <td><strong>Category:</strong></td>
                    <td><input type="text" id="detail-category" name="category" value="" readonly=""></td>
                </tr>
                <tr>
                    <td><strong>Brand: </strong></td>
                    <td><input type="text" id="detail-brand" name="brand" value="" readonly=""></td>
                </tr>
                <tr>
                    <td><strong>Product Name:</strong></td>
                    <td><input type="text" id="detail-name" name="name" value=""></td>
                </tr>
                <tr>
                    <td><strong>Color:</strong></td>
                    <td><input type="text" id="detail-color" name="color" value=""></td>
                </tr>
                <tr>
                    <td><strong>Size:</strong></td>
                    <td><input type="number" id="detail-size" name="size" value=""></td>
                </tr>
                <tr>
                    <td><strong>Description:</strong></td>
                    <td><textarea id="detail-description" name="details" rows="4" cols="50"></textarea></td>
                </tr>
                <tr>
                    <td><strong>Quantity:</strong></td>
                    <td><input type="number" id="detail-quantity" name="quantity" value=""></td>
                </tr>
                <tr>
                    <td><strong>Price:</strong></td>
                    <td><input type="text" id="detail-price" name="price" value=""></td>
                </tr>
                <tr>
                    <td><strong>Sale Percent:</strong></td>
                    <td><input type="number" id="detail-salePercent" name="salePercent" value="" readonly=""></td>
                </tr>
                <tr>
                    <td><strong>Status:</strong></td>
                    <td>
                        <select id="detail-status" name="status">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </td>
                </tr>
            </table>
            <div class="modal-actions">
                <button type="submit" class="btn-update" name="submit" value="update" onclick="confirmUpdate()">Update</button>
                <button type="button" class="btn-delete" name="submit" value="delete" onclick=" confirmDelete()">Delete</button>
            </div>
        </form>
    </div>
</div>


       


        <!-- JavaScript to Handle Modal Display -->
        <script>
            document.querySelector('.avatar').addEventListener('mouseover', function() {
    document.querySelector('.dropdown-content').style.display = 'block';
});

document.querySelector('.dropdown-content').addEventListener('mouseleave', function() {
    document.querySelector('.dropdown-content').style.display = 'none';
});
            function toggleSizeField() {
        const category = document.getElementById('category').value;
        const sizeField = document.getElementById('size-field');
        
        if (category === 'shoes') {
            sizeField.style.display = 'block'; // Show size input when category is shoes
        } else {
            sizeField.style.display = 'none';  // Hide size input for other categories
        }
    }
            function confirmDelete() {
                return confirm("Are you sure you want to delete this product ?");
            }

            function confirmUpdate() {
                return confirm("Are you sure you want to update this product ?");
            }
            document.addEventListener("DOMContentLoaded", function () {
                loadPagination();
                document.getElementById('searchInput').addEventListener('input', filterProducts);
document.querySelectorAll('select[name="categoryFilter"], select[name="statusFilter"]').forEach(select => {
    select.addEventListener('change', filterProducts);
});
            
            function filterProducts() {
    const searchQuery = document.getElementById('searchInput').value !== null ? document.getElementById('searchInput').value : ''; // Search query
const category = document.getElementById('categoryFilter').value !== null ? document.getElementById('categoryFilter').value : ''; // Selected category
const status = document.getElementById('statusFilter').value !== null ? document.getElementById('statusFilter').value : ''; // Selected status


    const xhr = new XMLHttpRequest();
    const url = `LoadProductListStaff?category=` + category + `&status=` + status + `&query=` + searchQuery;
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
                        const page = this.getAttribute('data-page');
                        loadStaffList(page);
                    });
                });
            }

            function loadStaffList(page) {
                const searchQuery = document.getElementById('searchInput').value !== null ? document.getElementById('searchInput').value : ''; // Search query
const category = document.getElementById('categoryFilter').value !== null ? document.getElementById('categoryFilter').value : ''; // Selected category
const status = document.getElementById('statusFilter').value !== null ? document.getElementById('statusFilter').value : ''; // Selected status

                const xhr = new XMLHttpRequest();
                const url = `LoadProductListStaff?page=` + page+`&category=` + category + `&status=` + status + `&query=` + searchQuery;
                console.log(url);
                xhr.open('GET', url, true);

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        document.querySelector('.products-section').innerHTML = xhr.responseText;
                        updateActivePage(page);
                        loadPagination();
                    }
                };

                xhr.onerror = function () {
                    console.error('Error loading data from server.');
                };

                xhr.send();
            }

            function updateActivePage(page) {
                const paginationLinks = document.querySelectorAll('.pagination a');
                paginationLinks.forEach(link => {
                    link.classList.remove('active');
                });
                const activeLink = document.querySelector(`.pagination a[data-page="` + page + `"]`);
                if (activeLink) {
                    activeLink.classList.add('active');
                }
            }
        });
            // Modal for Add Product
            var modal = document.getElementById("myModal");
            var btn = document.getElementById("openModal");
            var span = document.getElementsByClassName("close")[0];

            btn.onclick = function () {
                modal.style.display = "block";
            };

            span.onclick = function () {
                modal.style.display = "none";
            };

            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            };

            // Modal for Product Details
            

            function closeProductDetailModal() {
                document.getElementById("detailModal").style.display = "none";
            }

            function confirmDelete() {
                if (confirm("Are you sure you want to delete this product?")) {
                    // Handle delete logic
                }
            }
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
            function filterTable() {
    // Get the input values and selected filters
    let searchInput = document.getElementById("searchInput").value.toLowerCase();
    let categoryFilter = document.getElementById("categoryFilter").value.toLowerCase();
    let statusFilter = document.getElementById("statusFilter").value.toLowerCase();

    // Get the table and rows
    let table = document.getElementById("productTable");
    let rows = table.getElementsByTagName("tr");

    // Loop through all table rows, excluding the header row
    for (let i = 1; i < rows.length; i++) {
        let cells = rows[i].getElementsByTagName("td");
        let productName = cells[2];
        let productCategory = cells[3];
        let productStatus = cells[6];

        // Ensure all cells are present
        if (productName && productCategory && productStatus) {
            let nameValue = productName.textContent.toLowerCase();
            let categoryValue = productCategory.textContent.toLowerCase();
            let statusValue = productStatus.textContent.toLowerCase();

            // Check if the row matches the filters
            let matchesSearch = nameValue.includes(searchInput) || 
                                (cells[2].firstChild.alt.toLowerCase().includes(searchInput) && cells[2].firstChild.src);

            let matchesCategory = categoryFilter === "" || categoryValue === categoryFilter;
            let matchesStatus = statusFilter === "" || statusValue === (statusFilter === "active" ? 'active' : 'inactive');

            // Show or hide the row based on filters
            if (matchesSearch && matchesCategory && matchesStatus) {
                rows[i].style.display = ""; // Show row
            } else {
                rows[i].style.display = "none"; // Hide row
            }
        }
    }
}

    function showProductDetails(id, thumbnail,  category, brand,name, description, quantity, price, salePercent, status, color, size) {
                document.getElementById('detail-id').value = id;
                document.getElementById('detail-thumbnail').src = thumbnail;  // Only one image
                document.getElementById('detail-name').value = name;
                document.getElementById('detail-category').value = category;
                document.getElementById('detail-brand').value = brand;
                document.getElementById('detail-description').value = description;
                document.getElementById('detail-quantity').value = quantity;
                document.getElementById('detail-price').value = price;
                document.getElementById('detail-salePercent').value = salePercent;
                document.getElementById('detail-status').value = status;
                document.getElementById('detail-color').value = color;
                if (category.toLowerCase() === 'shoes') {
        document.getElementById('detail-size').value = size;
        document.getElementById('detail-size').closest('tr').style.display = "table-row"; // Show size row
    } else {
        document.getElementById('detail-size').value = size;
        document.getElementById('detail-size').closest('tr').style.display = "none"; // Hide size row
    }
                console.log(id);
                document.getElementById('detailModal').style.display = "block";
            }
        </script>
    </body>
</html>
