<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Inline CSS for styling -->
    <link rel="stylesheet" href="css/homestyle.css"/>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f4f6f9;
            padding: 20px;
        }

        .dashboard-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: margin-left 0.3s ease-in-out;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .date-range-filter {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .date-range-filter form {
            display: flex;
            gap: 10px;
        }

        .date-range-filter label {
            font-weight: bold;
            color: #555;
        }

        .date-range-filter input {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .date-range-filter button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .date-range-filter button:hover {
            background-color: #45a049;
        }

        .statistics {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .statistics div {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .statistics h2 {
            margin-bottom: 10px;
            color: #444;
            font-size: 18px;
            text-transform: uppercase;
        }

        .statistics p {
            font-size: 16px;
            color: #333;
        }

        .order-trend {
            margin-top: 40px;
        }

        .order-trend h2 {
            margin-bottom: 15px;
            text-align: center;
            font-size: 20px;
            color: #333;
        }

        /* Style for the chart canvas */
        canvas {
            width: 100% !important;
            height: auto !important;
        }
        .header.expanded, .dashboard-container.expanded, footer.expanded{
            margin-left: 200px;
        }

        .header.collapsed, .dashboard-container.collapsed,footer.collapsed{
            margin-left: 0;
        }
    </style>
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
    
    <c:if test="${current_user.role == 'Customer'}">
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
    <div class="dashboard-container collapsed" id="content">
        <h1>Admin Dashboard</h1>

        <!-- Date Range Filter -->
        <div class="date-range-filter">
            <form method="GET" action="dashboard.jsp">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" value="<%= request.getParameter("startDate") %>">

                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" value="<%= request.getParameter("endDate") %>">

                <button type="submit">Apply</button>
            </form>
        </div>

        <!-- Statistics Section -->
        <div class="statistics">
            <!-- New Orders Section -->
            <div class="orders-section">
                <h2>New Orders</h2>
                <p>Success: <%= request.getAttribute("successOrders") %></p>
                <p>Cancelled: <%= request.getAttribute("cancelledOrders") %></p>
                <p>Submitted: <%= request.getAttribute("submittedOrders") %></p>
            </div>

            <!-- Revenues Section -->
            <div class="revenues-section">
                <h2>Revenues</h2>
                <p>Total: <%= request.getAttribute("totalRevenues") %></p>
                <p>By Product Categories: <%= request.getAttribute("revenuesByCategories") %></p>
            </div>

            <!-- Customers Section -->
            <div class="customers-section">
                <h2>Customers</h2>
                <p>Newly Registered: <%= request.getAttribute("newRegisteredCustomers") %></p>
                <p>Newly Bought: <%= request.getAttribute("newBoughtCustomers") %></p>
            </div>

            <!-- Feedbacks Section -->
            <div class="feedbacks-section">
                <h2>Feedbacks</h2>
                <p>Average Star (Total): <%= request.getAttribute("avgFeedbackStarTotal") %></p>
                <p>By Product Categories: <%= request.getAttribute("avgFeedbackByCategories") %></p>
            </div>
        </div>

        <!-- Trend of Order Counts Section -->
        <div class="order-trend">
            <h2>Trend of Order Counts (Last 7 Days)</h2>
            <canvas id="orderTrendChart"></canvas>
        </div>
    </div>
   <footer class="footer collapsed">
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
    <!-- Include Chart.js for visualizing the trend -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.querySelector('.avatar').addEventListener('mouseover', function() {
    document.querySelector('.dropdown-content').style.display = 'block';
});

document.querySelector('.dropdown-content').addEventListener('mouseleave', function() {
    document.querySelector('.dropdown-content').style.display = 'none';
});
function toggleNavbar() {
                const navbar = document.getElementById('navbar');
                const content = document.getElementById('content');
                const header = document.querySelector('.header');
                const footer = document.querySelector('.footer');

                navbar.classList.toggle('hidden');
                navbar.classList.toggle('visible');
                footer.classList.toggle('expanded');
                content.classList.toggle('expanded');
                header.classList.toggle('expanded');
                footer.classList.toggle('collapsed');
                content.classList.toggle('collapsed');
                header.classList.toggle('collapsed');
            }
        // Assuming you have trend data coming from the backend
        var ctx = document.getElementById('orderTrendChart').getContext('2d');
        var orderTrendChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: <%= request.getAttribute("trendLabels") %>,  // Days (last 7 days)
                datasets: [{
                    label: 'Successful Orders',
                    data: <%= request.getAttribute("successOrderData") %>,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1,
                    fill: false
                }, {
                    label: 'All Orders',
                    data: <%= request.getAttribute("allOrderData") %>,
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1,
                    fill: false
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
