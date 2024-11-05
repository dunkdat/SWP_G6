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
        <link rel="stylesheet" href="css/homestyle.css"/>
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>

            .block-info {
                margin-bottom: 180px;
            }

            .list_pay-method {
                height: 320px;
                overflow-y: scroll;
            }
            .box-info_orders {
                transition: all 0.5s linear;
            }
            .box-info_address input[type="radio"] {
                margin-right: 10px; /* Tạo khoảng cách giữa input và văn bản */
            }

            .box-info_address .d-flex {
                align-items: center; /* Đảm bảo các thành phần cùng hàng với nhau */
            }

            .box-info_address p {
                margin-bottom: 0; /* Loại bỏ khoảng cách dưới của phần tử <p> */
            }

            .box-info_address input[type="radio"] {
                float: left; /* Đảm bảo input nằm bên trái */
                margin-top: 0; /* Điều chỉnh vị trí để thẳng hàng với văn bản */
            }

            /* Sử dụng !important để đảm bảo override Bootstrap nếu cần */
            .box-info_address input[type="radio"],
            .box-info_address p {
                display: inline-block !important; /* Đảm bảo input và văn bản nằm trên cùng một hàng */
            }
        </style>
    </head>

    <%
                User cuss = null;
                if(session.getAttribute("current_user") != null) {
                    cuss = (User)session.getAttribute("current_user");
                }
    %>

    <body>
        <header class="header collapsed">
            <div class="left-section">
                <a href="homepage"><img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px; width: 60px;"></a>
                <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
                <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
            </div>
            <div class="right-section">
                <div class="icons">
                    <a href="ProfileServlet?current_user=${sessionScope.current_user.id}">
                        <c:if test="${current_user == null}">
                            <img src="images/profile.png" alt="Account" >
                        </c:if>
                        <c:if test="${current_user != null}">
                            <c:if test="${current_user.imagePath == null}">
                                <img src="images/profile.png" alt="Account" class="avatar">
                            </c:if>
                            <c:if test="${current_user.imagePath != null}">
                                <img src="${IConstant.PATH_USER}${current_user.imagePath}" alt="Account" class="avatar">   
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
                        <a href="cart"><img src="images/cart.png" alt="Cart"></a> 
                        </c:if>
                </div>
            </div>
        </header>
        <section>
            <div class="container">
                <h1 class="my-4">Account</h1>

                <!-- Navigation Links for Profile Sections -->
                <div class="mt-5">
                    <ul class="d-flex py-4 border-top border-bottom text-center px-3">
                        <c:forEach var="service" items="${requestScope.listService}">
                            <li class="me-5">
                                <a href="ProfileServlet?Service=${service}"
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
                                    <div class="col-md-3 h-100">
                                        <div class="account-img position-relative">
                                            <% if(cuss.getImagePath() == null) { %>
                                            <img src="https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="" id="boxImage" class="img-fluid rounded-circle">
                                            <% } else { %>
                                            <img src="${IConstant.PATH_USER}/<%=cuss.getImagePath()%>" alt="" id="boxImage" class="rounded-circle">
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
                                                <h3 class="fw-medium" hidden>Address</h3>
                                                <div class="input-group">
                                                    <input type="text" hidden name="address" value="<%=cuss.getAddress()%>" class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="Address">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3>Email</h3>
                                                <div class="input-group mb-3 rounded-xl">
                                                    <span class="input-group-text p-4" id="basic-addon1">
                                                        <i class="fa-regular fa-envelope fs-3"></i>
                                                    </span>
                                                    <input type="text" name="email"
                                                           readonly
                                                           value="<%=cuss.getEmail()%>" 
                                                           class="form-control px-4 py-3 fs-3" 
                                                           placeholder="Username" aria-label="Email" aria-describedby="basic-addon1">
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
                                                <button type="submit" class="btn btn-main text-white fs-4 fw-bold bg-success">Update Information</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>                  
                        </form>

                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="rounded-lg p-5 bg-white col-md-9">
                                <h4 class="mt-5 fs-3">THÔNG TIN NHẬN HÀNG: </h4>
                                <div class="row gy-5">
                                    <div class="col-12">
                                        <c:forEach var="add" items="${requestScope.address}"> 
                                            <div class="d-flex align-items-center mb-5 border-bottom">
                                                <p class="me-auto"> ${add.city}, ${add.district}, ${add.ward}, ${add.detail}<p/>
                                                <a href="deleteAddress?id=${add.id}" class="btn btn-danger ms-auto">delete</a>
                                            </div>
                                        </c:forEach>
                                        <a class="btn btn-primary" href="addAddress">Add new address</a>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                                <button type="submit" class="btn btn-primary py-2 text-white fs-4 fw-bold">Update Password</button>
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
        <script src="./js/app.js"></script>
        <script>
                                                       function inputImage(input) {
                                                           var filePath = input.value;
                                                           var fileName = filePath.split('\\').pop();
                                                           if (isValidImageFile(fileName)) {
                                                               var imagePreview = document.getElementById('boxImage');
                                                               imagePreview.src = "./images/User_img/" + fileName;
                                                           } else {
                                                               alert('file khong hop le')
                                                           }
                                                       }

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
                                                                   alert('not valid file');
                                                               }
                                                           } else {
                                                               imagePreview.src = "./images/Brand_img/" + file;
                                                           }
                                                       }
                                                       function isImageFile(file) {
                                                           var imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];

                                                           var fileName = file.name;
                                                           var lastDotIndex = fileName.lastIndexOf('.');

                                                           if (lastDotIndex !== -1) {
                                                               var fileExtension = fileName.substring(lastDotIndex + 1).toLowerCase();
                                                               return imageExtensions.includes(fileExtension);
                                                           }
                                                           return false;
                                                       }
        </script>
    </body>
</html>