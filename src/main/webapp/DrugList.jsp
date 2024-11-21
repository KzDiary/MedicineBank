<%-- 
    Document   : DrugList
    Created on : 2 Jul 2024, 00:03:14
    Author     : Kz
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Danh Sách Thuốc</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>

            .custom-table-container {
                max-width: 1200px;
                margin: auto;
                margin-top: 50px;
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .button-group {
                text-align: end;
                margin-top: 20px;
            }
        </style>
    </head>
    <jsp:include page="Header.jsp" />
    <body>
        <div class="container custom-table-container" style="margin-top:120px">
            <h2 class="mb-4 text-center text-dark">Danh mục thuốc </h2>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">Số Đăng Ký</th>
                            <th scope="col">Tên Thuốc</th>
                            <th scope="col">Hoạt chất</th>
                            <th scope="col">Công ty Sản Xuất</th>
                            <th scope="col">Chi tiết</th>
                                <c:if test="${sessionScope.role == 'Admin'}">
                                <th scope="col">&nbsp;Xóa</th>
                                </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="med" items="${listMedicine}">
                            <tr>
                                <td>${med.getRegNumber()}</td>
                                <td>${med.getName()}</td>
                                <td>
                                    <c:forEach var="type" items="${med.getIngredents()}">
                                        ${type.key} - ${type.value}<br/> 
                                    </c:forEach>
                                </td>
                                <td>${med.getCompany().getName()}</td>
                                <td><a href="medDetails?regNumber=${med.getRegNumber()}" class="btn btn-sm btn-dark" style="width: 100%">Xem</a></td>
                                <c:if test="${sessionScope.role == 'Admin'}">
                                    <td>
                                        <a href="#" class="btn btn-sm btn-danger delete-btn" style="width: 100%;"
                                           data-regnumber="${med.getRegNumber()}" 
                                           data-bs-toggle="modal" 
                                           data-bs-target="#confirmationModal">    <i class="fas fa-times"></i>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="button-group mb-4" >
                <c:if test="${sessionScope.role == 'Admin'}">
                    <form action="newMed" method="get" class="d-inline">
                        <button type="submit" class="btn btn-dark" style="width: 6%"><i class="fa-solid fa-plus"></i></button>
                    </form>                 
                </c:if>
                <form action="MainPage.jsp" method="get" class="d-inline">
                    <button type="submit" class="btn btn-dark"> <i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</button>
                </form>
            </div>
        </div>

        <!-- Confirmation Modal -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel">Xác nhận xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <a id="deleteLink" href="#" class="btn btn-primary">Xóa</a>
                    </div>
                </div>
            </div>

        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var deleteButtons = document.querySelectorAll('.delete-btn');
                var deleteLink = document.getElementById('deleteLink');

                deleteButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var regNumber = button.getAttribute('data-regnumber');
                        var deleteUrl = "medDelete?regNumber=" + regNumber;
                        deleteLink.setAttribute('href', deleteUrl);
                    });
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
        <jsp:include page="Footer.jsp" />

    </body>
</html>
