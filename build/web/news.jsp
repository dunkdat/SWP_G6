<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.text.Normalizer" %>
<%@page import="java.util.regex.Pattern" %>
<%@page import="dal.*" %>
<%@page import="model.*" %>
<%@page import="constant.*" %>
<%@page import="java.util.*" %>

<!DOCTYPE html>

<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>News</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
              crossorigin="anonymous">
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="./js/app.js">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <style>
        .new_type.choose a::after {
            display: block;
        }
    </style>

    <body>
        
        <div class="container">
            <div class="address-page">
            </div>
        </div>
        <section>
            <div class="container">
                <a class="fw-bold mt-5 fs-1 text-black" href="NewsServlet">TIN MỚI</a>
                <ul class="list-news_type">
                    <c:forEach var="newsGroup" items="${requestScope.listnewsgroup}">
                        <c:choose>
                            <c:when test="${newsGroup.newsGroupId ne 6}">
                                <c:set
                                    value="${requestScope.chooseGroup == newsGroup.newsGroupId}"
                                    var="ischoose" />
                                <li class="new_type ${ischoose?'choose':''}"
                                    data-id="${newsGroup.newsGroupId}">
                                    <a href="NewsServlet?GroupId=${newsGroup.newsGroupId}"
                                       class="news-menu__link">
                                        ${newsGroup.newsGroupName}
                                    </a>
                                </li>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                </ul>
                <div class="row box_news ${empty requestScope.listnews?'p-0':''}">
                    <div class="col-9">
                        <div class="news-col news-main">
                            <div class=""></div>
                            <div class="news_card">
                                <div class="pading_news">
                                    <c:forEach var="news" items="${requestScope.listnews}">
                                        <div class="news_item">
                                            <div class="row h-100">
                                                <div class="col-3 h-100">
                                                    <a href="NewsServlet?Service=NewsDetail&Nid=${news.newsId}"
                                                       style="display: block; height: 100%;">
                                                        <img style="width: 100%;
                                                             height: 100%;
                                                             object-fit: cover;" src="${IConstant.PATH_NEWS}/${news.imagePath}"
                                                             alt="">
                                                    </a>
                                                </div>
                                                <div class="col-9 h-100">
                                                    <div class="">
                                                        <a
                                                            href="NewsServlet?Service=getByGroup&GroupId=${news.newsGroupId}">${news.newsGroupName}</a>
                                                        <h3 class="fw-bold fs-2">
                                                            <a class="text-black"
                                                               href="NewsServlet?Service=NewsDetail&Nid=${news.newsId}">
                                                                ${news.newsTitle}
                                                            </a>
                                                        </h3>
                                                        <p class="fs-5" style="overflow: hidden;
                                                           display: -webkit-box;
                                                           -webkit-line-clamp: 2; /* number of lines to show */
                                                           line-clamp: 2;
                                                           -webkit-box-orient: vertical;">${news.shortContent}</p>
                                                        <div class="h-100">
                                                            <div
                                                                class="d-flex align-items-center flex-1">
                                                                <div class="me-3">
                                                                    <img src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg"
                                                                         alt=""
                                                                         style="width: 30px; height: 30px; border-radius: 50%;">
                                                                </div>
                                                                <div class="me-3">
                                                                    <span>${news.adminName}</span>
                                                                    <span>-</span>
                                                                    <span>
                                                                        ${news.timeDifferenceInDays}
                                                                        ngày trước
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-3">
                        <div class="news-col news-hor">
                            <div class="card news-section">
                                <div class="card-header">
                                    <h2 class="card-title">Xem nhiều</h2>
                                </div>
                                <div class="card-body">
                                    <ul class="news-mostView">
                                        <c:forEach var="news"
                                                   items="${requestScope.topNews}"
                                                   varStatus="loop">
                                            <li>
                                                <span>${loop.index + 1}</span>
                                                <a
                                                    href="NewsServlet?Service=NewsDetail&Nid=${news.newsId}">
                                                    <h3>${news.newsTitle}</h3>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>

                            </div>
                            <div class="card news-section">
                                <div class="card-header">
                                    <h2 class="card-title">Sản phẩm mới</h2>
                                </div>
                                <div class="card-body">
                                    <ul class="new-product">
                                        <c:forEach var="Category"
                                                   items="${requestScope.listProduct}">
                                            <li class="new-product__item">
                                                <a class="new-product__item__img"
                                                   href="product?Service=detail&category=${Category.categoriesName}&memory=${Category.minProduct.getMemoryName()}">
                                                    <img style="width:80%; height: 100%"
                                                         src="${IConstant.PATH_PRODUCT}/${Category.minProduct.imagePath}"
                                                         alt="">
                                                </a>
                                                <div class="new-product__item__info">
                                                    <a
                                                        href="product?Service=detail&category=${Category.categoriesName}&memory=${Category.minProduct.getMemoryName()}">
                                                        <h3 style="color: black"
                                                            class="new-product__title">
                                                            ${Category.minProduct.productName}
                                                        </h3>
                                                    </a>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <div class="paging mt-5">
                    <div class="paging-box-news d-flex">
                        <p id="loadmore-btn" data-page="2" class="${hasNext=="true"?'d-block':'d-none'}">Xem Thêm</p>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script>
            const loadmoreBtn = document.getElementById("loadmore-btn");
            let currentType = document.querySelector(".new_type.choose");
            let boxNews = document.querySelector(".box_news");
            let groupId = null;

            loadmoreBtn.addEventListener('click', function () {
                if (currentType) {
                    groupId = currentType.getAttribute("data-id")
                }
                viewMore(groupId)
            })

            function viewMore(groupId) {
                $.ajax({
                    type: 'GET',
                    url: 'NewsServlet',
                    dataType: 'json',
                    data: {
                        GroupId: groupId,
                        index: document.querySelectorAll(".news_item").length
                    },
                    success: function (response) {
                        if (response.hasNext < 1) {
                            loadmoreBtn.classList.add("d-none");
                        } else {
                            loadmoreBtn.classList.add("d-block");
                        }
                        boxNews.innerHTML += response.newsResponse;
                    },
                    error: function (error) {
                        alert("xay ra loi");
                    }
                })
            }
        </script>


    </body>


</html>