<%-- 
    Document   : cart
    Created on : 29 thg 9, 2024, 02:33:26
    Author     : Lenovo
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" 
           prefix="fn" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="constant.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My cart</title>
        <link rel="stylesheet" href="css/homestyle.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <style>
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
        <a href="cart"><img src="images/cart.png" alt="Cart"></a> 
    </c:if>
</div>
        </div>
    </header>
        <section class="h-100 h-custom" style="background-color: #d2c9ff;">
            <div class="mt-5">
                <a href="myOrder" class="btn px-4 py-2 rounded text-white bg-info">My Order</a>
                 <a href="myOrder" class="btn px-4 py-2 rounded text-warning bg-success">My Cart</a>
            </div>
            <div class="container py-5 h-100">
                <form action="cartComplete" method="post" class="mt-4">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-12">
                                        <div class="p-5">
                                            <div class="d-flex justify-content-between align-items-center mb-5">
                                                <h1 class="fw-bold mb-0">Shopping Cart</h1>
                                                <p style="color: red">${messErr}</p>
                                                <p style="color: green">${messSuss}</p>
                                                <p style="color: blue">${mess}</p>
                                                <h6 class="mb-0 text-muted">${sessionScope.numberOrder} items</h6>
                                            </div>
                                            <hr class="my-4">
                                            <c:set var="total" value="0"/>
                                            <c:forEach var="entry" items="${sessionScope}">
                                                <c:choose>
                                                    <c:when test="${fn:startsWith(entry.key, 'cart-')}">
                                                        <c:set var="product" value="${entry.value}" />
                                                        <c:set var="total" value="${total+(product.price * product.quantity)}"/>
                                                        <div class="row mb-4 d-flex justify-content-between align-items-center">
                                                            <div class="col-md-1 col-lg-1 col-xl-1">
                                                                <input type="checkbox" name="selectedProducts" value="${product.id}" />
                                                            </div>
                                                            <div class="col-md-1 col-lg-1 col-xl-1">
                                                                <img
                                                                    src="${product.link_picture}"
                                                                    class="img-fluid rounded-3" alt="Cotton T-shirt">
                                                            </div>
                                                            <div class="col-md-3 col-lg-3 col-xl-3">
                                                                <h6 class="text-muted">${product.category}</h6>
                                                                <h6 class="mb-0">${product.name}</h6>
                                                                <p class="small mb-0">
                                                                    ${product.color}  
                                                                    <c:if test="${product.category.equals('shoes')}">
                                                                        | ${product.size}
                                                                    </c:if>
                                                                </p>
                                                            </div>
                                                            <div class="col-md-3 col-lg-3 col-xl-3 d-flex">
                                                                    <button type="button" class="btn btn-link px-2">
                                                                        <a href="cart?Service=changeQuantity&pid=${product.id}&action=minus">
                                                                            <i class="fas fa-minus"></i>
                                                                        </a>
                                                                    </button>
                                                                    <input id="form1" min="0" name="quantity" value="${product.quantity}" type="number"
                                                                           class="form-control form-control-sm" readonly />
                                                                    <button type="button" class="btn btn-link px-2">
                                                                        <a href="cart?Service=changeQuantity&pid=${product.id}&action=add">
                                                                            <i class="fas fa-plus"></i>
                                                                        </a>
                                                                    </button>
                                                            </div>
                                                            <c:set var="totalPrice" value="${product.price * product.quantity}" />
                                                            <div class="col-md-2 col-lg-2 col-xl-2 offset-lg-1">
                                                                <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="2" minFractionDigits="2" />$
                                                            </div>
                                                            <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                                                                   <a href="cart?Service=removeOrder&pid=${product.id}&action=minus">
                                                                        <i class="fas fa-times"></i>
                                                                    </a>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>  

                                            <div class="pt-5">
                                                <h6 class="mb-0"><a href="homepage" class="text-body"><i
                                                            class="fas fa-long-arrow-alt-left me-2"></i>Back to shop</a></h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="card bg-primary text-white rounded-3">
                                            <c:if test="${sessionScope.current_user != null}">
                                                <c:set var="user" value="${sessionScope.current_user}"/>
                                                <div class="card-body">
                                                    <hr class="my-4">
                                                    <div class="d-flex justify-content-between">
                                                        <p class="mb-2">Subtotal</p>
                                                       <p class="mb-2"><fmt:formatNumber value="${total}" type="number" maxFractionDigits="2" minFractionDigits="2" />$</p>
                                                    </div>

                                                    <!--                                                <div class="d-flex justify-content-between">
                                                                                                        <p class="mb-2">Shipping</p>
                                                                                                        <p class="mb-2">$20.00</p>
                                                                                                    </div>-->


                                                    <button  type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-info btn-block btn-lg">
                                                        <div class="d-flex justify-content-between">
                                                            <span>Checkout <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
                                                        </div>
                                                    </button>
                                                </div>
                                            </c:if>
                                            <c:if test="${sessionScope.current_user == null}">

                                                <div >
                                                    <img style="width: 100%; height: 100%" src="https://anywhere365.io/hs-fs/hubfs/website-header-image-7-1.png?width=1715&name=website-header-image-7-1.png" alt="alt"/>
                                                </div>
                                                <div class="d-flex justify-content-between bg-dark p-3">
                                                    <p class="mb-2">Subtotal</p>
                                                    <p class="mb-2"><fmt:formatNumber value="${total}" type="number" maxFractionDigits="2" minFractionDigits="2" />$</p>
                                                </div>
                                                <a href="login" type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-info btn-block btn-lg">
                                                    Login to buy now
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
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
                                            <script>
                                                const avatarElement = document.querySelector('.avatar');
if (avatarElement) {
    avatarElement.addEventListener('mouseover', function () {
        document.querySelector('.dropdown-content').style.display = 'block';
    });
}
            document.querySelector('.dropdown-content').addEventListener('mouseleave', function () {
                document.querySelector('.dropdown-content').style.display = 'none';
            });
                                            </script>
    </body>
</html>
