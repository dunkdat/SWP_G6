<%@page import="java.lang.String"%>
<%@page import="java.util.List" %>
<%@page import="dal.*" %>
<%@page import="model.OrderManager"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.math.RoundingMode"%>
<html lang="en">
    <% List<OrderManager> orders = (List<OrderManager>) request.getAttribute("orders");
        System.out.println(orders.size());
        int totalPages = (int) request.getAttribute("totalPages");
        int currentPage = (int) request.getAttribute("currentPage");
        String querry = request.getAttribute("querry") != null ? (String) request.getAttribute("querry") : "";
        String querry2 = request.getAttribute("querry2") != null ? (String) request.getAttribute("querry2") : "";
        String que = request.getAttribute("que") != null ? (String) request.getAttribute("que") : "";
        int pageSize = (int) request.getAttribute("pageSize");
        if (request.getAttribute("isExport") != null) {
    %>

    <script>
        alert("Xuất file thành công");
    </script>
    <%
        }
    %>
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


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



            .panging {
                margin-top: 20px;
                margin-bottom: 20px;
                margin-left: 20px;
            }

            /* CSS cho select box */
            .panging select {
                width: 200px;
                height: 30px;
                padding: 5px;
                font-size: 16px;
                border: 1px solid black;
                border-radius: 9px;
                margin-right: 15px;

            }


            .panging select option {
                font-size: 16px;
            }


            .search-button:hover {
                background-color: #0056b3;
            }


            .number-pagingactive {
                background-color: #007bff;
                color: #fff;
            }
        </style>


    </style>

</head>

<body>


    <section>
        <div class="row h-100">
            <div class="col-md-2 h-100 left-nav-admin p-0">
                <div class="p-5 pe-0">
                    <ul>
                        <li class="py-4 ps-3 mb-3">
                            <a href="" class="fs-2 text-white d-flex align-items-center">
                                <i class='bx bxs-dashboard me-3'></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
                        <li class="py-4 ps-3 mb-3 active">
                            <a href="" class="fs-2 text-white">
                                <i class='bx bx-cart me-3'></i>
                                <span>Order</span>
                            </a>
                        </li>
                        <li class="py-4 ps-3 mb-3">
                            <a href="" class="fs-2 text-white d-flex align-items-center">
                                <i class='bx bx-circle-three-quarter me-3'></i>
                                <span>Statistic</span>
                            </a>
                        </li>
                        <li class="py-4 ps-3 mb-3">
                            <a href="" class="fs-2 text-white d-flex align-items-center">
                                <i class='bx bxs-data me-3'></i>
                                <span>Products</span>
                            </a>
                        </li>
                        <li class="py-4 ps-3 mb-3">
                            <a href="" class="fs-2 text-white d-flex align-items-center">
                                <i class='bx bx-line-chart me-3'></i>
                                <span>Stock</span>
                            </a>
                        </li>
                        <li class="py-4 ps-3 mb-3">
                            <a href="" class="fs-2 text-white d-flex align-items-center">
                                <i class='bx bx-purchase-tag-alt me-3'></i>
                                <span>Offer</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-md-10 h-100 manage-product">
                <h1 class="fw-bold my-4">Manager Order</h1>
                <div class="row mt-5 ">
<!--                    <div class="col-6">
                        <div class="d-flex align-items-center">
                            <div class="file-upload_box" data-bs-toggle="modal" data-bs-target="#importModal">
                                <span class="d-md-block d-none" onclick="exportData()">Import from excel</span>
                                 <input type="file" accept="xls" id="file-upload_input"> 
                                <i class='bx bxs-file-import'></i>
                            </div>
                            <form id="exportForm" action="orderManagerServlet" method="get">
                                 Nút để kích hoạt hàm exportData 
                                <div class="file-export_box ms-4" onclick="exportData()">
                                    <input type="hidden" name="service" value="export">
                                    <span class="d-md-block d-none">Export to Excel</span>
                                    <i class='bx bxs-file-export'></i>
                                </div>
                            </form>
                            <div class="col-sm-6 col-md-5 search-box " style="padding-right: 10%; margin-left: 2%;">
                                <div class="input-box d-flex">
                                    <form class="d-flex" action="orderManagerServlet" method="post">
                                        <div class="search-input" style="flex: 3;">
                                            <input name="search" type="text"
                                                   placeholder="Search for order"
                                                   aria-label="Example text with button addon" style="width: 100%;">
                                        </div>
                                        <button name="service" value="search" type="submit" class="search-button" style="background-color: #007bff; color: #fff; border: none; border-radius: 5px; padding: 10px 20px; margin-left: 10px; cursor: pointer; transition: background-color 0.3s;">Search</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>-->
                    <div class="col-6">
                        <div class="box-procees_order">
                            <form id="myForm" action="orderManagerServlet" method="post">
                                <input type="hidden" value="<%=totalPages%>" name="totalPages">
                                <input type="hidden" value="<%=currentPage%>" name="currentPage">
                                <input type="hidden" value="<%=querry%>" name="querry">
                                <input type="hidden" value="<%=querry2%>" name="querry2">
                                <input type="hidden" value="pagging" name="service">
                                <input type="hidden" value="<%=que%>" name="que">
                                <div class="panging" name="epp">
                                    <label for="pa"  style="font-size: 16px">Choose elements per page:</label>
                                    <select id="pa" name="nepp">
                                        <option value="20" <%= (pageSize == 20) ? "selected" : ""%>>20 elements per page</option>
                                        <option value="50" <%= (pageSize == 50) ? "selected" : ""%>>50 elements per page</option>
                                        <option value="100" <%= (pageSize == 100) ? "selected" : ""%>>100 elements per page</option>

                                    </select>
                                </div>
                            </form>
                            <script>

                                $(document).ready(function () {
                                    $('#pa').change(function () {
                                        var selectedValue = $(this).val();
                                        $('#selectedValue').val(selectedValue);
                                        $('#myForm').submit();
                                    });
                                });
                            </script>

                            <div class="sort-order_btn">
                                <i class='bx bx-sort-alt-2'></i>
                                <span>Sort by</span>
                                <div class="box-sort_order">
                                    <form action="orderManagerServlet" method="POST">
                                        <input type="hidden" value="<%=totalPages%>" name="totalPages">
                                        <input type="hidden" value="<%=currentPage%>" name="currentPage">
                                        <input type="hidden" name="querry2" value="<%=querry2%>">
                                        <input type="hidden" name="que" value="<%=que%>">
                                        <input type ="hidden" name="pageSize" value="<%=pageSize%>">

                                        <h4 class="box-sort_title mb-0">Sort by</h4>
                                        <div class="line_space-ver"></div>
                                        <div class="p-3">
                                            <h3 class="sort_title">Date</h3>
                                            <div class="d-flex align-items-center">
                                                <input type="radio" id="order-date_asc" name="order-sort" value="o.createAt,">
                                                <label for="order-date_asc" class="ms-3 fs-4">Ascending</label>
                                            </div>
                                            <div class="d-flex align-items-center mt-4">
                                                <input type="radio" id="order-date_des" name="order-sort" value="o.createAt DESC,">
                                                <label for="order-date_des" class="ms-3 fs-4">Descending</label>
                                            </div>
                                        </div>
                                        <div class="line_space-ver"></div>
                                        <div class="p-3">
                                            <h3 class="sort_title">Price</h3>
                                            <div class="d-flex align-items-center">
                                                <input type="radio" id="order-name_asc" name="order-sort" value="totalAmount,">
                                                <label for="order-name_asc" class="ms-3 fs-4">Ascending</label>            
                                            </div>


                                            <div class="d-flex align-items-center mt-4">
                                                <input type="radio" id="order-name_des" name="order-sort" value="totalAmount DESC,">
                                                <label for="order-name_des" class="ms-3 fs-4">Descending</label>
                                            </div>



                                        </div>
                                        <div class="line_space-ver"></div>
                                        <div class="p-3">
                                            <div class="d-flex justify-content-between p-3">
                                                <button type="reset" class="reset_filter-btn">Reset</button>
                                                <button type="submit" class="apply_filter-btn">Apply now</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="filter-order_btn">
                                <i class='bx bx-slider'></i>
                                <span>Filter</span>
                                <div class="box-filter_order">
                                    <form action="orderManagerServlet" method="post">
                                        <input type="hidden" value="<%=totalPages%>" name="totalPages">
                                        <input type="hidden" value="<%=currentPage%>" name="currentPage">
                                        <input type="hidden" value="<%=querry%>" name="querry">
                                        <input type="hidden" value="filter" name="filter">
                                        <input type="hidden" value="<%=que%>" name="que">
                                        <input type ="hidden" name="pageSize" value="<%=pageSize%>">

                                        <h4 class="box-filter_title mb-0 p-4">Filter</h4>
                                        <div class="line_space-ver"></div>
                                        <div class="p-3">
                                            <h3 class="filter_title">Date range</h3>
                                            <div class="mt-4 row">
                                                <div class="col-6">
                                                    <p class="fs-5 mb-0">From:</p>
                                                    <div class="d-flex border rounded-md">
                                                        <input type="text" id="order-date_start"
                                                               name="order-date_start" 
                                                               placeholder="dd/mm/yyyy"
                                                               class="border-0"
                                                               />
                                                        <input type="date" value="" style="width: 30px;
                                                               border: none; outline: none;"
                                                               id="getStartDate" name="fromDate"
                                                               >
                                                    </div>

                                                </div>
                                                <div class="col-6">
                                                    <p class="fs-5 mb-0">To:</p>
                                                    <div class="d-flex border rounded-md">
                                                        <input type="text" id="order-date_end" name="order-date_end" placeholder="dd/mm/yyyy" class="border-0" />
                                                        <input type="date" name="toDate" value="" style="width: 30px; border: none; outline: none;" id="getEndDate" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="p-3">
                                            <h3 class="filter_title">Status</h3>
                                            <select class="form-select form-select_status"
                                                    aria-label="Default select example" name="statusOrder">
                                                <option value="">
                                                    --chọn status--
                                                </option>
                                                <option value="Chờ xác nhận">
                                                    Chờ xác nhận
                                                </option>
                                                <option value="Đã xác nhận">
                                                    Đã xác nhận
                                                </option>
                                                <option value="Đang vận chuyển">
                                                    Đang vận chuyển
                                                </option>
                                                <option value="Đã giao">
                                                    Đã giao
                                                </option>
                                            </select>
                                        </div>
                                        <div class="p-3">
                                            <h3 class="filter_title">Keyword Search</h3>
                                            <div
                                                class="bg-white border d-flex align-items-center rounded-md overflow-hidden">
                                                <span class="p-3 text-black-weak">
                                                    <i class="fa-solid fa-magnifying-glass fs-3"></i>
                                                </span>
                                                <input type="text" placeholder="Search..."
                                                       class="border-0 w-100 py-4 pe-3 fs-4" name="keyword">
                                            </div>
                                        </div>
                                        <div class="p-3">
                                            <div class="d-flex justify-content-between p-3">
                                                <button type="reset" class="reset_filter-btn">Reset</button>
                                                <button type="submit" class="apply_filter-btn">Apply now</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="mt-5 col-lg-12 table-header bg-weak rounded-xl ">
                        <div class="row fs-4 fw-bold py-4 px-3 d-flex align-items-center justify-content-between">
                            <div class="col-10 col-md-1">
                                <div class="d-flex align-items-center">
                                    <input type="checkbox" id="checkAllOrder">
                                    <label for="checkAllOrder" class="ms-3">All</label>
                                </div>
                            </div>
                            <div class="col-md-2 d-none d-md-block">
                                <div class="d-flex align-items-center">
                                    <span>Mail</span>
                                    <i class='bx bx-envelope ms-2'></i>
                                </div>
                            </div>
                            <div class="col-md-2 d-none d-md-block">
                                <div class="d-flex align-items-center">
                                    <span>Phone</span>
                                    <i class='bx bx-phone ms-2'></i>
                                </div>
                            </div>
                            <div class="col-md-2 d-none d-md-block">
                                <div class="d-flex align-items-center">
                                    <span>Date</span>
                                    <i class='bx bx-sort-down text-black-weak ms-2'></i>
                                </div>
                            </div>
                            <div class="col-md-2 d-none d-md-block">Total</div>
                            <div class="col-md-1 d-none d-md-block">Status</div>
                            <div class="col-2 col-md-1 text-md-center text-end">View</div>
                            <div class="col-2 col-md-1 text-md-center text-end">Setting</div>
                        </div>
                    </div>

                    <%
                        DecimalFormat df = new DecimalFormat("#,##0");
                        //DaoOrder dao_order = new DaoOrder();

//                        int itemsPerPage = 5; // Số lượng item trên mỗi trang
//        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
//        int startIndex = (currentPage - 1) * itemsPerPage;
//        int endIndex = Math.min(startIndex + itemsPerPage, orders.size());
                        for (OrderManager order : orders) {

                    %>
                    <!--ph?n view ra các ??n hàng-->

                    <div class="col-12 col-sm-6 col-md-12 mt-5 transition-item">
                        <div
                            class="row position-relative fs-4 px-3 py-4 d-flex align-items-center justify-content-between bg-white rounded-lg border">
                            <div class="col-sm-12 col-md-1">
                                <div class="d-flex align-items-center justify-content-md-start justify-content-between">
                                    <input type="checkbox">
                                    <label for="" class="ms-3"><%=order.getOrderId()%></label>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-2" style="word-break: break-all;">
                                <span class="text-danger fw-boldz">Mail:
                                </span><%=order.getEmail()%>
                            </div>
                            <div class="col-sm-6 col-md-1">
                                <span class="text-danger fw-bold">Phone:
                                </span><%=order.getPhone()%>
                            </div>
                            <div class="col-sm-12 col-md-2">
                                <span class="text-danger fw-bold fs-4">Add date:</span><%=order.getOrderDate()%>
                            </div>
                            <div class="col-sm-12 col-md-2">
                                <span class="text-danger fw-bold ">Total: </span><%=df.format(order.getTotal())%> vnđ
                            </div>
                            <div class="col-6 fs-4 col-md-2">
                                <form id="statusForm_<%=order.getOrderId()%>" action="orderManagerServlet" method="POST" onsubmit="return confirm('Are you sure you want to update the status?')">
                                    <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
                                    <input type="hidden" name="service" value="changeStatus">
                                    <input type="hidden" value="<%=totalPages%>" name="totalPages">
                                    <input type="hidden" value="<%=currentPage%>" name="currentPage">
                                    <input type="hidden" value="<%=querry%>" name="querry">
                                    <input type="hidden" value="<%=querry2%>" name="querry2">
                                    <input type="hidden" value="<%=que%>" name="que">
                                    <input type ="hidden" name="pageSize" value="<%=pageSize%>">


                                    <select name="newStatus" onchange="this.form.submit()">
                                        <option class="done-status" value="Chờ xử lý" 
                                                <%= order.getStatus().equals("Chờ xác nhận") ? "selected" : "" %> 
                                                <%= order.getStatus().equals("Đã xác nhận") || order.getStatus().equals("Đang vận chuyển") || order.getStatus().equals("Đã giao") || order.getStatus().equals("Đã hủy") ? "disabled" : "" %>>
                                            Chờ xác nhận
                                        </option>

                                        <option class="wait-status" value="Đã xác nhận" 
                                                <%= order.getStatus().equals("Đã xác nhận") ? "selected" : "" %> 
                                                <%= order.getStatus().equals("Đang vận chuyển") || order.getStatus().equals("Đã giao") || order.getStatus().equals("Đã hủy") ? "disabled" : "" %>>
                                            Đã xác nhận
                                        </option>

                                        <option class="process-status" value="Đang vận chuyển" 
                                                <%= order.getStatus().equals("Đang vận chuyển") ? "selected" : "" %> 
                                                <%= order.getStatus().equals("Đã giao") || order.getStatus().equals("Đã hủy") ? "disabled" : "" %>>
                                            Đang vận chuyển
                                        </option>

                                        <option class="process-status" value="Đã giao" 
                                                <%= order.getStatus().equals("Đã giao") ? "selected" : "" %>>
                                            Đã giao
                                        </option>

                                        <option class="process-status" value="Đã hủy" 
                                                <%= order.getStatus().equals("Đã hủy") ? "selected" : "" %>>
                                            Đã hủy
                                        </option>
                                    </select>

                                </form>
                            </div>
                            <div class="col-6 text-md-center text-end  col-md-1">
                                <a href="orderDetailServlet?orderId=<%=order.getOrderId() + ""%>&customerId=<%=order.getCustomerId() + ""%>"
                                   class="text-black-weak text-decoration-none text-info">Detail</a>
                            </div>
                            <div class="col-6 text-md-center text-end col-md-1">
<!--                                <a href="orderManagerServlet?service=delete&orderId=<%=order.getOrderId()%>"
                                    class="text-danger text-decoration-none text-info">Delete</a>-->

                                <form id="deleteForm" action="orderManagerServlet" method="POST">
                                    <input type="hidden" value="<%=order.getOrderId()%>" name="orderId">
                                    <input type="hidden" value="<%=totalPages%>" name="totalPages">
                                    <input type="hidden" value="<%=currentPage%>" name="currentPage">
                                    <input type="hidden" value="<%=querry%>" name="querry">
                                    <input type="hidden" value="<%=querry2%>" name="querry2">
                                    <input type ="hidden" name="pageSize" value="<%=pageSize%>">

                                    <button 
                                        class="text-danger text-decoration-none text-info" 
                                        type="submit" 
                                        value="delete"
                                        name="service" 
                                        style="
                                        color: #dc3545; /* Text color for danger/red */
                                        background-color: transparent; /* Transparent background */
                                        border: none; /* No border */
                                        outline: none; /* No outline */
                                        box-shadow: none; /* No box shadow */
                                        cursor: pointer; /* Show pointer cursor on hover */
                                        transition: color 0.3s ease, background-color 0.3s ease; /* Smooth transition effects */
                                        "
                                        onclick="return showConfirmation()"
                                        >
                                        delete
                                    </button>

                                </form>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>


                </div>
            </div>
            <div class="paging mt-5">
                <div class="paging-box d-flex">
                    <form method="post" action="orderManagerServlet" class="prev-paging">

                        <input type="hidden" name="querry" value="<%=querry%>">
                        <input type="hidden" name="querry2" value="<%=querry2%>">
                        <input type="hidden" value="<%=que%>" name="que">
                        <input type ="hidden" name="pageSize" value="<%=pageSize%>">


                        <button type="submit" <% if (currentPage <= 1) { %>disabled<% }%>>
                            <i class='bx bx-chevron-left'></i>
                        </button>
                        <input type="hidden" name="page" value="<%= currentPage - 1%>">
                    </form>

                    <ul class="pagination">
                        <% for (int i = 1; i <= totalPages; i++) {%>
                        <li class="number-paging" <%= (i == currentPage) ? "active" : ""%>>
                            <form method="post" action="orderManagerServlet">
                                <input type="hidden" name="querry" value="<%=querry%>">
                                <input type="hidden" name="querry2" value="<%=querry2%>">
                                <input type="hidden" value="<%=que%>" name="que">
                                <input type ="hidden" name="pageSize" value="<%=pageSize%>">



                                <button type="submit" class="page-link" name="page" value="<%= i%>">
                                    <%= i%>
                                </button>
                            </form>
                        </li>
                        <% }%>
                    </ul>

                    <form method="post" action="orderManagerServlet" class="next-paging">

                        <input type="hidden" name="querry" value="<%=querry%>">
                        <input type="hidden" name="querry2" value="<%=querry2%>">
                        <input type="hidden" value="<%=que%>" name="que">
                        <input type ="hidden" name="pageSize" value="<%=pageSize%>">


                        <button type="submit" <% if (currentPage >= totalPages) { %>disabled<% }%>>
                            <i class='bx bx-chevron-right'></i>
                        </button>
                        <input type="hidden" name="page" value="<%= currentPage + 1%>">
                    </form>
                </div>
            </div>


        </div>

    </div>
    <!-- Modal -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
    crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- <script src="./js/app.js"></script> -->
    <script>
                                            $('#importModal').on('show.bs.modal', function (event) {
                                                $('body').addClass('hiddenPadding');
                                                var button = $(event.relatedTarget) // Button that triggered the modal
                                                var recipient = button.data('whatever') // Extract info from data-* attributes
                                                // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                                                // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                                                var modal = $(this)
                                                modal.find('.modal-title').text(recipient)
                                                modal.find('.modal-body input').val(recipient)
                                            });


                                            //code chuyển dữ liệu sang trang khác để export ra exel
                                            function exportData() {

                                                var isConfirmed = confirm("Bạn có chắc chắn muốn xuất dữ liệu không?");


                                                if (isConfirmed) {
                                                    document.getElementById('exportForm').submit();
                                                } else {

                                                }
                                            }

    </script>


    <script>
        let inputDateStart = document.querySelector('input[name="order-date_start"]')
        let getStartDate = document.querySelector('#getStartDate')

        getStartDate.addEventListener('change', function () {
            let dateValue = new Date(this.value)
            const year = dateValue.getFullYear();
            const month = String(dateValue.getMonth() + 1).padStart(2, '0');
            const day = String(dateValue.getDate()).padStart(2, '0');
            inputDateStart.value = day + "/" + month + "/" + year;
        })

        let inputDateEnd = document.querySelector('input[name="order-date_end"]');
        let getEndDate = document.querySelector('#getEndDate');

        getEndDate.addEventListener('change', function () {
            let dateValue = new Date(this.value);
            const year = dateValue.getFullYear();
            const month = String(dateValue.getMonth() + 1).padStart(2, '0');
            const day = String(dateValue.getDate()).padStart(2, '0');
            inputDateEnd.value = day + "/" + month + "/" + year;
        });


    </script>

    <%--hiện của sổ xác nhận xóa--%>
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