<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Page Not Found</title>
      
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
        
        <!-- error not authorized here -->
        <div style="text-align: center;">
        <h1>403 - Not Authorized</h1>
    <p>You do not have permission to view this page.</p>
        </div>
        <script>
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
