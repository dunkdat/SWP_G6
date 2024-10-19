<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dal.*" %>
<%@page import="java.util.List" %>
<%@page import="model.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="constant.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cartegories</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="./css/invoice.css">
        <style>
            .paging {
                text-align: center;
            }

            .paging-box {
                background-color: #f8f9fa;
                border-radius: 5px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .prev-paging, .next-paging {
                padding: 10px;
            }

            button {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:disabled {
                background-color: #ccc;
                cursor: not-allowed;
            }

            .pagination {
                list-style: none;
                display: flex;
                margin: 0;
                padding: 10px;
            }

            .number-paging {
                margin: 0 5px;
            }

            .page-link {
                background-color: #fff;
                color: #007bff;
                border: 1px solid #007bff;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .page-link:hover {
                background-color: #007bff;
                color: #fff;
            }
            .modal.preview {
                --bs-modal-width: 50%;
            }
        </style>
    </head>

    <body>
        <section>
            <div class="row h-100">
                <div class="col-md-12 h-100 manage-product">
                    <div class="mt-5">
                        <div class="row bg-weak rounded-lg px-3 py-4 fs-4">
                            <div class="col-1">
                                <div class="d-flex align-items-center">
                                    <span>id</span>
                                    <a href=""><i class='bx bx-sort-down text-black-weak'></i></a>
                                </div>
                            </div>
                            <div class="d-none d-md-block col-sm-1 text-center">image</div>
                            <div class="col-4 col-md-2">
                                <div class="d-flex align-items-center">
                                    <span>name</span>
                                    <a href=""><i class='bx bx-sort-a-z text-black-weak'></i></a>
                                </div>
                            </div>
                            <div class="col-2 col-md-1 d-md-block d-none">
                                <div class="d-flex align-items-center">
                                    <span>Type</span>
                                </div>
                            </div>
                            <div class="col-2 col-md-1 d-md-block d-none">
                                <div class="d-flex align-items-center">
                                    <span>Color</span>
                                </div>
                            </div>
                            <div class="col-md-2 col-3">
                                <div class="d-flex align-items-center">
                                    <span>price</span>
                                    <a href=""><i class='bx bx-sort-down text-black-weak'></i></a>
                                </div>
                            </div>
                            <div class="col-2 col-md-1">
                                <div class="d-flex align-items-center">
                                    <span>quantity</span>
                                    <a href=""><i class='bx bx-sort-down text-black-weak'></i></a>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="d-flex align-items-center">
                                    <span>total</span>
                                    <a href=""><i class='bx bx-sort-down text-black-weak'></i></a>
                                </div>
                            </div>
                            <div class="d-md-block d-none col-sm-1">Setting</div>
                        </div>
                        <div class="row gx-5 gap-sm-0">
                            <c:set value="" var="totlaP" />

                            <c:forEach var="od" items="${orderDetails}">
                                <c:set value="${od.price * od.quantity}" var="totlaP" />
                                <!--view ra các item -->
                                <div class="col-12 col-sm-4 col-md-12 mt-5 transition-item">
                                    <div
                                        class="row position-relative fs-4 px-3 py-4 d-flex align-items-center justify-content-between bg-white rounded-lg border">
                                        <div class="col-sm-12 col-md-1">${od.id}</div>
                                        <div class="col-sm-12 col-md-1">
                                            <a href="" class="d-block">
                                                <img src="${od.products.link_picture}" alt="">
                                            </a>
                                        </div>
                                        <div class="col-sm-12 col-md-2">${od.products.name}</div>
                                        <div class="col-sm-12 col-md-1">
                                            <span class="text-danger fw-bold manage-dis_text">Thể loại: </span>${od.products.category}
                                        </div>
                                        <div class="col-sm-12 col-md-1">
                                            <span class="text-danger fw-bold manage-dis_text">Màu sắc: </span>${od.products.color}
                                        </div>
                                        <div class="col-md-2 col-sm-12">
                                            <span class="text-danger fw-bold manage-dis_text">Giá: </span><fmt:formatNumber value="${od.price}" type="number" maxFractionDigits="2" minFractionDigits="2" />$
                                        </div>
                                        <div class="col-sm-12 col-md-1">
                                            <span class="text-danger fw-bold manage-dis_text">Số lượng: </span>${od.quantity}
                                        </div>
                                        <div class="col-md-2 col-sm-12">
                                            <span class="text-danger fw-bold manage-dis_text">Tổng: </span><fmt:formatNumber value="${totlaP}" type="number" maxFractionDigits="2" minFractionDigits="2" />$
                                        </div>
                                        <div class="col-sm-6 col-md-1">

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!--phân trang-->
                        </div>

                    </div>
                    <c:set var="bill" value="${order}"/>
                    <div class="bg-weak rounded-md p-5 shadow my-5 mx-3">
                        <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="d-flex align-items-center">
                                    <span class="me-2 fs-5 mw-10">Tên khách hàng: </span>
                                    <div class="fs-3">${bill.name}</div>
                                </div>
                                <div class="d-flex mt-4">
                                    <span class="me-2 fs-5 mw-10">Địa chỉ: </span>
                                    <div class="fs-3">${bill.address}</div>
                                </div>
                                <div class="d-flex mt-4">
                                    <span class="me-2 fs-5 mw-10">Số điện thoại: </span>
                                    <div class="fs-3">${bill.phone}</div>
                                </div>
                                <div class="d-flex align-items-center me-2 mt-4">
                                    <span class="me-2 fs-5 mw-10">Ngày đặt: </span>
                                    <div class="fs-3">${bill.createAt}</div>
                                </div>
                            </div>
                            <div class="col-md-6 col-12 mt-md-0 mt-5">
                                <div class="w-75 ms-md-auto">
                                    <div class="d-flex align-items-center">
                                        <span class="me-2 fs-5 mw-15">Tổng tiền hàng:</span>
                                        <div class="fs-3"><fmt:formatNumber value="${totlaP}" type="number" maxFractionDigits="2" minFractionDigits="2" />$</div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <span class="me-2 fs-5 mw-15">Phương thức Thanh toán:</span>
                                        <div class="fs-4">Thanh toán khi nhận hàng</div>
                                    </div>
                                </div>
                            </div>
                            <!--                            <div class="col-12 mt-md-0 mt-5">
                                                            <div class="">
                                                                <div class="d-flex flex-wrap justify-content-between mt-3">
                                                                    <button class="button-orderitem bg-success mt-4"
                                                                            data-bs-toggle="modal" data-bs-target="#previewInvoice"
                                                                            >Xem hóa đơn PDF</button>
                                                                    <button class="button-orderitem bg-info mt-4" id="export-invoice">
                                                                        Xuất hóa đơn</button>
                                                                </div>
                                                            </div>
                                                        </div>-->
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Modal -->

        <script src="js/jspdf.debug.js"></script>
        <script src="js/html2canvas.min.js"></script>
        <script src="js/html2pdf.min.js"></script>                    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script>
            //funtion để truyền dữ liệu
            function setOrderItemId() {
                var orderIdValue = recipient;
                document.getElementById("orderItemId").value = orderIdValue;
                document.getElementById("myForm").submit();
            }
            $('#exampleModal').on('show.bs.modal', function (event) {
                $('body').addClass('hiddenPadding');
                var button = $(event.relatedTarget); // Button that triggered the modal
                var recipient = button.data('whatever'); // Extract info from data-* attributes
                // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                var modal = $(this);
                modal.find('.modal-title').text(recipient);
                modal.find('.modal-footer input').val(recipient);


            });
            $('#preview').on('show.bs.modal', function (event) {
                $('body').addClass('hiddenPadding');

            });
            const element = document.getElementById('invoice');
            const invoiceId = element.getAttribute("data-id");
            const emailElement = document.getElementById('bill-email');
            const emailInfo = emailElement.getAttribute("data-email");
            console.log(emailInfo)
            $('.btn-download').click(function (e) {
                let filename = "invoice-" + invoiceId + "-" + getTime() + '.pdf';
                let options = {
                    margin: 10,
                    filename: filename,
                    html2canvas: {scale: 4}
                };
                e.preventDefault();
                html2pdf().from(element).set(options).save();
            });
            let mess = "Cảm ơn bạn đã mua hàng ở cừa hàng FphoneShop, \n\
    hãy kiểm tra hóa đơn mua hàng của quý khách.\n\
     Hân hạnh được phục vụ";
            function sendPdfToServlet(filename) {
                $.ajax({
                    type: 'POST',
                    url: 'sendInvoice',
                    //tam thoi fix email real != emailInfo
                    data: {filename: filename, email: "cuongtvhe176258@fpt.edu.vn", mess: mess},
                    success: function (response) {
                        alert('Bạn đã gửi hóa đơn thành công');
                    },
                    error: function (error) {
                        alert('Bạn đã gửi hóa đơn thất bại:', error);
                    }
                });
            }

            const exportInvoceBtn = document.getElementById("export-invoice");
            exportInvoceBtn.addEventListener('click', () => {
                if (confirm("Bạn muốn xuất hóa đơn này tới khách hàng!") == true) {
                    let filename = "invoice-" + invoiceId + "-" + getTime() + '.pdf';
                    let options = {
                        margin: 10,
                        filename: filename,
                        html2canvas: {scale: 4}
                    };
                    window.scrollTo(0, 0);
                    setTimeout(function () {
                        html2pdf().from(element).set(options).save();
                    }, 1000)
                    sendPdfToServlet(filename)
                }
            })
            function getTime() {
                let currentDate = new Date();
                let hours = currentDate.getHours();
                let minutes = currentDate.getMinutes();
                let seconds = currentDate.getSeconds();
                let day = currentDate.getDate();
                let month = currentDate.getMonth() + 1; // Lưu ý: Tháng bắt đầu từ 0
                let year = currentDate.getFullYear();

                hours = (hours < 10) ? '0' + hours : hours;
                minutes = (minutes < 10) ? '0' + minutes : minutes;
                seconds = (seconds < 10) ? '0' + seconds : seconds;
                day = (day < 10) ? '0' + day : day;
                month = (month < 10) ? '0' + month : month;

                let formattedDateTime = hours + '_' + minutes + '_' + seconds + '_' + day + '_' + month + '_' + year;
                return formattedDateTime;
            }
            $('#previewInvoice').on('show.bs.modal', function (event) {
                document.body.style.height = '100vh';
                document.querySelector(".modal.preview").style.overflow = "scroll";
                $('body').addClass('hiddenPadding');
            });
        </script>

        <!--  start      luu viet-->
        <script>
            //funtion để truyền dữ liệu
            function setOrderItemId() {
                var orderIdValue = recipient;
                document.getElementById("orderItemId").value = orderIdValue;
                document.getElementById("myForm").submit();
            }
            $('#exampleModal').on('show.bs.modal', function (event) {
                $('body').addClass('hiddenPadding');
                var button = $(event.relatedTarget); // Button that triggered the modal
                var recipient = button.data('whatever'); // Extract info from data-* attributes
                // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                var modal = $(this);
                modal.find('.modal-title').text(recipient);
                modal.find('.modal-footer input').val(recipient);


            });
            $('#preview').on('show.bs.modal', function (event) {
                $('body').addClass('hiddenPadding');

            });


            function exportData() {
                var isConfirmed = confirm("Bạn có chắc chắn muốn xuất dữ liệu không?");
                if (isConfirmed) {
                    document.getElementById('exportForm').submit();
                } else {

                }
            }
        </script>
        <!--  end      luu viet-->

        <script>
            function showConfirmation() {
                // Hiển thị hộp thoại xác nhận
                var isConfirmed = confirm("Bạn có chắc chắn muốn xóa không?");

                // Nếu người dùng chọn "OK" trong hộp thoại xác nhận, thì submit form
                if (isConfirmed) {
                    return true; // Cho phép form được submit
                } else {
                    return false; // Ngăn chặn form submit nếu người dùng chọn "Cancel"
                }
            }
        </script>
    </body>

</html>