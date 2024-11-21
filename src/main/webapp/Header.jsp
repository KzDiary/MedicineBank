<%-- 
    Document   : NewHeader
    Created on : 5 Jul 2024, 19:11:32
    Author     : Kz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <link href="main.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/d39499d76a.js" crossorigin="anonymous"></script>

    </head>

    <body class="index-page">

        <header id="header" class="header d-flex align-items-center fixed-top" style="background-color: black !important; height: 70px">
            <div class="container-fluid container-xl position-relative d-flex align-items-center">

                <a href="MainPage.jsp" class="logo d-flex align-items-center me-auto">
                    <h1 class="sitename">MedicalBank</h1>
                </a>

                <nav id="navmenu" class="navmenu">
                    <ul>
                        <li><a class="${pageContext.request.requestURI.contains('/MainPage.jsp') ? 'active' : ''}" href="MainPage.jsp">Trang chủ<br></a></li>
                        <li><a class="${pageContext.request.requestURI.contains('/DrugList.jsp') ? 'active' : ''}" href="getMedicine">Danh mục Thuốc</a></li>
                        <li><a class="${pageContext.request.requestURI.contains('/CSKD.jsp') ? 'active' : ''}" href="getCSKD">CSKD Dược Phẩm</a></li>
                        <li><a href="getIngre">DS Hoạt chất</a></li>
                        <c:if test="${sessionScope.role == 'Doctor'}">
                            <li><a href="showPres">Quản Lý Đơn Thuốc</a></li>
                        </c:if>
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                <li class="dropdown "><a href="#"><span>Tài Khoản</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                                    <ul>
                                        <li><a href="Login.jsp">Đăng Nhập</a></li>
                                        <li><a href="Register.jsp">Đăng ký</a></li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="dropdown "><a href="#" ><span>Tài Khoản</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                                    <ul>
                                        <li><a class="${pageContext.request.requestURI.contains('/AccountDetails.jsp') ? 'active' : ''}" href="AccountDetails.jsp">Thông tin Tài Khoản</a></li>
                                        <li><a href="logout">Đăng Xuất</a></li>
                                    </ul>
                                </li>
                            </c:otherwise>
                        </c:choose>

                    </ul>
                    <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                </nav>

                        <a class="btn-getstarted" href="get-a-quote.html">Liên hệ</a>
            </div>
        </header>
        <div id="preloader"></div>
        <script src="main.js"></script>

    </body>

</html>
