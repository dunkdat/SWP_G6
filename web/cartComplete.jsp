<%-- 
    Document   : paymentInfo
    Created on : 28 Feb, 2024, 2:29:03 PM
    Author     : HP
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="java.util.*" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" 
           prefix="fn" %> 
<%@page import="constant.*" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment info</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
       <link rel="stylesheet" href="css/homestyle.css"/>
        <link rel="stylesheet" href="./css/style_1.css">
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
        </style>
    </head>

    <body>
<header class="header collapsed">
        <div class="left-section">
            <img src="images/logo.png" alt="Shop Logo" style="margin-left: 50px;">
            <span class="hotline">HOTLINE: 0962906982 | 0333256947</span>
            <span class="store-locator">HỆ THỐNG CỬA HÀNG</span>
        </div>
        <div class="right-section">
            <div class="search-bar">
                <input type="text" placeholder="Tìm sản phẩm...">
                <span class="search-icon">🔍</span>
            </div>
            <div class="icons">
                <a href="ProfileServlet?current_user=${sessionScope.current_user}"><img src="images/profile.png" alt="Account"></a>
                <a href="cart"><img src="images/cart.png" alt="Cart"></a>
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
                                                        <c:set var="totalPrice" value="${product.price * product.quantity}" />
                                                        <c:set var="total" value="${total + totalPrice}"/>

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
                <h4 class="my-5 fs-3">THÔNG TIN NHẬN HÀNG</h4>
                <div class="box-info_address rounded-lg p-5">
                    <div class="row gy-5">
                        <div class="col-6">
                            <div class="customer_box-info">
                                <p class="info-label">TỈNH / THÀNH PHỐ</p>
                                <select id="city" class="box-location" class="fs-3">
                                    <option value="" selected>Chọn tỉnh thành</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="customer_box-info">
                                <p class="info-label">QUẬN / HUYỆN</p>
                                <select id="district" class="box-location" class="fs-3">
                                    <option value="" selected>Chọn quận huyện</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="customer_box-info">
                                <p class="info-label">PHƯỜNG / XÃ</p>
                                <select id="ward" class="box-location" class="fs-3">
                                    <option value="" selected>Chọn phường xã</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="customer_box-info">
                                <p class="info-label">CHI TIẾT ĐỊA CHỈ NHẬN</p>
                                <input type="text" class="border-0" id="address-detail">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-white p-3 mt-5 " >
                    <input name="payment_type" type="radio" checked style="color: green;"/> <span>Thanh toan khi nhan hang</span>
                </div>
                <div data-mdb-input-init class="form-outline form-white mb-4">
                    <label class="form-label my-5 fs-3" for="typeText">Shippment</label>
                    <select name="shipment"  style="width: 100%; height: 30px; border: none">
                        <c:forEach var="ship" items="${shipments}">
                            <option value="${ship.id}">${ship.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="bottom-bar p-4">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <h3 class="fw-bold">Tổng tiền tạm tính:</h3>
                <span class="text-danger fw-bold fs-4"><fmt:formatNumber value="${total}" type="number" maxFractionDigits="2" minFractionDigits="2" />$</span>
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
            $('#paymentModal').on('show.bs.modal', function (event) {
                document.body.style.height = '100vh'
                $('body').addClass('hiddenPadding');
            });
            $('#paymentModal').on('hide.bs.modal', function (event) {
                // Hủy style height khi modal bị đóng
                document.body.style.height = '';
                $('body').removeClass('hiddenPadding');
            });
            const host = "https://vietnamese-administration.vercel.app/city";
            const hostDistricts = "https://vietnamese-administration.vercel.app/district?cityId=";
            const hostWards = "https://vietnamese-administration.vercel.app/ward?districtId=";
            var callAPIProvinces = (api) => {
                fetch(api)
                        .then((response) => {
                            return response.json()
                        })
                        .then((data) => {
                            renderProvince(data, "city");
                        })
            }
            callAPIProvinces(host)

            var callApiDistrict = (api) => {
                return fetch(api)
                        .then((response) => {
                            return response.json()
                        })
                        .then((data) => {
                            renderDistrict(data, "district");
                            console.log(data);
                        })
            }

            var callApiWard = (api) => {
                return fetch(api)
                        .then((response) => {
                            return response.json()
                        })
                        .then((data) => {
                            renderWard(data, "ward");
                            console.log(data);
                        })
            }

            var renderProvince = function (data, select) {
                let options = '<option value="" selected>Chọn tỉnh thành</option>';
                data.forEach(element => {
                    options += `<option value="` + element.name + `" data-id="` + element.cityId + `">` + element.name + `</option>`;
                });
                document.querySelector("#" + select).innerHTML = options;
            }
            var renderDistrict = function (data, select) {
                let options = '<option value="" selected>Chọn quận huyện</option>';
                data.forEach(element => {
                    options += `<option value="` + element.name + `" data-id="` + element.districtId + `">` + element.name + `</option>`;
                });
                document.querySelector("#" + select).innerHTML = options;
            }
            var renderWard = function (data, select) {
                let options = '<option value="" selected>Chọn phường xã</option>';
                data.forEach(element => {
                    options += `<option value="` + element.name + `" data-id="` + element.wardId + `">` + element.name + `</option>`;
                });
                document.querySelector("#" + select).innerHTML = options;
            }


            $('#city').change(() => {
                callApiDistrict(hostDistricts + $("#city").find(':selected').data('id'))
            })

            $('#district').change(() => {
                callApiWard(hostWards + $("#district").find(':selected').data('id'))
            })

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

                if (!validateField(name, isValidName, messName))
                    return;
                if (!validateField(phone, isValidPhoneNumber, messPhone))
                    return;

                let city = $('#city').val();
                let district = $('#district').val();
                let ward = $('#ward').val();
                let addressDetail = $('#address-detail').val();
                let shipment = $('select[name="shipment"]').val(); // Lấy giá trị shipment
                if (checkEmpty(city, "Không thể để trống city"))
                    return true;
                if (checkEmpty(district, "Không thể để trống district"))
                    return true;
                if (checkEmpty(ward, "Không thể để trống ward"))
                    return true;
                if (checkEmpty(addressDetail, "Không thể để trống address detail"))
                    return true;
                const formData = {
                    Service: "payment",
                    reciveName: name,
                    recivePhone: phone,
                    city: city,
                    district: district,
                    ward: ward,
                    addressDetail: addressDetail,
                    shipment: shipment
                };

                $.post('cart', formData, (response) => {
                    // Xử lý phản hồi từ servlet nếu cần
                    console.log(response);
                    window.location = "cart?mess=order success";
                }).fail((jqXHR, textStatus, errorThrown) => {
                    // Xử lý lỗi nếu có
                    console.error("Error: " + textStatus, errorThrown);
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