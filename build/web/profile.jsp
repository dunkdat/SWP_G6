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
        <title>profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <%
                User cuss = null;
                if(session.getAttribute("currentUser") != null) {
                    cuss = (User)session.getAttribute("currentUser");
                }
    %>
    <body>
        <section>
            <div class="w-60 m-auto">
                <h1 class="my-4">Account</h1>
                <div class="mt-5">
                    <ul class="d-flex py-4 border-top border-bottom text-center px-3">
                        <c:forEach var="service" items="${requestScope.listService}">
                            <li class="me-5">
                                <a href="profile?Service=${service}"
                                   <c:if test="${service==requestScope.current}">
                                       style="text-decoration: underline;
                                       text-decoration-color: var(--pink-color);
                                       "
                                   </c:if>
                                   <c:if test="${service!=requestScope.current}">
                                       style="text-decoration: none;"
                                   </c:if>
                                   class="fs-3 text-dark ">${service}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="">
                    <!--mess of action-->
                    <c:if test="${isSuccess!=null}">
                        <div class="fs-4 alert ${isSuccess==true?"alert-success":"alert-danger"}" role="alert">
                            ${mess}
                        </div>
                    </c:if>
                    <!--form if is account info-->
                    <c:if test="${requestScope.current.equals('Account info')}">
                        <form action="ProfileServlet" method="POST" enctype="multipart/form-data">
                            <input name="Service" value="updateInfo" hidden>
                            <div class="h-100vh mt-5">
                                <h1 class="fw-bold">Account infomation</h1>
                                <div class="row py-5">
                                    <div class="col-md-3 h-100">
                                        <div class="account-img position-relative">
                                            <%if(cuss.getImagePath() == null) {%>
                                            <img src="https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="" id="boxImage">
                                            <%} else {%>
                                            <img src="${IConstant.PATH_USER}/<%=cuss.getImagePath()%>" alt="" id="boxImage">
                                            <%}%>
                                            <div class="change-userImg ">
                                                <i class='bx bx-image-add fs-3'></i>
                                                <span>Change image</span>
                                            </div>
                                            <input type="file" 
                                                   onchange="previewImage(this)"
                                                   accept="image/gif, image/jpeg, image/png, image/jpg"
                                                   class="input-userImg"
                                                   name="accountImage"
                                                   >
                                            <input value="<%=cuss.getImagePath()%>" name="beforeImage" type="hidden"/>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="user-info">
                                            <div class="mt-5">
                                                <h3 class="fw-medium">Name</h3>
                                                <div class="input-group flex-nowrap">
                                                    <input type="text" name="name"
                                                           value="<%=cuss.getName()%>" 
                                                           class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="Name">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3 class="fw-medium">Address</h3>
                                                <div class="input-group flex-nowrap">
                                                    <input type="text" name="address"
                                                           value="<%=cuss.getAddress()%>" 
                                                           class="form-control px-4 py-3 fs-3 rounded-xl" 
                                                           placeholder="Address">
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
                                                <div class="input-group mb-3 rounded-xl">
                                                    <span class="input-group-text p-4" id="basic-addon1">
                                                        <i class="fa-solid fa-phone fs-3"></i>
                                                    </span>
                                                    <input type="text" name="phone"
                                                           value="<%=cuss.getPhone()%>"  class="form-control px-4 py-3 fs-3" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
                                                </div>
                                                <div class="mt-5">
                                                    <h3>Gender</h3>
                                                    <div class="input-group mb-3 rounded-xl">
                                                        <span class="input-group-text p-4" id="basic-addon1">
                                                            Male
                                                        </span>
                                                        <input type="radio" name="gender" value="1" 
                                                               <%= (cuss.getGender() == 1) ? "checked" : "" %> >
                                                        <span class="input-group-text p-4" id="basic-addon1">
                                                            Female
                                                        </span>
                                                        <input type="radio" name="gender" value="0" 
                                                               <%= (cuss.getGender() == 0) ? "checked" : "" %> >
                                                    </div>
                                                </div>


                                            </div>
                                            <div class="mt-5">
                                                <button type="submit" class="border-0 px-5 py-4 fs-4 bg-dark text-white rounded-xl fw-bold">Update infomation</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </form>
                    </c:if>
                    <!--form if is Changepassword-->
                    <c:if test="${requestScope.current.equals('Change password')}">
                        <div class="h-100vh mt-5">
                            <h1 class="fw-bold">Update your password</h1>
                            <div class="row py-5">
                                <div class="col-md-12">

                                    <form action="ProfileServlet" method="post">
                                        <input name="Service" value="updatePassword" hidden />
                                        <div class="change-password">
                                            <div class="mt-5">
                                                <h3 class="fw-medium">Current password</h3>
                                                <div class="input-group flex-nowrap">
                                                    <input type="password" name="currentPassword"
                                                           class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="password">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3 class="fw-medium">New password</h3>
                                                <div class="input-group flex-nowrap">
                                                    <input type="password" name="newPassword"
                                                           class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="password">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <h3 class="fw-medium">Confirm password</h3>
                                                <div class="input-group flex-nowrap">
                                                    <input type="password" name="confirmPassword"
                                                           class="form-control px-4 py-3 fs-3 rounded-xl" placeholder="password">
                                                </div>
                                            </div>
                                            <div class="mt-5">
                                                <button type="submit" class="border-0 px-5 py-4 fs-4 bg-dark text-white rounded-xl fw-bold">Update password</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>
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
