<%-- 
    Document   : StaffDashboard
    Created on : 30 thg 10, 2024, 21:13:29
    Author     : Lenovo
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Revenue Dashboard</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"rel="stylesheet"/>
        <link rel="stylesheet" href="css/homestyle.css"/>
    </head>
    <style>
        a.active{
            background-color: black;
            color: white;
            border-radius: 100px;
        }
        tr:hover{
            background-color: #D6EEEE;
        }
        .left-nav-admin {
            height: 100vh;
        }
        .chart-card canvas {
            max-width: 100%;
            height: 300px;
        }

        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: auto;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .filter-section {
            display: flex;
            justify-content: space-around;
            align-items: center;
            background-color: #fff;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .filter-section label, .filter-section select, .filter-section input, .filter-btn {
            margin: 0 5px;
        }

        .filter-btn {
            padding: 8px 12px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .summary-section {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .summary-card {
            flex: 1;
            background-color: #fff;
            margin: 5px;
            padding: 20px;
            text-align: center;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .charts-section {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .chart-card {
            flex: 1;
            background-color: #fff;
            margin: 5px;
            padding: 20px;
            text-align: center;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .table-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #007bff;
            color: white;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
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
</head>
<body>
    <header class="header collapsed" >
        <div class="left-section">
            <a class="text-decoration-none" href="homepage"><img src="images/logo.png" alt="Shop Logo" class="w-auto" style="margin-left: 50px;"></a>
            <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
            <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
        </div>
        <div class="right-section">
            <div class="icons">
                <a href="CustomerManager?Service=updateCustomer&id=${sessionScope.current_user.id}"><img class="w-auto" src="images/profile.png" alt="Account"></a>
            </div>
        </div>
    </header>
      <div class="toggle-button" onclick="toggleNavbar()">☰</div>

        <nav class="navbar hidden" id="navbar">
            <div class="logo">Online Shop</div>
            <div class="dropdown"><a href="homepage">HomePage</a></div>
            <div class="dropdown"><a href="staffDashboard">Dash Board </a></div>
            <div class="dropdown"><a href="staffproductlist">Products Management</a></div>
            <div class="dropdown"><a href="onsale">On Sale Products</a></div>
            <div class="dropdown"><a href="CustomerManager">Customer Manager</a></div>

        </nav>
      <div class="container">
            <h1>Products List</h1>
        <div class="">
            <h1>Order Revenue Dashboard</h1>

<form method="get">
            <!-- Filter Section -->
            <div class="filter-section">
                <label for="start-date">Start Date:</label>
                <input type="date" id="start-date" name="startDate" value="${startDate}">

                <label for="end-date">End Date:</label>
                <input type="date" id="end-date"  name="endDate"  value="${endDate}">

                <label for="order-status">Order Status:</label>
                <select id="order-status" name="status">
                    <option value="all">All</option>
                    <option value="Chờ xác nhận" ${status.equals("Chờ xác nhận")?"selected":""}>Chờ xác nhận</option>
                    <option value="Đã xác nhận" ${status.equals("Đã xác nhận")?"selected":""}>Đã xác nhận</option>
                    <option value="Đang vận chuyển" ${status.equals("Đang vận chuyển")?"selected":""}>Đang vận chuyển</option>
                     <option value="Đã giao" ${status.equals("Đã giao")?"selected":""}>Đã giao</option>
                    <option value="Đã hủy" ${status.equals("Đã hủy")?"selected":""}>Đã hủy</option>
                </select>
                <button class="filter-btn">Apply Filters</button>
            </div>
 </form>
            <!-- Summary Section -->
            <div class="summary-section">
                <div class="summary-card">
                    <c:if test="${status != null}">
                        <h3>Total ${status}</h3>
                        <p id="total-orders">${require}</p>
                    </c:if>
                    <c:if test="${status == null}">
                        <h3>Total Orders</h3>
                        <p id="total-orders">${totalOrder}</p>
                    </c:if>
                </div>
                <div class="summary-card">
                    <h3>Successful Orders</h3>
                    <p id="successful-orders">${succOrder}</p>
                </div>
                <div class="summary-card">
                    <h3>Failed Orders</h3>
                    <p id="failed-orders">${fail}</p>
                </div>
                <div class="summary-card">
                    <h3>Success Rate (%)</h3>
                    <p id="success-rate"><fmt:formatNumber value="${(succOrder/totalOrder) * 100}" type="number" maxFractionDigits="1" minFractionDigits="2" />%</p>
                </div>
            </div>

            <div class="charts-section">
                <!-- Biểu đồ Đơn Hàng Thành Công/Tổng Số Đơn Hàng -->
                <div class="chart-card">
                    <c:if test="${status != null}">
                        <h3>Order status ${status}/Total Trend</h3>
                    </c:if>
                    <c:if test="${status == null}">
                        <h3>Order Success/Total Trend</h3>
                    </c:if>
                    <canvas id="orderTrendChart"></canvas>
                </div>

                <!-- Biểu đồ Tăng Trưởng Doanh Thu -->
                <div class="chart-card">
                    <h3>Revenue Growth Trend (${startDate} to ${endDate})</h3>
                    <canvas id="revenueTrendChart"></canvas>
                </div>
            </div>

            <!-- Order Details Table -->
            <div class="table-section">
                <h3>Order Details</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Order Date</th>
                            <th>Order ID</th>
                            <th>Phone</th>
                            <th>Price (VND)</th>
                            <th>Quantity</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                       
                       <c:if test="${status != null}">
                         <c:forEach var="od" items="${orderRequire}">
                         
                            <c:set value="0" var="quantity"/>
                            <c:set value="0" var="price"/>
                            <c:forEach var="oi" items="${od.orders}">
                                <c:set value="${oi.quantity}" var="quantity"/>
                                <c:set value="${oi.price}" var="price"/>
                            </c:forEach>
                            <tr>
                                <td>${od.createAt}</td>
                                <td>${od.id}</td>
                                <td>${od.phone}</td>
                                <td><fmt:formatNumber value="${price}" type="number" maxFractionDigits="2" minFractionDigits="2" />$</td>
                                <td>${quantity}</td>
                                <td>${od.status}</td>
                            </tr>
                        </c:forEach>
                       </c:if>
                            
                        <c:if test="${status == null}">
                          <c:forEach var="od" items="${orders}">
                            <c:set value="0" var="quantity"/>
                            <c:set value="0" var="price"/>
                            <c:forEach var="oi" items="${od.orders}">
                                <c:set value="${oi.quantity}" var="quantity"/>
                                <c:set value="${oi.price}" var="price"/>
                            </c:forEach>
                            <tr>
                                <td>${od.createAt}</td>
                                <td>${od.id}</td>
                                <td>${od.phone}</td>
                                <td><fmt:formatNumber value="${price}" type="number" maxFractionDigits="2" minFractionDigits="2" />$</td>
                                <td>${quantity}</td>
                                <td>${od.status}</td>
                            </tr>
                          </c:forEach>
                        </c:if>
                     
                    </tbody>
                </table>

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
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        
    const labels = [];
    const orderSuccessData = [];
    const totalOrdersData = [];
     const revenueData = [];
    const orderSuccessDataMap = {}; // Dùng để lưu số đơn hàng thành công theo ngày
    const totalOrdersDataMap = {};
    const revenueDataMap = {};// Dùng để lưu tổng số đơn hàng theo ngày
    let orderDate = '';
    <c:forEach var="od" items="${orders}">
        // Lấy ngày từ `createAt` mà không bao gồm giờ phút giây
         orderDate = "<fmt:formatDate value='${od.createAt}' pattern='yyyy-MM-dd'/>";

        // Khởi tạo giá trị mặc định nếu ngày chưa tồn tại trong `Map`
        if (!orderSuccessDataMap[orderDate]) {
            orderSuccessDataMap[orderDate] = 0;
        }
        if (!totalOrdersDataMap[orderDate]) {
            totalOrdersDataMap[orderDate] = 0;
        }
        if (!revenueDataMap[orderDate]) {
            revenueDataMap[orderDate] = 0;
        }
      <c:if test="${status != null && od.status == status}">
            <c:if test="${od.status == 'Đã giao'}">
                <c:forEach var="oi" items="${od.orders}">
                   revenueDataMap[orderDate] += ${oi.price * oi.quantity}; 
                </c:forEach>
            </c:if>
                orderSuccessDataMap[orderDate] +=1; // Thêm vào `success` nếu đơn hàng thành công
      </c:if>
                
                
         <c:if test="${status == null}">
             // Cộng dồn số lượng đơn hàng cho từng ngày
            <c:if test="${od.status == 'Đã giao'}">
                <c:forEach var="oi" items="${od.orders}">
                   revenueDataMap[orderDate] += ${oi.price * oi.quantity}; 
                </c:forEach>
                orderSuccessDataMap[orderDate] +=1; // Thêm vào `success` nếu đơn hàng thành công
            </c:if>
         </c:if>
            totalOrdersDataMap[orderDate]  +=1; // Cộng dồn tổng số lượng đơn hàng
    </c:forEach>

    // Chuyển dữ liệu từ `Map` sang các mảng `labels`, `orderSuccessData`, và `totalOrdersData`
    for (const date in totalOrdersDataMap) {
        labels.push(date);
        orderSuccessData.push(orderSuccessDataMap[date] || 0);
        totalOrdersData.push(totalOrdersDataMap[date] || 0);
        revenueData.push(revenueDataMap[date] || 0); 
    }

     console.log(labels, orderSuccessData, totalOrdersData, revenueData); // Kiểm tra mảng kết quả

    // Biểu đồ Đơn Hàng Thành Công/Tổng Số Đơn Hàng
    const orderTrendCtx = document.getElementById("orderTrendChart").getContext("2d");
    new Chart(orderTrendCtx, {
        type: "line",
        data: {
            labels: labels,
            datasets: [
                {
    <c:if test="${status != null}">
                         label: "${status} Orders",
    </c:if>
    <c:if test="${status == null}">
                         label: "Successful Orders",
    </c:if>
                    data: orderSuccessData,
                    borderColor: "rgba(75, 192, 192, 1)",
                    borderWidth: 2,
                    fill: false
                },
                {
                    label: "Total Orders",
                    data: totalOrdersData,
                    borderColor: "rgba(255, 99, 132, 1)",
                    borderWidth: 2,
                    fill: false
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'top' },
                tooltip: { mode: 'index', intersect: false }
            },
            scales: {
                x: { title: { display: true, text: "Days" } },
                y: { title: { display: true, text: "Number of Orders" } }
            }
        }
    });

    // Biểu đồ Tăng Trưởng Doanh Thu
    const revenueTrendCtx = document.getElementById("revenueTrendChart").getContext("2d");
    new Chart(revenueTrendCtx, {
        type: "line",
        data: {
            labels: labels,
            datasets: [
                {
                    label: "Revenue (VND)",
                    data: revenueData,
                    borderColor: "rgba(54, 162, 235, 1)",
                    borderWidth: 2,
                    fill: false
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'top' },
                tooltip: { mode: 'index', intersect: false }
            },
            scales: {
                x: { title: { display: true, text: "Days" } },
                y: { title: { display: true, text: "Revenue (VND)" } }
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
