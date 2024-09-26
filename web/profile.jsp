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

            a {
                color: var(--main-color);
            }

            a:hover {
                color: #e65c00;
            }

            .navbar {
                background-color: var(--main-color);
                padding: 10px;
            }

            .navbar .btn-logout, .navbar .btn-homepage {
                background-color: white;
                color: var(--main-color);
                border-color: var(--main-color);
                margin-left: 10px;
            }

            .navbar .btn-logout:hover, .navbar .btn-homepage:hover {
                background-color: #e65c00;
                color: white;
            }
        </style>
    </head>

    <%
        User cuss = null;
        if(session.getAttribute("currentUser") != null) {
            cuss = (User)session.getAttribute("currentUser");
        }
    %>

    <body>
        <!-- Navbar with Logout and Homepage Button -->
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
                <a class="navbar-brand text-white" href="#">My Profile</a>

                <div class="ms-auto d-flex">
                    <!-- Back to Homepage Button -->
                    <a href="homepage" class="btn btn-homepage">Home</a>

                    <!-- Logout Button -->
                    <form action="logout" method="POST">
                        <button type="submit" class="btn btn-logout">Logout</button>
                    </form>
                </div>
            </div>
        </nav>

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
                                            <div class="mt-5">
                                                <button type="submit" class="btn btn-main text-white fs-4 fw-bold">Update Information</button>
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
        </script>
    </body>
</html>
