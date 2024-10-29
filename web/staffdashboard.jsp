<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard</title>
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
            <div class="dropdown">
                <a href="homepage">Home</a>
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
    <div class="dashboard-container collapsed" id="content">
        <h1>Staff Dashboard</h1>

        <!-- Statistics Section -->
        <div class="statistics">
    <!-- New Orders Chart -->
    <div class="chart-section">
        <h2>Inventories and Goods Sold</h2>
        <canvas id="inventoryChart"></canvas>
    </div>

    <!-- Revenue Chart -->
    <div class="chart-section">
        <h2>Type of products sold</h2>
        <canvas id="pieChart"></canvas>
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
        var trendLabels = JSON.parse('<%= new com.google.gson.Gson().toJson(request.getAttribute("trendLabels")) %>');
    var successOrderData = JSON.parse('<%= new com.google.gson.Gson().toJson(request.getAttribute("successOrderData")) %>');
    var allOrderData = JSON.parse('<%= new com.google.gson.Gson().toJson(request.getAttribute("allOrderData")) %>');

    // Sử dụng dữ liệu đã được chuyển đổi để hiển thị biểu đồ
    var ctx = document.getElementById('orderTrendChart').getContext('2d');
    var orderTrendChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: trendLabels,  // Days (last 7 days)
            datasets: [{
                label: 'Successful Orders',
                data: successOrderData,
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1,
                fill: false
            }, {
                label: 'All Orders',
                data: allOrderData,
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
   var inventories = <%= request.getAttribute("inventories") %>;
var goodSold = <%= request.getAttribute("goodSold") %>;

var ctxInventory = document.getElementById('inventoryChart').getContext('2d');
new Chart(ctxInventory, {
    type: 'bar',
    data: {
        labels: ['Inventory', 'Goods Sold'],  // Nhãn cho hai thanh
        datasets: [
            {
                label: 'Inventory',
                data: [inventories, null],  // Chỉ hiển thị dữ liệu `inventories` trên trục bên trái
                backgroundColor: 'rgba(54, 162, 235, 0.6)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1,
                yAxisID: 'y'
            },
            {
                label: 'Goods Sold',
                data: [null, goodSold],  // Chỉ hiển thị dữ liệu `goodSold` trên trục bên phải
                backgroundColor: 'rgba(255, 99, 132, 0.6)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1,
                yAxisID: 'y1'
            }
        ]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true,
                type: 'linear',
                position: 'left',
                title: {
                    display: true,
                    text: 'Inventory Quantity'
                }
            },
            y1: {
                beginAtZero: true,
                type: 'linear',
                position: 'right',
                title: {
                    display: true,
                    text: 'Goods Sold Quantity'
                },
                ticks: {
                    stepSize: 1  // Đặt bước nhảy của tick là 1
                },
                grid: {
                    drawOnChartArea: false  // Loại bỏ đường lưới cho trục phải
                }
            }
        },
        responsive: true,
        plugins: {
            legend: {
                display: true
            }
        }
    }
});
var categoryLabels = JSON.parse('<%= new com.google.gson.Gson().toJson(request.getAttribute("categoryLabels")) %>');
var categoryValues = JSON.parse('<%= new com.google.gson.Gson().toJson(request.getAttribute("categoryValues")) %>');

var ctxPie = document.getElementById('pieChart').getContext('2d');
new Chart(ctxPie, {
    type: 'pie',
    data: {
        labels: categoryLabels,  // Tên các danh mục
        datasets: [{
            label: 'Products Sold by Category',
            data: categoryValues,  // Số lượng sản phẩm đã bán của từng danh mục
            backgroundColor: [
                'rgba(255, 99, 132, 0.6)',
                'rgba(54, 162, 235, 0.6)',
                'rgba(255, 206, 86, 0.6)',
                'rgba(75, 192, 192, 0.6)',
                'rgba(153, 102, 255, 0.6)',
                'rgba(255, 159, 64, 0.6)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'top'
            }
        }
    }
});
    </script>
</body>
</html>
