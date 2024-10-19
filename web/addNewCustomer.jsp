<%-- 
    Document   : customerProfile
    Created on : 10-01-2024, 18:48:59
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>User Profile</title>
        <link rel="stylesheet" href="./css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
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
            .header-logo a {
                text-decoration: none;
            }
        </style>
    </head>

    <body style="margin: 0">
        <%@include file="../partials/header.jsp"%>
        <section>
            <form action="CustomerManager" method="post" enctype="multipart/form-data">
                <input type="hidden" name="Service" value="addCustomer">
                <div class="row h-100">
                    <div class="col-md-2 h-100 left-nav-admin p-0">
                        <!-- Sidebar navigation -->
                        <div class="p-5 pe-0">
                            <ul>
                                <li class="py-4 ps-3 mb-3">
                                    <a href="" class="fs-2 text-white d-flex align-items-center text-decoration-none">
                                        <i class='bx bxs-dashboard me-3'></i>
                                        <span>Dashboard</span>
                                    </a>
                                </li>
                                <li class="py-4 ps-3 mb-3">
                                    <a href="" class="fs-2 text-white text-decoration-none">
                                        <i class='bx bx-cart me-3'></i>
                                        <span>Order</span>
                                    </a>
                                </li>
                                <li class="py-4 ps-3 mb-3">
                                    <a href="" class="fs-2 text-white d-flex align-items-center text-decoration-none">
                                        <i class='bx bx-circle-three-quarter me-3'></i>
                                        <span>Statistic</span>
                                    </a>
                                </li>
                                <li class="py-4 ps-3 mb-3 ">
                                    <a href="" class="fs-2 text-white d-flex align-items-center text-decoration-none">
                                        <i class='bx bxs-data me-3'></i>
                                        <span>Products</span>
                                    </a>
                                </li>
                                <li class="py-4 ps-3 mb-3">
                                    <a href="" class="fs-2 text-white d-flex align-items-center text-decoration-none">
                                        <i class='bx bx-line-chart me-3'></i>
                                        <span>Stock</span>
                                    </a>
                                </li>
                                <li class="py-4 ps-3 mb-3">
                                    <a href="" class="fs-2 text-white d-flex align-items-center text-decoration-none">
                                        <i class='bx bx-purchase-tag-alt me-3'></i>
                                        <span>Offer</span>
                                    </a>
                                </li>
                                <li class="py-4 ps-3 mb-3 active">
                                    <a href="#" class="fs-3 text-white text-decoration-none">
                                        <i class="bx bx-cart me-3"></i>
                                        <span>User Manager</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>


                    <div style="padding: 0" class="col-md-10 h-100 p-3 mx-auto">
                        <div class="main-body">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="card">
                                        <div class="card-body" style="height: auto; padding: 50px 0px;">
                                            <div class="d-flex flex-column align-items-center text-center">
                                                <div>
                                                    <img style="width: 150px; border-radius: 100px" id="imagePreview"
                                                         src="https://cdn-icons-png.flaticon.com/512/149/149071.png"class="img-fluid" id="boxImage">
                                                        <input style="margin-left: 50px;margin-top: 10px" name="customer_img" type="file"
                                                               class="form-control-file" id="exampleFormControlFile1" onchange="previewImage(this)"
                                                               required>
                                                    <c:if test="${not empty imageError}">
                                                        <div class="text-danger">${imageError}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="display: flex; justify-content: center">
                                            <a href="CustomerManager?Service=listAllCustomer">
                                                <button type="button" class="btn btn-primary"><i class="bi bi-arrow-return-left"> </i>Back</button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-8">
                                    <div class="card">
                                        <div class="card-body" style="height: auto;">
                                            <div style="font-size: x-large" class="row g-3 needs-validation">
                                                <div class="col-md-4">
                                                    <label for="validationCustomUsername" class="form-label">Username</label>
                                                    <div class="input-group has-validation">
                                                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                                                        <input style="height: auto" type="text" class="form-control" name="name" id="validationCustomUsername"
                                                               aria-describedby="inputGroupPrepend" required>
                                                        <div class="invalid-feedback">
                                                            Name cannot be blank
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="validationCustom03" class="form-label">Email</label>
                                                    <input type="email" class="form-control" name="email" id="validationCustom03" required>
                                                    <div class="invalid-feedback">
                                                        You must enter email before submitting.
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="validationCustom04" class="form-label">Address</label>
                                                    <input style="height: auto" type="text" class="form-control"name="address" id="validationCustom04" required>
                                                    <div class="invalid-feedback">
                                                        You must enter address before submitting.
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <label for="validationCustom05" class="form-label">Phone</label>
                                                    <input style="height: auto" type="text" class="form-control" name="phone" id="validationCustom05" required>
                                                    <div class="invalid-feedback">
                                                        You must enter phone number before submitting.
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
                                                        <label class="form-check-label" for="invalidCheck">
                                                            Agree to terms and conditions
                                                        </label>
                                                        <div class="invalid-feedback">
                                                            You must agree before submitting.
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <input class="btn btn-primary" type="submit" name="submit" value="Add New">                                                
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
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </section>
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (() => {
                'use strict';
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                const forms = document.querySelectorAll('.needs-validation');

                // Loop over them and prevent submission
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }

                        form.classList.add('was-validated');
                    }, false);
                });
            })();
            
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
            
            
        </script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
        <%@include file="../partials/footer.jsp" %>
    </body>
</html>
