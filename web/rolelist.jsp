<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Roles Settings</title>
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

            /* Styling the search and filter section */
            .search-filter {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .search-filter input[type="text"] {
                padding: 10px;
                width: 40%;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .search-filter select {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-right: 10px;
            }

            .search-filter button {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .search-filter button:hover {
                background-color: #218838;
            }

            /* Styling the user table */
            table {
    width: 100%; /* Make the table take up the full width of the container */
    border-collapse: collapse;
    margin-bottom: 20px;
    background-color: #fff;
    font-size: 18px; /* Increase font size */
}

table thead {
    background-color: #ffcc99;
    color: white;
}

table th, table td {
    padding: 20px; /* Increase padding for larger cells */
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
    background-color: #ffcc99; /* Màu cam nhạt */
}

table tr td img {
    border-radius: 50%;
    border: 2px solid #ddd;
    width: 50px;
    height: 50px;
}

table tr td {
    color: #333;
    font-size: 18px; /* Increase font size for table content */
}

/* Style for the Add New Category button */
.add-new-role {
    text-align: right;
    margin-bottom: 20px;
}

.add-new-role a {
    padding: 15px 30px; /* Make the button larger */
    background-color: #ff6600;
    color: white;
    border-radius: 5px;
    text-decoration: none;
    font-size: 18px; /* Increase font size for the button */
    font-weight: bold;
    display: inline-block;
    transition: background-color 0.3s ease;
}

.add-new-role a:hover {
    background-color: #ff9933; /* Change the background color on hover */
    transition: 0.3s;
}

/* Modal styling */
/* Modal styling for adding new user */
.modal {
    display: none;
    position: fixed;
    z-index: 10;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4); /* Dimmed background */
    padding-top: 50px; /* Center modal vertically */
}

.modal-content {
    background-color: #fff;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 500px;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
    border-radius: 10px;
    position: relative;
}

/* Close button styling */
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover, .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

/* Modal header styling */
.modal-content h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}

/* Input fields inside modal */
.modal-content input,
.modal-content select,
.modal-content textarea {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box; /* Ensures padding is included in element width */
}

/* Submit button for modal */
.submit-btn {
    background-color: #007bff;
    color: white;
    padding: 15px; /* Increase padding for a larger button */
    border: none;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
    text-align: center;
    margin-top: 10px;
    font-size: 18px; /* Increase font size */
}

.submit-btn:hover {
    background-color: #0056b3;
    transition: 0.3s;
}

           

/* Close button styling */
.detail-modal .close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.detail-modal .close:hover, 
.detail-modal .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

/* Header for detail modal */
.detail-modal-content h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
}

/* Table for displaying user details */
.detail-table {
    width: 100%;
    margin-bottom: 20px;
    border-spacing: 0;
}

.detail-table td {
    padding: 10px;
    vertical-align: top;
}

.detail-table td:first-child {
    width: 30%;
    font-weight: bold;
}

.detail-table td:last-child {
    width: 70%;
}

.detail-table img {
    border-radius: 50%;
    border: 2px solid #ddd;
    width: 100px;
    height: 100px;
}

/* Inputs for user details */
.detail-table input, 
.detail-table select, 
.detail-table textarea {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

/* Modal action buttons */
.modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
}

.modal-actions button {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    color: #fff;
    transition: opacity 0.3s ease;
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
            <div class="dropdown"><a href="userlist">User Management</a></div>
            <div class="dropdown"><a href="settinglist">Setting Management</a></div>
            
            
            
        </nav>
        <div class="container">
            <h1>Role Settings</h1>
            <label for="choice">Manage: </label>
        <select id="choice">
            <option value="role">Role</option>
            <option value="category">Category</option>
            
        </select>
            <label for="searchInput">Search: </label>
        <input type="text" id="searchInput" placeholder="Search by name">
        <label for="statusFilter">Filter by status: </label>
        <select id="statusFilter" name="statusFilter">
            <option value="">All Statues</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
        </select>
            <div class="role-section">
            <table id="roleTable">
                <thead>
                    <tr>
                        <th>Role Name</th>
                        <th>Details</th>
                        <th>Employees</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="roleTableBody">
                    <c:forEach var="role" items="${requestScope.roleList}">
                        <tr>
                            <td>${role.id}</td>
                            <td>${role.details}</td>
                            <td>${role.employee}</td>
                          
                        <td style="color: ${role.status == 'inactive' ? 'red' : 'green'}">${role.status == 'active' ? 'Active' : 'Inactive'}</td>
                    
                            <td>
                                <button onclick="editRole('${role.id}', '${role.details}','${role.employee}', '${role.status}')">Details</button>
                            </td>
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
            <div class="add-new-role">
                <a href="#" id="openModal">Add New Role</a>
            </div>
        </div>
            
<!-- Modal for Editing Role Details (ID, Details, and employee) -->
<div id="editRoleModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeEditModal">&times;</span>
        <h2 id="editModalTitle">Role Details</h2>
        <form id="editRoleForm" action="roledetail">
            <!-- Hidden Role ID Input -->
            <label for="editRoleId">Role Name</label>
            <input type="text" id="editRoleId" name="id" readonly="">

            <!-- Role Name Input -->
            <label for="editRoleDetails">Role Details</label>
            <input type="text" id="editRoleDetails" name="details" required>

            <!-- employee Input -->
            <label for="editEmployee">Employee</label>
            <input type="number" id="editEmployee" name="Employee" min="0" readonly="">
            <label for="editStatus">Employee</label>
            <select name="status" id="editStatus">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
            <!-- Submit Button -->
            <button type="submit" name="submit" value="update" class="submit-btn" id="saveEditRoleBtn" onclick=" confirmUpdate()">Update</button>
        </form>
    </div>
</div>
<div id="addRoleModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeAddModal">&times;</span>
        <h2 id="addModalTitle">Add New Role</h2>
        <form id="addRoleForm" action="rolelist">
            <label for="addRoleId">Role Name</label>
            <input type="text" id="addRoleId" name="id">
            <!-- Role Name Input -->
            <label for="addRoleDetails">Role Details</label>
            <input type="text" id="addRoleDetails" name="details" required>

            <!-- Submit Button -->
            <button type="submit" name="submit" value="add" class="submit-btn" id="saveAddRoleBtn">Add Role</button>
        </form>
    </div>
</div>
<footer class="footer" style="margin-top: 10%" >
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
        <!-- JavaScript to handle modal and form actions -->
        <script>
              const avatarElement = document.querySelector('.avatar');
if (avatarElement) {
    avatarElement.addEventListener('mouseover', function () {
        document.querySelector('.dropdown-content').style.display = 'block';
    });
}
            document.querySelector('.dropdown-content').addEventListener('mouseleave', function () {
                document.querySelector('.dropdown-content').style.display = 'none';
            });  // Modal functionality
            document.getElementById("choice").addEventListener("change", function() {
        // Lấy giá trị từ lựa chọn
        var selectedValue = this.value;
        
        // Kiểm tra giá trị và chuyển hướng người dùng
        if (selectedValue === "category") {
            window.location.href = "settinglist"; // URL của servlet CategoryList
        } else if (selectedValue === "role") {
            window.location.href = "rolelist"; // URL của servlet RoleList
        }
    });
            function confirmDelete() {
                return confirm("Are you sure you want to delete this role ?");
            }

            function confirmUpdate() {
                return confirm("Are you sure you want to update this role ?");
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
        // Function to open the Add Role modal
document.getElementById('openModal').addEventListener('click', function (event) {
    event.preventDefault();
    document.getElementById('addRoleModal').style.display = 'block';
});

// Function to open the Edit Role modal
function editRole(id, details, Employee, status) {
    // Populate modal fields with Role data
    document.getElementById('editRoleId').value = id;
    document.getElementById('editRoleDetails').value = details;
    document.getElementById('editEmployee').value = Employee;
    document.getElementById('editStatus').value = status;
    // Display the Edit Role modal
    document.getElementById('editRoleModal').style.display = 'block';
}

// Function to close modals
function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Add event listener for closing Add Role modal
document.getElementById('closeAddModal').addEventListener('click', function () {
    closeModal('addRoleModal');
});

// Add event listener for closing Edit Role modal
document.getElementById('closeEditModal').addEventListener('click', function () {
    closeModal('editRoleModal');
});

// Close modal if the user clicks outside of the modal content
window.onclick = function (event) {
    const addModal = document.getElementById('addRoleModal');
    const editModal = document.getElementById('editRoleModal');
    
    if (event.target == addModal) {
        closeModal('addRoleModal');
    } else if (event.target == editModal) {
        closeModal('editRoleModal');
    }
}
document.addEventListener("DOMContentLoaded", function () {
                loadPagination();
                document.getElementById('searchInput').addEventListener('input', filterRole);
document.querySelector('#statusFilter').addEventListener('change', filterRole);
            
            function filterRole() {
    const searchQuery = document.getElementById('searchInput').value !== null ? document.getElementById('searchInput').value : ''; // Search query
const status = document.getElementById('statusFilter').value !== null ? document.getElementById('statusFilter').value : ''; // Selected status


    const xhr = new XMLHttpRequest();
    const url = `LoadRoleListServlet?status=` + status + `&query=` + searchQuery;
    console.log(url);
    xhr.open('GET', url, true);

    xhr.onload = function () {
        if (xhr.status === 200) {
            // Update the product section with the filtered products
            document.querySelector('.role-section').innerHTML = xhr.responseText;

            // Reattach pagination and other listeners if needed
            loadPagination();
        } else {
            console.error('Failed to load role. Status:', xhr.status);
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
                        loadSettingList(page);
                    });
                });
            }

            function loadRoleList(page) {
                const searchQuery = document.getElementById('searchInput').value !== null ? document.getElementById('searchInput').value : ''; // Search query
const status = document.getElementById('statusFilter').value !== null ? document.getElementById('statusFilter').value : ''; // Selected status

                const xhr = new XMLHttpRequest();
                const url = `LoadRoleListServlet?page=` + page+ `&status=` + status + `&query=` + searchQuery;
                console.log(url);
                xhr.open('GET', url, true);

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        document.querySelector('.role-section').innerHTML = xhr.responseText;
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
        function filterTable() {
    // Get the input values and selected filters
    let searchInput = document.getElementById("searchInput").value.toLowerCase();
    let statusFilter = document.getElementById("statusFilter").value.toLowerCase();

    // Get the table and rows
    let table = document.getElementById("roleTable");
    let rows = table.getElementsByTagName("tr");

    // Loop through all table rows, excluding the header row
    for (let i = 0; i < rows.length; i++) {
        let cells = rows[i].getElementsByTagName("td");
        let roleName = cells[0];
        let roleStatus = cells[3];

        // Ensure all cells are present
        if (roleName && roleStatus) {
            let nameValue = roleName.textContent.toLowerCase();
            let statusValue = roleStatus.textContent.toLowerCase();

            // Check if the row matches the filters
            let matchesSearch = nameValue.includes(searchInput);
            let matchesStatus = statusFilter === "" || statusValue === (statusFilter === "active" ? 'active' : 'inactive');

            // Show or hide the row based on filters
            if (matchesSearch && matchesStatus) {
                rows[i].style.display = ""; // Show row
            } else {
                rows[i].style.display = "none"; // Hide row
            }
        }
    }
}
        </script>
    </body>
</html> 
