<%-- 
    Document   : addMoreAddress
    Created on : 22 thg 10, 2024, 00:19:41
    Author     : Lenovo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Info</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/homestyle.css"/>
        <link rel="stylesheet" href="./css/style_1.css">
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
        
    <a class="text-white text-start btn btn-primary" href="cartComplete">Back to payment</a>
    <div class="container py-5">
        <h1 class="text-center mb-4">Payment Information</h1>

        <c:forEach var="add" items="${requestScope.address}"> 
            <div class="d-flex align-items-center mb-3 border-bottom">
                <input type="radio" name="address" value="${add.city}, ${add.district}, ${add.ward}, ${add.detail}" class="form-check-input me-3"/>
                <p class="mb-0">${add.city}, ${add.district}, ${add.ward}, ${add.detail}</p>
            </div>
        </c:forEach>

        <h4 class="text-danger text-center">${mess}</h4>

        <form action="addAddress" method="POST" class="mt-4">
            <div class="box-info_address rounded-lg p-4 border shadow-sm">
                <div class="row gy-4">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="city" class="form-label">TỈNH / THÀNH PHỐ</label>
                            <select id="city" name="city" class="form-select" required>
                                <option value="" selected>Chọn tỉnh thành</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="district" class="form-label">QUẬN / HUYỆN</label>
                            <select id="district" name="district" class="form-select" required>
                                <option value="" selected>Chọn quận huyện</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group">
                            <label for="ward" class="form-label">PHƯỜNG / XÃ</label>
                            <select id="ward" name="ward" class="form-select" required>
                                <option value="" selected>Chọn phường xã</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group">
                            <label for="address-detail" class="form-label">CHI TIẾT ĐỊA CHỈ NHẬN</label>
                            <input type="text" id="address-detail" name="detail" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-12 text-center">
                        <button class="btn btn-primary w-50" type="submit">Add Address</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
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
</body>
</html>
