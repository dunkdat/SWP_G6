<%-- 
    Document   : profile.jsp
    Created on : 18 Jan, 2024, 8:25:24 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.*" %>
<%@page import="java.util.*" %>
<%@page import="dal.*" %>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>

        <!-- Updated Bootstrap CSS Link -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        
        <!-- Additional CSS (Swiper, FontAwesome, Boxicons, and Custom Styles) -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        
        <!-- Main Color CSS -->
        
        <style>
            .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 2rem 3rem; /* Tăng kích thước padding nhiều hơn */
    background-color: #fff;
    border-bottom: 1px solid #ddd;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); 
    transition: margin-left 0.3s ease-in-out;
    position: relative;
    z-index: 100;
}

.header .left-section img {
    height: 80px; /* Tăng kích thước logo hơn nữa */
    margin-right: 2rem;
}

.header .hotline {
    font-weight: bold;
    color: #ff0000;
    font-size: 1.5rem; /* Tăng kích thước font của hotline */
}

.header .store-locator {
    margin-left: 2.5rem;
    font-weight: bold;
    color: #ff6600;
    font-size: 1.5rem; /* Tăng kích thước font */
}

.header .right-section img {
    height: 50px; /* Tăng kích thước avatar */
    margin-left: 2rem;
}
.footer {
    background-color: #ffe5cc;
    color: black;
    text-align: center;
    padding: 2.5rem; /* Tăng padding để footer cao hơn */
    margin-top: 2.5rem;
    position: relative;
    width: 100%;
    z-index: 100;
}

.footer .footer-content {
    max-width: 1300px; /* Tăng chiều rộng tối đa của phần footer */
    margin: 0 auto;
    padding: 0 30px;
}

.footer .footer-links {
    list-style-type: none;
    padding: 0;
    margin: 2rem 0; /* Tăng margin để giãn cách giữa các link */
}

.footer .footer-links li {
    display: inline;
    margin: 0 30px; /* Tăng khoảng cách giữa các link */
}

.footer .footer-links a {
    color: #333333;
    font-size: 1.3rem; /* Tăng kích thước chữ */
text-decoration: none;
}

.footer .footer-links a:hover {
    color: #000000;
}

.footer .social-media a {
    color: #333333;
    margin: 0 20px; /* Tăng khoảng cách giữa các icon mạng xã hội */
    font-size: 1.8rem; /* Tăng kích thước icon */
}
.nav-bar {
    background-color: #ff6600; /* Màu nền chính */
    padding: 1.5rem 0; /* Tăng kích thước padding để làm cho nav-bar cao hơn */
    display: flex;
    justify-content: center;
    gap: 2rem; /* Khoảng cách giữa các liên kết */
    box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1); /* Tạo bóng cho phần nav-bar */
}

.nav-bar a {
    color: #fff; /* Màu chữ */
    font-size: 1.5rem; /* Tăng kích thước font chữ */
    text-decoration: none; /* Loại bỏ gạch chân */
    font-weight: bold;
    padding: 0.5rem 1.5rem; /* Tăng khoảng cách bên trong giữa chữ và khung */
    border-radius: 5px;
    transition: background-color 0.3s ease, transform 0.3s ease; /* Thêm hiệu ứng khi hover */
}

.nav-bar a:hover {
    background-color: #e65c00;  /* Phóng to nhẹ khi hover */
}


            :root {
                --main-color: #ff6600;
            }
            
            /* Change the button and main colors */
            .btn-main {
                background-color: var(--main-color);
                border-color: var(--main-color);
                color: white;
            }

            .btn-main:hover {
                background-color: #e65c00;
                border-color: #e65c00;
            }

            h1, h2, h3, h4, h5, h6 {
                color: var(--main-color);
            }

         
            .btn-main {
    background-color: var(--main-color);
    border-color: var(--main-color);
    color: white;
    padding: 10px 20px;
    text-decoration: none; /* Ensure no underline on the link */
}

.btn-main:hover {
    background-color: #e65c00;
    border-color: #e65c00;
    color: white;
} 


        </style>
        <link rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" href="css/homestyle.css"/>
        
    </head>
    
    <%
        User cuss = null;
        if(session.getAttribute("currentUser") != null) {
            cuss = (User)session.getAttribute("currentUser");
        }
    %>

    <body>
         <!-- Header Section -->
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
                        <img src="images/profile.png" alt="Account" class="avatar">
                    </c:if>
                    <c:if test="${current_user != null}">
<img src="images/User_img/${current_user.imagePath}" alt="Account" class="avatar">
                    </c:if>
                </a>
                <c:if test="${current_user != null}">
                    <div class="dropdown-content">
                        <img src="images/User_img/${current_user.imagePath}" alt="Avatar" class="dropdown-avatar">
                        <a href="ProfileServlet?current_user=${sessionScope.current_user}">Profile</a>
                        <a href="logout">Logout</a>
                    </div>
                </c:if>
                <c:if test="${current_user == 'Customer'}">
                    <img src="images/cart.png" alt="Cart">
                </c:if>
            </div>
        </div>
    </header>
    <section class="nav-bar">
            <a href="homepage">Home Page</a>
            <a href="#">Sale</a>
            <a href="#">Voucher</a>
            <a href="aboutus.jsp">About Us</a>
            <a href="contact.jsp">Contact</a>
        </section>
    

        <section>
            <div class="container">
                <h1 class="my-4">Account</h1>

                <!-- Navigation Links for Profile Sections -->
                <div class="mt-5">
                    <ul class="d-flex py-4 border-top border-bottom text-center px-3">
                        <c:forEach var="service" items="${requestScope.listService}">
                            <li class="me-5">
                                <a href="profile?Service=${service}"
                                   <c:if test="${service == requestScope.current}">
                                       style="text-decoration: underline; text-decoration-color: var(--main-color);"
                                   </c:if>
                                   <c:if test="${service != requestScope.current}">
                                       style="text-decoration: none;"
                                   </c:if>
                                   class="fs-3 text-dark">${service}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <!-- Display Message of Action Success/Failure -->
                <div class="">
                    <c:if test="${isSuccess != null}">
                        <div class="fs-4 alert ${isSuccess == true ? 'alert-success' : 'alert-danger'}" role="alert">
                            ${mess}
                        </div>
                    </c:if>

                    <!-- Account Information Form -->
                    <c:if test="${requestScope.current.equals('Account info')}">
                        <form action="ProfileServlet" method="POST" enctype="multipart/form-data">
                            <input name="Service" value="updateInfo" hidden>
                            <div class="mt-5">
                                <h1 class="fw-bold">Account Information</h1>
                                <div class="row py-5">
<div class="col-md-3">
                                        <div class="account-img position-relative">
                                            <% if(cuss.getImagePath() == null) { %>
                                                <img src="https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="" id="boxImage" class="img-fluid rounded-circle">
                                            <% } else { %>
                                                <img src="${IConstant.PATH_USER}/<%=cuss.getImagePath()%>" alt="" id="boxImage" class="img-fluid rounded-circle">
                                            <% } %>
                                            <div class="change-userImg">
                                                <i class='bx bx-image-add fs-3'></i>
                                                <span>Change image</span>
                                            </div>
                                            <input type="file" 
                                                   onchange="previewImage(this)"
                                                   accept="image/gif, image/jpeg, image/png, image/jpg"
                                                   class="input-userImg form-control"
                                                   name="accountImage">
                                            <input value="<%=cuss.getImagePath()%>" name="beforeImage" type="hidden"/>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="user-info">
                                            <div class="mt-5">
                                                <h3 class="fw-medium">Name</h3>
                                                <div class="input-group">
                                                    <input type="text" name="name" value="<%=cuss.getName()%>" class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="Name">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3 class="fw-medium">Address</h3>
                                                <div class="input-group">
                                                    <input type="text" name="address" value="<%=cuss.getAddress()%>" class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="Address">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3>Email</h3>
                                                <div class="input-group mb-3">
<span class="input-group-text p-4"><i class="fa-regular fa-envelope fs-3"></i></span>
                                                    <input type="text" name="email" readonly value="<%=cuss.getEmail()%>" class="form-control px-4 py-3 fs-3" placeholder="Email">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3>Phone</h3>
                                                <div class="input-group mb-3">
                                                    <span class="input-group-text p-4"><i class="fa-solid fa-phone fs-3"></i></span>
                                                    <input type="text" name="phone" value="<%=cuss.getPhone()%>" class="form-control px-4 py-3 fs-3" placeholder="Phone">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3>Gender</h3>
                                                <div class="d-flex align-items-center">
                                                    <label class="me-3">Male</label>
                                                    <input type="radio" name="gender" value="1" <%= (cuss.getGender() == 1) ? "checked" : "" %> class="me-3">
                                                    <label class="me-3">Female</label>
                                                    <input type="radio" name="gender" value="0" <%= (cuss.getGender() == 0) ? "checked" : "" %>>
                                                </div>
                                            </div>
                                            <div class="mt-5 d-flex justify-content-between">
    <!-- Update Information Button -->
    <button type="submit" class="btn btn-main text-white fs-4 fw-bold">Update Information</button>
    
    <!-- Logout Button as Link -->
    <a href="logout" class="btn btn-main text-white fs-4 fw-bold">Logout</a>
</div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>

                    <!-- Change Password Form -->
                    <c:if test="${requestScope.current.equals('Change password')}">
                        <div class="mt-5">
                            <h1 class="fw-bold">Update your password</h1>
                            <div class="row py-5">
                                <div class="col-md-12">
                                    <form action="ProfileServlet" method="post">
                                        <input name="Service" value="updatePassword" hidden />
                                        <div class="change-password">
<div class="mt-5">
                                                <h3 class="fw-medium">Current password</h3>
                                                <div class="input-group">
                                                    <input type="password" name="currentPassword" class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="Password">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3 class="fw-medium">New password</h3>
                                                <div class="input-group">
                                                    <input type="password" name="newPassword" class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="New Password">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3 class="fw-medium">Confirm password</h3>
                                                <div class="input-group">
                                                    <input type="password" name="confirmPassword" class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="Confirm Password">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <button type="submit" class="btn btn-main text-white fs-4 fw-bold">Update Password</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>
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
        <!-- Include Bootstrap JS and Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>

        <!-- Custom JS -->
        <script src="./js/app.js"></script>
        <script>
            function previewImage(input) {
                var imagePreview = document.getElementById('boxImage');
                var file = input.files[0];
                if (file) {
                    if (isImageFile(file)) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            imagePreview.src = e.target.result;
                        };
                        reader.readAsDataURL(file);
                    } else {
                        alert('Not a valid file');
                    }
                }
            }

            function isImageFile(file) {
                var imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
                var fileName = file.name.toLowerCase();
                var fileExtension = fileName.split('.').pop();
                return imageExtensions.includes(fileExtension);
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