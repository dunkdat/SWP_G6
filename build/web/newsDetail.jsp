<%-- Document : newsDetail Created on : Jan 13, 2024, 9:56:50 PM Author : ADMIN --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
        <title>News Detail</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous">
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
              rel='stylesheet'>
        <style>
            .box-review {
                background-color: #333;
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
                width: 100%;
                z-index: 100000;
                display: none;
            }

            .box-review.active-review {
                display: block;
                top: -1;
            }

            .box-review .review-item img {
                width: 30% !important;
                height: 30% !important;
                object-fit: cover;
                margin-left: auto;
                margin-right: auto;
            }

            .c-pointer {
                cursor: pointer;
                z-index: 10000000;
            }

            .review-info {
                position: absolute;
                bottom: 0;
                z-index: 1000000000;
                bottom: 0;
                width: 100%;
                background-color: rgba(52, 52, 52, 0.5);
            }

            .elementor-element-53ab27c {
                max-width: 100%;
                margin: 0 auto;
                background-color: #fff;
                border-radius: 5px;
                padding: 20px;
                width: 100%;
                /* Thêm thuộc tính này để đảm bảo rằng nó chiếm hết chiều ngang của trình duyệt */
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                padding: 20px;
            }

            /* Main container styles */
            .elementor-element-53ab27c {
                max-width: 600px;
                margin: 0 auto;
                background-color: #fff;
                border-radius: 5px;
                padding: 20px;
            }

            /* Textarea styles */
            .cps-textarea-field {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                resize: none;
            }

            /* Button styles */
            .btn-send-cmt {
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-send-cmt:hover {
                background-color: #0056b3;
            }

            /* Comment container styles */
            .block-comment__box-list-comment {
                margin-top: 20px;
            }

            /* Comment styles */
            .comment {
                background-color: #f9f9f9;
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 5px;
            }

            .comment-content {
                margin-bottom: 5px;
            }




            .paging {
                text-align: center;
            }

            .paging-box {
                background-color: #f8f9fa;
                border-radius: 5px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .prev-paging,
            .next-paging {
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


            .comment-form-hidden {
                display: none;
            }

            .comment-item {
                width: 100%;
            }


            .number-pagingactive {
                background-color: #007bff;
                color: #fff;
            }
        </style>
    </head>

    <body>
        <c:set var="currNew" value="${requestScope.currentNews}" />
        <div class="container">
            <div class="address-page">
                <ul class="d-flex align-items-center m-0 py-3">
                    <li>
                        <a class="fs-4 me-2 text-blue" href="NewsServlet">Tin Tức /
                        </a>
                    </li>
                    <li>
                        <a class="fs-4 text-blue"
                           href="NewsServlet?Service=getByGroup&GroupId=${currNew.getNewsGroupId()}">${currNew.newsGroupName}
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <section>
            <div class="container">
                <h1 class="news_tittle">
                    ${currNew.newsTitle}
                </h1>
                <div class="news_head d-flex align-items-center">
                    <img style=""
                         src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg"
                         alt="">
                    <div class="ms-3">
                        <span class="fs-5 fw-bold">${currNew.adminName}</span>
                        <p class="mb-0">${currNew.createDate}</p>
                    </div>
                </div>
                <div class="news_description">
                    ${currNew.description}
                </div>
                <div class="author-wrap">
                    <div class="author_avatar">
                        <img src="https://cdn.sforum.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg"
                             alt="alt" />
                    </div>
                    <div class="author_infor">
                        <div class="author_name">
                            ${currNew.adminName}
                        </div>
                        <div class="author-description">
                            Luôn cố gắng tìm tòi và học hỏi để nâng cao kiến thức và
                            kỹ
                            năng của bản thân, nhằm mang đến những nội dung chất
                            lượng
                            và hấp dẫn cho người đọc.
                        </div>
                        <p class="author-post">
                            <a
                                href="NewsManagerServlet?Service=newsAuthor&aid=${currNew.getAdmin().id}">
                                Xem ${totalNewsByAdmin} bài viết cùng tác giả</a>
                        </p>
                    </div>
                </div>
            </div>
        </section>
        <section class="mt-5">
            <div class="container">
                <h2 class="fw-bold my-4">TIN TỨC LIÊN QUAN</h2>
                <div class="row align-items-center">
                    <c:forEach var="news" items="${requestScope.newRelation}">
                        <c:if test="${news.newsId != currNew.newsId}">
                            <div class="col-md-3">
                                <div class="card h-100"> <a class="text-black"
                                                            href="NewsServlet?Service=NewsDetail&Nid=${news.newsId}">
                                        <img class="card-img-top"
                                             src="${IConstant.PATH_NEWS}/${news.imagePath}"
                                             alt="Card image cap">
                                        <div class="card-body h-100">
                                            <h4 class="card-title"><a
                                                    class="text-black"
                                                    href="NewsServlet?Service=NewsDetail&Nid=${news.newsId}">
                                                    ${news.newsTitle}
                                                </a></h4>
                                            <div class="mt-4">
                                                <a href="#"
                                                   class="btn btn-primary bg-weak text-black border-0">${news.newsGroupName}</a>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    $(document).ready(function () {
        $('.review-close_btn').on('click', function () {
            document.querySelector('.box-review').classList.remove('active-review');
        });
        let newsDes = document.querySelector('.news_description');
        let listImages = newsDes.getElementsByTagName('img');

        let boxReviewSlide = document.querySelector('.box-review .swiper-wrapper');

        for (var i = 0; i < listImages.length; i++) {
            let currImg = listImages[i];
            currImg.addEventListener('click', () => {
                activeView(currImg.src);
            });
        }
        function activeView(imgPath) {
            let html = ``;
            for (var i = 0; i < listImages.length; i++) {
                let currImg = listImages[i];
                let isActive = (imgPath === currImg.src) ? 'swiper-slide-active' : '';
                html += `<div class="swiper-slide ` + isActive + `h-100">
<div class="slider-img reivew-item text-center h-100">
<img src="` + currImg.src + `"
alt="" style="width: 80%; height: 100%;">
<div class="review-info text-start py-4" style="">
<span class="fs-3 ms-3 text-white">` + currImg.getAttribute('alt') + `</span>
</div>
</div>
</div>`;
            }
            boxReviewSlide.innerHTML = html;
            document.querySelector('.box-review').classList.add('active-review');
        }
    });
</script>
<script
src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
    var swiper = new Swiper(".mySwiper", {
        spaceBetween: 30,
        centeredSlides: true,
        loop: true,
        speed: 1000,

        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
    });
</script>
</body>

</html>