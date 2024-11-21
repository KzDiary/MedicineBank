<%-- 
    Document   : MainPage
    Created on : 30 Jun 2024, 17:13:19
    Author     : Kz
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .search-container {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            .search-container input[type="text"] {
                width: 500px;
                padding: 10px;
                border: 1px solid #ddd;
            }
            .search-container button {
                padding: 15px;
                border: none;
                color: white;
            }
            
        </style>
    </head>
    <body>
        <jsp:include page="Header.jsp" />
        <div class="container" style="margin-top:200px">
            <h1 class="text-center text-dark">Medicine Bank</h1>
            <div class="search-container">
            <form action="searchMed" method="post" class="form-search d-flex align-items-stretch mb-3" data-aos="fade-up" data-aos-delay="200">
              <input name="search" type="text" class="form-control" placeholder="Nhập tên thuốc để tìm kiếm">
              <button type="submit" class="btn btn-dark " style="  border-radius: 5px 100px 100px 5px;"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>
            </div>
        </div>
        <jsp:include page="Footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
    </body>
</html>
