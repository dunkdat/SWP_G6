<%-- 
    Document   : paymentInfo
    Created on : 28 Feb, 2024, 2:29:03 PM
    Author     : HP
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.*" %>
<%@page import="java.util.*" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" 
           prefix="fn" %> 
<%@page import="constant.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Payment info</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/homestyle.css"/>
        <link rel="stylesheet" href="./css/style_1.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <style>
            #cart-mess {
                position: fixed;
                top: 100px;
                right: 0;
                z-index: 10000;
            }

            .cart-mess {
                margin-top: 15px;
                min-width: 400px;
                padding: 15px 20px;
                border-radius: 10px;
                transition: all linear 0.3s;
            }

            .cart-mess.cart-mess_success {
                background-color: #03a935;
                color: #fff;
            }

            .cart-mess.cart-mess_error {
                background-color: #a90316;
                color: #fff;
            }

            .cart-mess.cart-mess_warning {
                background-color: #d2d0d0;
                color: #333;
            }
            @keyframes slideShow {
                from {
                    opacity: 0;
                    transform: translateX(100%);
                }

                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            @keyframes fadeOut {
                to {
                    opacity: 0;
                }
            }
            body {
                background-color: #f4f6f8;
            }

            .block-info {
                width: 800px;
                margin: 0 auto;
                /* background-color: antiquewhite; */
            }

            .block_header {
                border-bottom: 1px solid rgba(188, 186, 186, 0.433);

            }

            .block_current {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 20px;
                font-weight: 600;
            }

            .back_btn i {
                font-size: 25px;
                color: #323232;
                cursor: pointer;
                font-weight: 500;
            }

            .block-info .nav_item {
                color: #919eab;
                border-bottom: 3px solid #919eab;
            }

            .block-info .nav_item.choose_nav {
                color: red;
                border-bottom: 3px solid red;
            }

            .block-info .nav_item span {
                font-size: 20px;
                font-weight: 600;
            }

            .box-info_orders,
            .box-info_customer,
            .box-info_address,
            .box_info-price,
            .box_info-pay {
                background-color: #fff;
                height: fit-content;
            }

            .info-label {
                color: #9abfe1;
                font-size: 14px;
                color: #323232;
                margin-bottom: 0;
            }

            .box-info_customer input {
                font-size: 15px;
            }

            .customer_box-info {
                border-bottom: 1px solid rgba(125, 123, 123, 0.382);
            }

            .box-info_address select,
            .box-info_address input {
                border: 0;
                outline: none;
                width: 100%;
            }

            .apply_discount-btn {
                padding: 8px 16px;
                border: 0;
                color: #333;
                font-size: 12px;
                border-radius: 5px;
            }

            .box_pay-info img {
                width: 50px;
                height: 50px;
            }

            .more_pay-btn {
                font-size: 14px;
            }

            .modal {
                --bs-modal-width: 40%;
            }

            .pay_method-item {
                cursor: pointer;
            }

            .pay_method-item:hover {
                background-color: rgba(255, 187, 208, 0.462);
            }

            .pay_method-item .pay_method-img {
                width: fit-content;
                height: 60px;
            }

            .pay_method-item .pay_method-img img {
                width: 100%;
                height: 100%;
                object-fit: contain;
            }

            p {
                margin-bottom: 0;
            }

            body {
                position: relative;
            }

            .bottom-bar {
                position: fixed;
                bottom: 0;
                width: 53%;
                background-color: #ffff;
                border-radius: 8px;
                border: 1px solid rgba(158, 158, 158, 0.4);
                height: 120px;
                box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
                left: 50%;
                transform: translateX(-50%);
            }

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
                       <a href="cart"><img src="images/cart.png" style="width: auto;" alt="Cart"></a> 
                    </c:if>
                </div>
            </div>
        </header>
        <div class="block-info">
            <div class="">
                <div class="py-4 position-relative block_header">
                    <a href="cart" class="back_btn">
                        <i class='bx bx-left-arrow-alt'></i>
                    </a>
                    <h3 class="text-center mb-0 block_current">Thông tin</h3>
                </div>
                <div class="row">
                    <div class="col-12">
                        <a href="payment-info" class="d-block">
                            <div class="text-center nav_item choose_nav py-1 pointer">
                                <span>1. Thông tin</span>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="box-info_orders rounded-lg p-5 mt-3">
                    <div class="row gy-5">
                        <c:set var="total" value="0"/>
                        <c:forEach var="entry" items="${sessionScope}">
                            <c:choose>
                                <c:when test="${fn:startsWith(entry.key, 'cart-')}">
                                    <c:set var="product" value="${entry.value}" />

                                    <c:set var="isSelected" value="false"/>
                                    <c:forEach var="selectedId" items="${sessionScope.listBuy}">
                                        <c:if test="${selectedId == product.id}">
                                            <c:set var="isSelected" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${isSelected}">

                                        <c:set var="total" value="${total+(product.price * product.quantity)}"/>
                                        <div class="col-12 box-pay_item">
                                            <div class="row order-item border-top">
                                                <div class="col-2">
                                                    <a href="" class="d-block h-100">
                                                        <img src="${product.link_picture}"
                                                             alt="" class="rounded-lg object-fit-cover">
                                                    </a>
                                                </div>
                                                <div class="col-10 d-flex flex-fill flex-column justify-content-between ">
                                                    <div class="h-50 d-flex align-items-center justify-content-between flex-fill">
                                                        <div class="">
                                                            <h3 class="fw-bold">${product.name}</h3>
                                                            <div class="d-flex align-items-center position-relative hover-change">
                                                                <div class="">
                                                                    <i class="fa-solid fa-fill-drip me-3"></i>
                                                                    <span class="text-black">${product.name}</span>
                                                                </div>
                                                                <div class="border-line border-l mx-3">${product.category}</div>
                                                                <div class="">
                                                                    <i class='bx bxs-memory-card'></i>
                                                                    <span class="text-black">${product.color}
                                                                        <c:if test="${product.category.equals('shoes')}">
                                                                            | ${product.size}
                                                                        </c:if>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <c:set var="total" value="${total}"/>

                                                        <div class="">
                                                            <span class="fs-4">
                                                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="2" minFractionDigits="2" />$
                                                            </span>
                                                        </div>
                                                        <div class="d-flex align-items-center">
                                                            <div class="fs-3">
                                                                <p class="text-black mb-0">Số lượng: <span class="text-danger">${product.quantity}</span></p>
                                                            </div>
                                                        </div>
                                                        <div class="fs-4">
                                                            <fmt:formatNumber value="${product.price * product.quantity}" type="number" maxFractionDigits="2" minFractionDigits="2" />$
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:when>
                            </c:choose>
                        </c:forEach>   
                    </div>
                    <p href="" id="view-more" class="w-25 mx-auto fs-4 d-block text-black" style="cursor: pointer;">
                        <span>và 1 sản phẩm khác</span>
                        <i class='bx bx-arrow-to-bottom'></i>
                    </p>
                </div>
                <c:if test="${sessionScope.current_user != null}">
                    <c:set var="cus" value="${sessionScope.current_user}"/>
                    <h4 class="my-5 fs-3">THÔNG TIN KHÁCH HÀNG</h4>
                    <div class="box-info_customer rounded-lg p-5">
                        <div class="row gy-3">
                            <div class="col-6">
                                <div class="customer_box-info">
                                    <p class="info-label">Họ Và Tên</p>
                                    <input type="text" 
                                           id="recive-name"
                                           class="border-0" value="${cus.name}">
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="customer_box-info">
                                    <p class="info-label">Số điện thoại</p>
                                    <input type="text" 
                                           id="recive-phone"
                                           class="border-0" value="${cus.phone}">
                                </div>
                            </div>

                        </div>
                    </div>
                </c:if>
                <h4 class="mt-5 fs-3">THÔNG TIN NHẬN HÀNG: </h4>
                <div class="rounded-lg p-5 bg-white">
                    <div class="row gy-5">
                        <div class="col-12">
                            <c:forEach var="add" items="${requestScope.address}"> 
                                <div class="d-flex align-items-center mb-5 border-bottom">
                                    <input type="radio" checked name="address" value="${add.city}, ${add.district}, ${add.ward}, ${add.detail}"/>
                                    <p> ${add.city}, ${add.district}, ${add.ward}, ${add.detail}</p>
                                </div>
                            </c:forEach>
                            <a class="btn btn-primary" href="addAddress">Add new address</a>
                        </div>
                    </div>
                </div>

                <div class="bg-white p-3 mt-5 rounded" >
                    <input name="payment_type" type="radio" checked style="color: green;"/> <span>Thanh toan khi nhan hang</span>
                </div>
                <div data-mdb-input-init class="form-outline form-white mb-4 p-3 mt-5 rounded">
                    <label class="form-label my-5 fs-3" for="typeText">Shippment</label>
                    <select name="shipment"  style="width: 100%; height: 30px; border: none">
                        <c:forEach var="ship" items="${shipments}">
                            <option value="${ship.id}">${ship.name} - ${ship.type} - ${ship.price}$</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="bottom-bar p-4">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <h3 class="fw-bold">Tổng tiền tạm tính:</h3>
                <span class="text-danger fw-bold fs-4 totalCost"><fmt:formatNumber value="${total}" type="number" maxFractionDigits="2" minFractionDigits="2" />$</span>
            </div>
            <button id="pay_btn" class="text-white bg-danger w-100 border-0 py-3 px-2 fs-4 rounded-sm">Thanh toán</button>
        </div>
        <div id="cart-mess">

        </div>
            
        <%--<%@include file="./cardMess.jsp"%>--%> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
        referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
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
            $('#paymentModal').on('show.bs.modal', function (event) {
                document.body.style.height = '100vh'
                $('body').addClass('hiddenPadding');
            });
            $('#paymentModal').on('hide.bs.modal', function (event) {
                // Hủy style height khi modal bị đóng
                document.body.style.height = '';
                $('body').removeClass('hiddenPadding');
            });

            const boxPayItem = document.querySelectorAll(".box-pay_item");
            const viewMoreBtn = document.getElementById("view-more");
            window.onload = () => {
                if (boxPayItem.length > 1) {
                    for (var i = 0; i < boxPayItem.length; i++) {
                        if (i > 0) {
                            boxPayItem[i].classList.add('d-none');
                        }
                    }
                    viewMoreBtn.getElementsByTagName("span")[0].innerText = "Xem thêm " + (boxPayItem.length - 1) + " sản phẩm";
                } else {
                    viewMoreBtn.classList.add('d-none');
                }
            }
            viewMoreBtn.addEventListener('click', () => {
                for (var i = 0; i < boxPayItem.length; i++) {
                    if (i > 0) {
                        boxPayItem[i].classList.replace('d-none', 'd-block');
                    }
                }
                viewMoreBtn.classList.add('d-none');
            });



            let messName = "Vui lòng kiểm tra lại tên người nhận";
            let messPhone = "Vui lòng kiểm tra lại số điện thoại người nhận";
            $(document).ready(function () {
        // Initial calculation when the page loads
        updateTotal();

        // Event listener for shipment dropdown changes
        $('select[name="shipment"]').on('change', function () {
            updateTotal();
        });

        function updateTotal() {
            // Get the base total amount from the JSP page
            let total = parseFloat('${total}');
            
            // Get the selected shipment price
            let shipmentCost = parseFloat($('select[name="shipment"] option:selected').text().split('-').pop().replace('$', '').trim());

            // Calculate the total cost including shipment
            let totalCost = total + shipmentCost;

            // Update the total displayed to the user
            $('.totalCost').text(totalCost.toFixed(2) + '$');
        }
            $('#pay_btn').click(() => {
    const checkEmpty = (value, errorMessage) => {
        if (value === '') {
            showMess({
                type: "warning",
                title: errorMessage,
                duration: 3000
            });
            return true;
        }
        return false;
    };

    const validateField = (value, validator, errorMessage) => {
        if (!checkEmpty(value, errorMessage)) {
            if (!validator(value)) {
                showMess({
                    type: "warning",
                    title: errorMessage,
                    duration: 3000
                });
                return false;
            }
        }
        return true;
    };

    let name = $('#recive-name').val();
    let phone = $('#recive-phone').val();

    if (!validateField(name, isValidName, messName)) return;
    if (!validateField(phone, isValidPhoneNumber, messPhone)) return;

    if (document.querySelector('input[name="address"]') == null) {
        window.location.href = 'addAddress'; // Redirect to add address if no address is selected
        return;
    }

    let address = document.querySelector('input[name="address"]:checked').value;
    let shipment = parseFloat($('select[name="shipment"]').val()); // Get shipment cost as float

    // Calculate total cost including shipment
    let totalCost = parseFloat('${total}') + shipment;

    // Display the updated total cost to the user
    $('.totalCost').text(totalCost.toFixed(2) + '$');

    const formData = {
        Service: "payment",
        reciveName: name,
        recivePhone: phone,
        address: address,
        shipment: shipment
    };

    // Proceed with sending the payment data
    $.post('cart', formData, (response) => {
        console.log(response);
        window.location = "cart?mess=order success";
    }).fail((jqXHR, textStatus, errorThrown) => {
        // Handle errors if any
        console.error("Error: " + textStatus, errorThrown);
    });
});
});



            $('#recive-name').on('blur', function () {
                let name = $(this).val();
                if (!isValidName(name)) {
                    showMess({
                        type: "warning",
                        title: messName,
                        duration: 3000
                    });
                }
            });

            $('#recive-phone').on('blur', function () {
                let phone = $(this).val();
                if (!isValidPhoneNumber(phone)) {
                    showMess({
                        type: "warning",
                        title: messPhone,
                        duration: 3000
                    });
                }
            });


            function isValidName(name) {
                if (name.trim() === "") {
                    return false;
                }
                var regex = /^[a-zA-ZÀ-ỹ\s]+$/;
                if (!regex.test(name)) {
                    return false;
                }
                if (name.length > 30) {
                    return false;
                }
                return true;
            }

            function isValidPhoneNumber(phoneNumber) {
                var regex = /^0[0-9]{9}$/;
                return regex.test(phoneNumber);
            }


        </script>
        <script>
            function showMess( {
            type = 'success',
                    title = '',
                    duration = 3000
            }) {
                const iconMess = {
                    success: 'bx bxs-check-circle',
                    error: 'bx bxs-x-circle',
                    warning: 'bx bx-info-circle'
                };
                const icon = iconMess[type];
                const cartBox = document.getElementById('cart-mess')
                if (cartBox) {
                    const cartMess = document.createElement('div');
                    const delay = (duration / 1000).toFixed(2)
                    cartMess.classList.add('cart-mess', "cart-mess_" + type)
                    cartMess.style.animation = `slideShow ease .3s, fadeOut linear 1s ` + delay + `s forward;`
                    cartMess.innerHTML = `<div class="d-flex align-items-center">
               <div class="cart-mess_head me-3">
                   <i class='` + icon + ` text-white' style="font-size: 30px;"></i>
               </div>
               <div class="cart-mess_content fs-4 text-center">
                   ` + title + `
               </div>
           </div>`;
                    cartBox.appendChild(cartMess)
                    setTimeout(() => {
                        cartBox.removeChild(cartMess)
                    }, duration + 1000);
            }
            }
        </script>
    </body>

</html>