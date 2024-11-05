<%-- 
    Document   : customerProfile
    Created on : 10-01-2024, 18:48:59
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>User Profile</title>
        <link rel="stylesheet" href="./css/style.css" />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
            integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
          <link rel="stylesheet" href="css/homestyle.css"/>
        <style>
            a {
                text-decoration: none;
            }
            body {
                background: #f7f7ff;
                margin-top: 20px;
            }
            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 0 solid transparent;
                border-radius: 0.25rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 6px 0 rgb(218 218 253 / 65%),
                    0 2px 6px 0 rgb(206 206 238 / 54%);
                height: 500px;
            }
            .me-2 {
                margin-right: 0.5rem !important;
            }
            .form-control{
                font-size: 15px;
                height: 3.0rem;
            }
            .card-body{
                margin-right: 30px;
            }
        </style>
    </head>
    <header class="header collapsed" >
        <div class="left-section">
            <a class="text-decoration-none" href="homepage"><img src="images/logo.png" alt="Shop Logo" class="w-auto" style="margin-left: 50px;"></a>
            <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
            <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
        </div>
        <div class="right-section">
            <div class="icons">
                <a href="ProfileServlet?current_user=${sessionScope.current_user}"><img class="w-auto" src="images/profile.png" alt="Account"></a>
            </div>
       </div>
    </header>
    <body style="margin: 0">
        <section>
           
            <div class="row h-100">
                <c:set var="cus" value="${requestScope.data}"/>
                 <div class="col-md-2 left-nav-admin p-0"  style="background-color: #ff6600; height: 100vh;">
                <div class="p-5 pe-0">
                        <ul>
                            <li class="py-4 ps-3 mb-3">
                                <a href="" class="fs-2 text-white d-flex align-items-center">
                                    <i class="bx bxs-dashboard me-3"></i>
                                    <span>Dashboard</span>
                                </a>
                            </li>
                            <li class="py-4 ps-3 mb-3">
                                <a href="orderManagerServlet" class="fs-2 text-white">
                                    <i class="bx bx-cart me-3"></i>
                                    <span>Order</span>
                                </a>
                            </li>
                            <li class="py-4 ps-3 mb-3">
                                <a href="productlist" class="fs-2 text-white d-flex align-items-center">
                                    <i class="bx bxs-data me-3"></i>
                                    <span>Products</span>
                                </a>
                            </li>
                            <li class="py-4 ps-3 mb-3 active">
                                <a href="CustomerManager" class="fs-3 text-white text-decoration-none">
                                    <i class="bx bx-cart me-3"></i>
                                    <span>User Manager</span>
                                </a>
                            </li>
                        </ul>
                    </div>
            </div>
                <div style="padding: 0" class="col-md-10 h-100 p-3 mx-auto">
                    <div class="main-body">
                        <form action="CustomerManager" method="post" class="needs-validation" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body me-0" style="height: auto; padding: 50px">
                                            <div class="d-flex flex-column align-items-center text-center">
                                                <div>
                                                    <img style="width: 150px; height: 150px; border-radius: 100px" id="imagePreview"
                                                         src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="img-fluid" id="boxImage">
                                                    <input style="margin-top: 10px" name="customer_img" type="file"
                                                          class="form-control" id="exampleFormControlFile1" onchange="previewImage(this)"
                                                           required>
                                                    <c:if test="${not empty imageError}">
                                                        <div class="text-danger">${imageError}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="display: flex; justify-content: center; margin: 10px 0;">
                                            <a href="CustomerManager?Service=listAllCustomer">
                                                <button type="button" class="btn btn-primary px-5 py-2 fs-3 border-0" style="background-color: #ff6600;"><i class="bi bi-arrow-return-left"> </i>Back</button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="card">
                                        <div class="card-body" style="height: auto;">
                                            <input type="hidden" name="Service" value="updateCustomer">
                                            <input type="hidden" name="id" value="${cus.id}">
                                            <div class="row mb-5 align-items-center">
                                                <div class="col-sm-3">
                                                    <h4 class="mb-0">Full Name</h4>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="text"
                                                           class="form-control h-auto"
                                                           value="${cus.name}"
                                                           name="name" required>
                                                    <div class="invalid-feedback">
                                                        Name cannot be blank
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-5 align-items-center">
                                                <div class="col-sm-3">
                                                    <h4 class="mb-0">Gender</h4>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="radio"
                                                           value="1"
                                                           name="gender" ${cus.gender==1?"checked":""}>Male
                                                    <input type="radio"
                                                           value="0"
                                                           ${cus.gender==0?"checked":""}
                                                           name="gender">Female
                                                </div>
                                            </div>
                                            <div class="row mb-5 align-items-center">
                                                <div class="col-sm-3">
                                                    <h4 class="mb-0">Email</h4>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="email"
                                                           class="form-control h-auto"
                                                           value="${cus.email}"
                                                           name="email" required>
                                                    <div class="invalid-feedback">
                                                        You must enter email before submitting.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-5 align-items-center">
                                                <div class="col-sm-3">
                                                    <h4 class="mb-0">Address</h4>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="text"
                                                           class="form-control h-auto" 
                                                           value="${cus.address}"
                                                           name="address" required>
                                                    <div class="invalid-feedback">
                                                        You must enter address before submitting.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-5 align-items-center">
                                                <div class="col-sm-3">
                                                    <h4 class="mb-0">Phone</h4>
                                                </div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="text"
                                                           class="form-control h-auto"
                                                           value="${cus.phone}"
                                                           name="phone" required>
                                                    <div class="invalid-feedback">
                                                        You must enter phone number before submitting.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-3"></div>
                                                <div class="col-sm-9 text-secondary">
                                                    <input type="submit"
                                                           class="btn btn-success px-4 fs-3 py-2 px-5"
                                                           value="Save Changes" name="submit">
                                                    <input type="reset"
                                                           class="btn btn-primary fs-3 py-2 px-5"
                                                           value="Reset">
                                                </div>
                                            </div>
                                            <c:if test="${not empty errorMessage}">
                                                <p class="text-center text-danger">${errorMessage}</p>
                                            </c:if>
                                            <c:if test="${not empty msg}">
                                                <p class="text-center text-success">${msg}</p>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>                 
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                               function previewImage(input) {
                                                                   var imagePreview = document.getElementById('imagePreview');
                                                                   var file = input.files[0];
                                                                   if (file) {
                                                                       var reader = new FileReader();
                                                                       reader.onload = function (e) {
                                                                           imagePreview.src = e.target.result;
                                                                       };
                                                                       reader.readAsDataURL(file);
                                                                   } else {
                                                                       imagePreview.src = "./images/User_img/" + file;
                                                                   }
                                                               }
                                                               const fileInput = document.querySelector('input[type="file"]');
                                                               // Fetch default image and create a File object
                                                               const defaultImagePath = 'images/User_img/${cus.getImagePath()}'; // Replace with your default image path
                                                               fetch(defaultImagePath)
                                                                       .then(response => response.blob())
                                                                       .then(blob => {
                                                                           const myFile = new File([blob], '${cus.getImagePath()}', {type: 'image/png'});
                                                                           // Now let's create a DataTransfer to set the initial FileList
                                                                           const dataTransfer = new DataTransfer();
                                                                           dataTransfer.items.add(myFile);
                                                                           fileInput.files = dataTransfer.files;
                                                                           const imagePreview = document.getElementById('imagePreview');
                                                                           imagePreview.src = URL.createObjectURL(myFile);
                                                                       })
                                                                       .catch(error => console.error('Error loading default image:', error));
        </script>
    </body>
</html>
