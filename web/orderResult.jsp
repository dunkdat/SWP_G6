<%-- 
    Document   : orderResult
    Created on : 8 Mar, 2024, 12:11:10 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
     <link rel="stylesheet" href="css/homestyle.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<style>
    body {
        background-color: #fff;
    }

    .icon-main {
        width: 15%;
        height: 15%;
    }
</style>

<body>
     <header class="header collapsed">
            <div class="left-section">
                <a href="homepage"><img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px;"></a>
                <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
                <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
            </div>
            <div class="right-section">
                
            </div>
        </header>
    <section class="mt-5">
        <div class="text-center">
            <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:150:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Review-empty.png" alt="" class="icon-main">
        </div>
        <c:if test="${transResult}">
            <div class="text-center mt-5">
                <h3 class="fw-bold">Bạn đã giao dịch thành công! 
                    <i class='bx bxs-badge-check text-success' ></i>
                </h3>
                <div class="d-flex align-items-center justify-content-center mt-3">
                    <p class="mb-0 fs-4">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p><strong
                        class="text-danger fs-2">0383459560</strong>
                </div>
            </div>
        </c:if>
        <c:if test="${transResult==false}">
            <div class="text-center mt-5">
                <h3 class="fw-bold">Đơn hàng giao dịch thất bại!</h3>
                <div class="d-flex align-items-center justify-content-center mt-3">
                    <p class="mb-0 fs-4">Cảm ơn quý khách đã dùng dịch vụ của chúng tôi.
                        Liên hệ tổng đài để được tư vấn:
                    </p><strong
                        class="text-danger fs-2">0383459560</strong>
                </div>
            </div>
        </c:if>

        <c:if test="${transResult==null}">
            <div class="text-center mt-5">
                <h3 class="fw-bold">Chúng tôi đã tiếp nhận đơn hàng, xin chờ quá trình xử lý!</h3>
                <div class="d-flex align-items-center justify-content-center mt-3">
                    <p class="mb-0 fs-4">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p><strong
                        class="text-danger fs-2">0383459567</strong>
                </div>
            </div>
            <section>
            </c:if>
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
            <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</body>
</html>
