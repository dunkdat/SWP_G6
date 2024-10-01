<%-- 
    Document   : newsAuthor
    Created on : Feb 20, 2024, 9:35:40 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.Normalizer" %>
<%@page import="java.util.regex.Pattern" %>
<%@page import="dal.*" %>
<%@page import="model.*" %>
<%@page import="constant.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>



<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>News Author</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    

    <body>
        <c:set var="news" value="${requestScope.listnew}"/>
        <section>
            <div class="author_page">
                <div class="address-page bg-white">
                    <div class="container">

                        <ul class="d-flex align-items-center m-0 py-3">
                            <li>
                                <a class="fs-4 me-2 text-blue" href="home">Trang chủ /
                                </a>
                            </li>
                            <li>
                                <a class="fs-4 text-blue" href="NewsServlet">Tin Tức  /
                                </a>
                            </li>
                            <li class="fs-4">
                                <span>Tác giả 
                                    <c:forEach var="newsItem" items="${requestScope.listnews}" varStatus="loop">
                                        <c:if test="${loop.index == 0}">
                                            ${newsItem.adminName}
                                        </c:if>
                                    </c:forEach>
                                </span>

                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row box_author ">
                    <div class="author bg-white">
                        <div class="container">
                            <div class="author_news d-flex">
                                <div class="author_avatar col-2">
                                    <div class="author_img">
                                        <img src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg"
                                             alt="">
                                    </div>
                                </div>
                                <div class="author_infor col-10">
                                    <h1 class="author_name"><c:forEach var="newsItem" items="${requestScope.listnews}" varStatus="loop">
                                            <c:if test="${loop.index == 0}">
                                                ${newsItem.adminName}
                                            </c:if>
                                        </c:forEach></h1>
                                    <div class="author_time">
                                        Thời gian hoạt động:
                                        <span class="fw-bold">
                                            5 tháng
                                        </span>
                                    </div>
                                    <p class="author__description">
                                        Luôn cố gắng tìm tòi và học hỏi để nâng cao kiến thức và kỹ năng của
                                        bản thân, nhằm mang đến những nội dung chất lượng và hấp dẫn cho
                                        người đọc.
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="content-wrapper">
                    <div class="container">
                        <div class="row">
                            <div class="col-8">
                                <h2>${totalNewsByAdmin} BÀI VIẾT CỦA TÁC GIẢ</h2>
                                <c:forEach var="news" items="${requestScope.listnews}">
                                    <div class="news_item-author">
                                        <div class="list-post">
                                            <div class="post-items d-flex">
                                                <div class="post_photo">
                                                    <a href="NewsServlet?Service=NewsDetail&Nid=${news.newsId}" style="display: block; height: 100%;">
                                                        <img src="${IConstant.PATH_NEWS}/${news.imagePath}" 
                                                             alt="">
                                                    </a>
                                                </div>
                                                <div class="post-infor">
                                                    <a class="post_tittle text-black" href="">
                                                        <h3 style="font-weight: 500">${news.newsTitle}</h3>
                                                    </a>
                                                    <span class="post_time">
                                                        ${news.timeDifferenceInDays} ngày 
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="col-4">
                                <h2>TOP 5 BÀI VIẾT NỔI BẬT</h2>
                                <c:forEach var="news" items="${requestScope.top5news}">
                                    <div class="list-post-abc">
                                        <div class="post-item flex flex-center-ver">
                                            <a  class="post__picture" class="d-block" href="">
                                                 <img style="width: 120px ; height: 40px" src="${IConstant.PATH_NEWS}/${news.imagePath}" 
                                                             alt="">
                                                   </a>

                                            <a style="color: black" class="post__title">
                                                <h3>${news.newsTitle}</h3>
                                            </a>

                                        </div>
                                    </div> 
                                </c:forEach>
                            </div>

                        </div>
                    </div>

                </div>
                <div class="paging my-5">
                    <div class="paging-box d-flex">
                        <c:if test="${currentPage > 1}">
                            <span class="prev-paging">
                                <a href="NewsManagerServlet?Service=newsAuthor&amp;aid=${param.aid}&amp;indexPage=${currentPage - 1}">
                                    <i class='bx bx-chevron-left'></i>
                                </a>
                            </span>
                        </c:if>

                        <c:forEach var="pageNumber" begin="1" end="${totalPages}">
                            <span class="number-paging ${pageNumber == currentPage ? 'current-paging' : ''}">
                                <a href="NewsManagerServlet?Service=newsAuthor&amp;aid=${param.aid}&amp;indexPage=${pageNumber}">
                                    ${pageNumber}
                                </a>
                            </span>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <span class="next-paging">
                                <a href="NewsManagerServlet?Service=newsAuthor&amp;aid=${param.aid}&amp;indexPage=${currentPage + 1}">
                                    <i class='bx bx-chevron-right'></i>
                                </a>
                            </span>
                        </c:if>      
                    </div>
                </div>

            </div>
        </section>
    </body>

</html>
