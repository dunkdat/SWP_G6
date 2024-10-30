<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Management</title>
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
            }

            /* Add new user button */
            .add-new-user {
                text-align: right;
                margin-bottom: 20px;
            }

            .add-new-user a {
                padding: 10px 20px;
                background-color: #ff6600;
                color: white;
                border-radius: 5px;
                text-decoration: none;
                font-size: 16px;
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

/* Radio buttons for gender */
.modal-content input[type="radio"] {
    margin-left: 10px;
    margin-right: 5px;
}

.modal-content label[for="gender"] {
    display: inline-block;
    margin-right: 15px;
}

/* Submit button for modal */
.submit-btn {
    background-color: #007bff;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
    text-align: center;
    margin-top: 10px;
}

.submit-btn:hover {
    background-color: #0056b3;
    transition: 0.3s;
}
.detail-modal {
    display: none;
    position: fixed;
    z-index: 10;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* Dimmed background */
    padding-top: 50px; /* Center the modal vertically */
}

.detail-modal-content {
    background-color: #fff;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 700px;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
    border-radius: 10px;
    position: relative;
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
            <h1>User Management</h1>

            <!-- Search and Filter Section -->
            <div class="search-filter">
                <form id="searchForm" style="width: 100%; display: flex; justify-content: space-between;">
                    <input type="text" id="searchInput" placeholder="Search by Name, Email, Mobile" onkeyup="filterTable()">
                    <select id="roleFilter" onchange="filterTable()">
                        <option value="">All Roles</option>
                        <option value="Staff Manager">Staff Manager</option>
                        <option value="Staff">Staff</option>
                    </select>
                    <select id="statusFilter" onchange="filterTable()">
                        <option value="">All Statuses</option>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </form>
            </div>

            <!-- Table for User List -->
            <table id="userTable">
                <thead>
                    <tr>
                        <th>Avatar</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userlist}">
                        <tr>
                            <td><img src="${IConstant.PATH_USER}/${user.imagePath}" alt="Avatar" width="50" height="50"></td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>${user.role}</td>
                            <td style="color: ${user.status == 'inactive' ? 'red' : 'green'}">${user.status == 'active' ? 'Active' : 'Inactive'}</td>
                            <td><button class="details-btn" onclick="showDetails('${user.id}', '${user.imagePath}', '${user.name}', '${user.phone}', '${user.email}', '${user.role}', '${user.status}')">Details</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Button to Add New User -->
            <div class="add-new-user">
                <a href="#" class="btn-add" id="openModal">Add New User</a>
            </div>
        </div>

        <!-- Modal for Adding New User -->
       <div id="myModal" class="modal" style="display: ${message != null ? 'block' : 'none'}">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Add New User</h2>
        <form action="userlist" method="post" enctype="multipart/form-data">
            <div>
                <label for="avatar">Avatar:</label>
                <input type="file" id="avatar" name="avatar" required="">
            </div>

            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" value="${name != null ? name : ''}" required>

            <div style="display: flex;">
                <label for="gender">Gender:</label>
                <input type="radio" id="gender_male" name="gender" value="1" ${gender == 1 ? 'checked' : ''} required> Male
                <input type="radio" id="gender_female" name="gender" value="0" ${gender == 0 ? 'checked' : ''} required> Female
            </div>

            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${email != null ? email : ''}" required>
            </div>

            <div>
                <label for="phone">Mobile:</label>
                <input type="text" id="mobile" name="phone" value="${phone != null ? phone : ''}" required>
            </div>

            <div>
                <label for="role">Role:</label>
                <select name="role">
                    <c:forEach items="${requestScope.roleList}" var="n">
                                        <option value="${n.id}" ${role == n.id ? 'selected' : ''}>${n.id}</option>
                                    </c:forEach>
                                </select>
            </div>

            <div>
                <button type="submit" name="submit" value="add" class="submit-btn">Add User</button>
            </div>
        </form>

        <div class="message">${message}</div>
    </div>
</div>

        <!-- Detail Modal -->
        <div id="detailModal" class="detail-modal">
            <div class="detail-modal-content">
                <span class="close" onclick="closeDetailModal()">&times;</span>
                <h2>User Details</h2>
                <form id="userForm" action="userdetail" method="post">
                    <table class="detail-table">
                        <tr>
                            <td><strong>Avatar:</strong></td>
                            <td>
                                <img id="detail-avatar" src="" alt="Avatar" width="100" height="100">
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Full Name:</strong></td>
                            <td>
                                <input type="text" id="detail-name" name="name" value="" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Mobile:</strong></td>
                            <td>
                                <input type="text" id="detail-mobile" name="phone" value="" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Email:</strong></td>
                            <td>
                                <input type="email" id="detail-email" name="email" value="" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Role:</strong></td>
                            <td>
                                <select id="detail-role" name="role">
                                    <c:forEach items="${requestScope.roleList}" var="n">
                                        <option value="${n.id}">${n.id}</option>
                                    </c:forEach>
                                </select>
                            </td>
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
                        <button type="submit" class="btn-update" name="submit" value="update" onclick=" confirmUpdate()">Update</button>
                        <button type="submit" class="btn-delete" name="submit" value="delete" onclick=" confirmUpdate()">Delete</button>
                    </div>

                    <!-- Hidden field to store user ID for update/delete -->
                    <input type="hidden" id="detail-id" name="id" value="">
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

        <script>
            document.querySelector('.avatar').addEventListener('mouseover', function() {
    document.querySelector('.dropdown-content').style.display = 'block';
});

document.querySelector('.dropdown-content').addEventListener('mouseleave', function() {
    document.querySelector('.dropdown-content').style.display = 'none';
});
            // Modal functionality
            function confirmDelete() {
                return confirm("Are you sure you want to delete this user ?");
            }

            function confirmUpdate() {
                return confirm("Are you sure you want to update this user ?");
            }
            var modal = document.getElementById("myModal");
            var btn = document.getElementById("openModal");
            var span = document.getElementsByClassName("close")[0];

            btn.onclick = function () {
                modal.style.display = "block";
            }

            span.onclick = function () {
                modal.style.display = "none";
            }

            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }

            // JavaScript function for filtering the table based on search input and filters
            function filterTable() {
                let searchInput = document.getElementById('searchInput').value.toLowerCase();
                let roleFilter = document.getElementById('roleFilter').value.toLowerCase();
                let statusFilter = document.getElementById('statusFilter').value.toLowerCase();
                let table = document.getElementById('userTable');
                let tr = table.getElementsByTagName('tr');

                for (let i = 1; i < tr.length; i++) { // Start at 1 to skip the header row
                    let tdName = tr[i].getElementsByTagName('td')[1];
                    let tdEmail = tr[i].getElementsByTagName('td')[2];
                    let tdPhone = tr[i].getElementsByTagName('td')[3];
                    let tdRole = tr[i].getElementsByTagName('td')[4];
                    let tdStatus = tr[i].getElementsByTagName('td')[5];

                    if (tdName && tdEmail && tdPhone && tdRole && tdStatus) {
                        let nameValue = tdName.textContent.toLowerCase();
                        let emailValue = tdEmail.textContent.toLowerCase();
                        let phoneValue = tdPhone.textContent.toLowerCase();
                        let roleValue = tdRole.textContent.toLowerCase();
                        let statusValue = tdStatus.textContent.toLowerCase();

                        if (
                                (nameValue.indexOf(searchInput) > -1 || emailValue.indexOf(searchInput) > -1 || phoneValue.indexOf(searchInput) > -1 || searchInput === '') &&
                                (roleFilter === '' || roleValue === roleFilter) &&
                                (statusFilter === '' || statusValue === statusFilter)
                                ) {
                            tr[i].style.display = '';
                        } else {
                            tr[i].style.display = 'none';
                        }
                    }
                }
            }

            // Function to show the details and populate the modal with current user information
           function showDetails(id, avatar, name, phone, email, role, status) {
    document.getElementById('detail-id').value = id;
    document.getElementById('detail-avatar').src = "${IConstant.PATH_USER}/" + avatar;
    document.getElementById('detail-name').value = name;
    document.getElementById('detail-mobile').value = phone;
    document.getElementById('detail-email').value = email;
    document.getElementById('detail-status').value = status;

    // Find the role option that matches the user's role and set it as selected
    const roleDropdown = document.getElementById('detail-role');
    for (let i = 0; i < roleDropdown.options.length; i++) {
        if (roleDropdown.options[i].value === role) {
            roleDropdown.selectedIndex = i;
            break;
        }
    }

    document.getElementById('detailModal').style.display = "block";
}

            function closeDetailModal() {
                document.getElementById('detailModal').style.display = "none";
            }

            window.onclick = function (event) {
                let modal = document.getElementById('detailModal');
                if (event.target == modal) {
                    modal.style.display = "none";
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
        </script>
    </body>
</html>
