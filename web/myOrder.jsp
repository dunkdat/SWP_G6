<%-- 
    Document   : myOrder
    Created on : 1 thg 10, 2024, 11:28:33
    Author     : Lenovo
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="constant.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My order</title>
        <link rel="stylesheet" href="css/homestyle.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
                    <a href="ProfileServlet">
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

                            <a href="ProfileServlet">
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
                 <a href="cart" class="btn px-4 py-2 rounded text-warning bg-success">My Cart</a>
            </div>
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12">
                        <div class="card card-registration card-registration-2" style="border-radius: 15px;">
                            <div class="card-body p-0">
                                <div class="row g-0">
                                    <div class="col-lg-12">
                                        <div class="p-5">
                                            <div class="d-flex justify-content-between align-items-center mb-5">
                                                <h1 class="fw-bold mb-0">My Order</h1>
                                                <p style="color: red">${messErr}</p>
                                                <p style="color: green">${messSuss}</p>
                                                <p style="color: blue">${mess}</p>
                                            </div>
                                            <hr class="my-4">
                                            <c:forEach var="order" items="${orders}">
                                                <c:set var="sub" value="0" />
                                                <h3 class="my-3" style="width: 100%; height: 3px; background-color: red;"></h3>
                                                <p class="fs-5 text-info"> ${order.getCreateAt()}</p>
                                                <c:forEach var="orderItem" items="${order.getOrders()}">
                                                      <c:set var="itemPro" value="${orderItem.getProducts()}"/>

                                                    <div class="row mb-4 d-flex justify-content-between align-items-center">
                                                            <div class="col-md-2 col-lg-2 col-xl-2">
                                                                <img
                                                                    src="${itemPro.link_picture}"
                                                                    class="img-fluid rounded-3" alt="Cotton T-shirt">
                                                            </div>
                                                            <div class="col-md-3 col-lg-3 col-xl-3">
                                                                <h6 class="text-muted">${itemPro.category}</h6>
                                                                <h6 class="mb-0">${itemPro.name}</h6>
                                                                <p class="small mb-0">
                                                                    ${itemPro.color}  
                                                                    <c:if test="${itemPro.category.equals('shoes')}">
                                                                        | ${itemPro.size}
                                                                    </c:if>
                                                                </p>
                                                            </div>
                                                            <div class="col-md-3 col-lg-3 col-xl-3 d-flex">
                                                                    <input id="form1" min="0" name="quantity" value="${orderItem.quantity}" type="number"
                                                                           class="form-control form-control-sm" readonly />
                                                            </div>
                                                            <c:set var="totalPrice" value="${orderItem.price * orderItem.quantity}" />
                                                             <c:set var="sub" value="${sub + totalPrice}" />
                                                            <div class="col-md-2 col-lg-2 col-xl-2 offset-lg-1">
                                                                <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="2" minFractionDigits="2" />$
                                                            </div>
                                                        </div>
                                                </c:forEach>
                                                <div class="d-flex align-items-center justify-content-between">
                                                  <span class="text-end bg-warning px-3 py-2 rounded">
                                                      Status: ${order.status}
                                                  </span>
                                                 <span class="text-end bg-info text-white fw-bold p-3 rounded">
                                                     Total this order: <fmt:formatNumber value="${sub}" type="number" maxFractionDigits="2" minFractionDigits="2" />$
                                                 </span>
                                                </div>
                                            </c:forEach>  
                                            <div class="pt-5">
                                                <h6 class="mb-0"><a href="homepage" class="text-body"><i
                                                            class="fas fa-long-arrow-alt-left me-2"></i>Back to shop</a></h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
