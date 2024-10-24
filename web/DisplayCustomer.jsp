<%-- 
    Document   : customerManager
    Created on : 10-01-2024, 15:18:21
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="constant.IConstant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Manager</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"rel="stylesheet"/>
        <link rel="stylesheet" href="css/homestyle.css"/>
    </head>
    <style>
        a.active{
            background-color: black;
            color: white;
            border-radius: 100px;
        }
        tr:hover{
            background-color: #D6EEEE;
        }
        .left-nav-admin {
            height: 100vh;
        }
    </style>
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
        <section>
            <div class="row h-100">
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
                <div style="padding-right: 10px" class="col-md-10 h-100">
                    <!-- Navbar -->
                    <div class="row mt-5">
                        <div class="col-6">
                        </div>
                        <div class="col-6">
                            <div class="box-procees_order">
                                <div class="sort-order_btn">
                                    <i class="bx bx-sort-alt-2"></i>
                                    <span>Sort by</span>
                                    <div class="box-sort_order">
                                        <form action="CustomerManager" method="get">
                                            <input type="hidden" name="Service" value="sort">
                                            <input type="text" name="numberOnPage" hidden value="${requestScope.numberOnP}">
                                            <h4 class="box-sort_title mb-0">Sort by</h4>
                                            <div class="line_space-ver"></div>
                                            <div class="line_space-ver"></div>
                                            <div class="p-3">
                                                <h3 class="sort_title">Name</h3>
                                                <div class="d-flex align-items-center">
                                                    <input
                                                        type="radio"
                                                        id="order-name_asc"
                                                        name="sortBy"
                                                        value="order-name_asc"
                                                        />
                                                    <label for="order-name_asc" class="ms-3 fs-4"
                                                           >A-Z</label
                                                    >
                                                </div>
                                                <div class="d-flex align-items-center mt-4">
                                                    <input
                                                        type="radio"
                                                        id="order-name_des"
                                                        name="sortBy"
                                                        value="order-name_des"
                                                        />
                                                    <label for="order-name_des" class="ms-3 fs-4"
                                                           >Z-A</label
                                                    >
                                                </div>
                                            </div>
                                            <div class="line_space-ver"></div>
                                            <div class="p-3">
                                                <div class="d-flex justify-content-between p-3">
                                                    <button type="reset" class="reset_filter-btn">
                                                        Reset
                                                    </button>
                                                    <button type="submit" class="apply_filter-btn">
                                                        Apply now
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="filter-order_btn">
                                    <i class="bx bx-slider"></i>
                                    <span>Filter</span>
                                    <div class="box-filter_order">
                                        <h4 class="box-filter_title mb-0 p-4">Filter</h4>
                                        <div class="line_space-ver"></div>
                                        <form action="CustomerManager" method="GET">
                                            <input type="hidden" name="Service" value="search">
                                            <input type="text" name="numberOnPage" hidden value="${requestScope.numberOnP}">
                                            <div class="p-3">
                                                <h3 class="filter_title">Keyword Search</h3>
                                                <div class="bg-white border d-flex align-items-center rounded-md overflow-hidden">
                                                    <span class="p-3 text-black-weak">
                                                        <i class="fa-solid fa-magnifying-glass fs-3"></i>
                                                    </span>
                                                    <input
                                                        type="text"
                                                        value="${saveSearch}"
                                                        placeholder="Search..."
                                                        class="border-0 w-100 py-4 pe-3 fs-4"
                                                        name="keyword"
                                                        />
                                                </div>
                                            </div>
                                            <div class="p-3">
                                                <div class="d-flex justify-content-between p-3">
                                                    <button type="reset" class="reset_filter-btn">
                                                        Reset
                                                    </button>
                                                    <button type="submit" class="apply_filter-btn">
                                                        Apply now
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="margin-top: 7px; display: flex; margin-bottom: 5px">

                        <div style="font-size: 25px; margin-left: 5px; margin-top: 2px" class="fs-3">
                            Show
                            <c:set var="numberPer" value="${requestScope.numberOnP==null?IConstant.ITEMS_PER_PAGE:requestScope.numberOnP}"/>
                            <select id="numberOnPage" onchange="updateItemsPerPage()">
                                <c:forEach var="op" items="${IConstant.NUMBER_OPTION}">
                                    <option ${numberPer==op?'selected':''}>${op}</option>
                                </c:forEach>
                            </select>
                            entries:
                        </div>
                    </div>

                    <c:if test="${countSearch!=null}">
                        <div style="text-align: center">
                            <strong style="color: red">${countSearch}</strong> customers was found
                        </div>
                    </c:if>
                    <c:set var="mess" value="${message}"/>
                    <c:if test="${mess != null}">
                        <div style="text-align: center" class="alert alert-success alert-dismissible fade show" role="alert" id="myAlert">
                            <strong>${mess}</strong>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="closeAlert()"></button>
                        </div>
                    </c:if>                    
                    <!-- User table -->
                    <div class="table-responsive mt-5">
                        <table class="table table-hover align-middle table-bordersmall">
                            <thead style="font-size: large;
                                   text-align: center">
                                <tr class="header-tb">
                                    <th scope="col"># ID</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Address</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="cus" items="${data}">
                                    <tr class="body-tb" style="text-align: center">
                                        <td style="font-size: initial" scope="col">${cus.id}</td>
                                        <td scope="col"><img style="width: 50px;border-radius: 50%;height: 50px" src="./images/User_img/${cus.imagePath}"></td>
                                        <td style="font-size: initial" scope="col">${cus.name}</td>
                                        <td style="font-size: initial" scope="col">${cus.email}</td>
                                        <td style="font-size: initial" scope="col">${cus.address}</td>
                                        <td style="font-size: initial" scope="col">${cus.phone}</td>
                                        <td style="font-size: initial" scope="col">
                                            <a href="CustomerManager?Service=updateCustomer&id=${cus.id}">
                                                <button class="btn btn-primary">
                                                    <i class="fas fa-edit"></i>Update
                                                </button>
                                            </a>
                                            <button class="btn btn-danger">
                                                <i class="fas fa-trash-alt"></i>
                                                <a style="color: white"
                                                   href="CustomerManager?Service=deleteCustomer&id=${cus.id}" onclick="return  confirmDelete()">Delete</a>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="paging mt-5">
                        <div class="paging-box d-flex">
                            <c:if test="${tag >= 2}">
                                <a href="CustomerManager?${saveSearch != null?"Service=search&":""}${saveSort != null?"Service=sort&":""}index=${tag-1}&numberOnPage=${numberOnP}&keyword=${saveSearch}&sortBy=${saveSort}">
                                    <span class="prev-paging"><i class='bx bx-chevron-left unclick'></i></span>
                                </a>
                            </c:if>
                            <c:forEach var="page" begin="1" end="${endP}">
                                <a class="${tag == page?"active":" "}"
                                   href="CustomerManager?${saveSearch != null?"Service=search&":""}${saveSort != null?"Service=sort&":""}index=${page}&numberOnPage=${numberOnP}&keyword=${saveSearch}&sortBy=${saveSort}">
                                    <span class="number-paging">
                                        ${page}
                                    </span>
                                </a>
                            </c:forEach>
                            <c:if test="${tag < endP}">
                                <a href="CustomerManager?${saveSearch != null?"Service=search&":""}${saveSort != null?"Service=sort&":""}index=${tag+1}&numberOnPage=${numberOnP}&keyword=${saveSearch}&sortBy=${saveSort}">
                                    <span class="next-paging"><i class='bx bx-chevron-right'></i></span>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script>
            const avatarElement = document.querySelector('.avatar');
if (avatarElement) {
    avatarElement.addEventListener('mouseover', function () {
        document.querySelector('.dropdown-content').style.display = 'block';
    });
}
function confirmDelete() {
                return confirm("Are you sure you want to delete this customer ?");
            }

            document.querySelector('.dropdown-content').addEventListener('mouseleave', function () {
                document.querySelector('.dropdown-content').style.display = 'none';
            });
            function updateItemsPerPage() {
                var selectedNumber = document.getElementById("numberOnPage").value;
                window.location.href = "CustomerManager?Service=listAllCustomer&numberOnPage=" + selectedNumber;
            }
            function closeAlert() {
                var myAlert = document.getElementById('myAlert');
                myAlert.classList.remove('show');
            }

            document.getElementById("exportButton").addEventListener("click", function () {
                var exportConfirmation = confirm("Would you want to export to excel?");
                if (exportConfirmation) {
                    window.location.href = "export";
                } else {
                    // If the user cancels, do nothing
                }
            });
            
            
        </script>
    </body>
</html>