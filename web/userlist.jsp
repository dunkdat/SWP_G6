<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
                background-color: #007bff;
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
                background-color: #007bff;
                color: white;
                text-transform: uppercase;
            }

            table tr:hover {
                background-color: #f1f1f1;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
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
                background-color: #007bff;
                color: white;
                border-radius: 5px;
                text-decoration: none;
                font-size: 16px;
            }

            .add-new-user a:hover {
                background-color: #0056b3;
                text-decoration: none;
            }

            /* Modal styling */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                padding-top: 100px;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.4);
            }

            .modal-content {
                background-color: #fff;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px;
            }

            .modal-content input, .modal-content select {
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }



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

            .submit-btn {
                background-color: #007bff;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .submit-btn:hover {
                background-color: #0056b3;
            }

            /* Detail modal for user information */
            .detail-modal {
                display: none;
                position: fixed;
                z-index: 2;
                padding-top: 100px;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.5);
            }

            .detail-modal-content {
                background-color: #fff;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 60%;
                max-width: 800px;
                border-radius: 10px;
            }

            .detail-modal .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .detail-modal .close:hover, .detail-modal .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .detail-table td {
                padding: 10px;
            }

            .detail-table {
                width: 100%;
                margin-bottom: 20px;
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

            .btn-delete {
                background-color: #dc3545;
            }

            .modal-actions button:hover {
                opacity: 0.9;
            }

            /* Red and italic message styling */
            .message {
                color: red;
                font-style: italic;
            }

        </style>
    </head>
    <body>
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
                        <option value="Online">Active</option>
                        <option value="Offline">Inactive</option>
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
                            <td><img src="images/User_img/${user.imagePath}" alt="Avatar" width="50" height="50"></td>
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
                    <input type="text" id="name" name="name" required>

                    <div style="display: flex;">
                        <label for="gender">Gender:</label>
                        <input type="radio" id="gender" name="gender" value="1" required> Male
                        <input type="radio" id="gender" name="gender" value="0" required> Female
                    </div>
                    <div>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div>
                        <label for="phone">Mobile:</label>
                        <input type="text" id="mobile" name="phone" required>
                    </div>
                    <div>
                        <label for="role">Role:</label>
                        <select id="role" name="role">
                            <option value="Staff Manager">Staff Manager</option>
                            <option value="Staff">Staff</option>
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
                                    <option value="Staff Manager">Staff Manager</option>
                                    <option value="Staff">Staff</option>
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
                        <button type="submit" class="btn-update" name="submit" value="update">Update</button>
                        <button type="submit" class="btn-delete" name="submit" value="delete">Delete</button>
                    </div>

                    <!-- Hidden field to store user ID for update/delete -->
                    <input type="hidden" id="detail-id" name="id" value="">
                </form>
            </div>
        </div>

        <script>
            // Modal functionality
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
                document.getElementById('detail-avatar').src = "images/User_img/" + avatar;
                document.getElementById('detail-name').value = name;
                document.getElementById('detail-mobile').value = phone;
                document.getElementById('detail-email').value = email;
                document.getElementById('detail-role').value = role;
                document.getElementById('detail-status').value = status;

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
        </script>
    </body>
</html>
