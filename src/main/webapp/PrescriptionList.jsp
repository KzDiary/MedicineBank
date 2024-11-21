<%-- 
    Document   : Prescription
    Created on : 8 Jul 2024, 02:07:39
    Author     : Kz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                max-width: 1000px;
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
            <h2 class="mb-4 text-center text-dark">Quản lý Đơn Thuốc</h2>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col"><b>Mã Đơn</b></th>
                            <th scope="col">Tên Bệnh Nhân</th>
                            <th scope="col">Tuổi</th>
                            <th scope="col">Chiều Cao</th>
                            <th scope="col">Cân nặng</th>
                            <th scope="col">Tên Bác Sĩ</th>
                            <th scope="col">Ngày Tạo</th>
                            <th scope="col">Chi tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pres" items="${listPrescription}">
                            <tr>
                                <td style="font-size: 18px"><b>${pres.getID()}</b></td> <!-- Mã đơn thuốc -->
                                <td>${pres.getPatientName()}</td>    
                                <td>${pres.getAge()}</td>
                                <td>${pres.getHeight()}</td>     
                                <td>${pres.getWeight()}</td>     
                                <td>${pres.getDoctorName()}</td>      <!-- Tên Bác sĩ -->
                                <td>${pres.getCreateDate()}</td>                <!-- Ngày Tạo đơn -->
                                <td><a href="presDetails?ID=${pres.getID()}" class="btn btn-sm btn-dark" style="width:45%">Xem</a>
                                    <a href="#" class="btn btn-sm btn-danger delete-btn" style="width: 45%;"
                                       data-ID="${pres.getID()}"  
                                       data-bs-toggle="modal" 
                                       data-bs-target="#confirmationModal">  <!-- Đổi thông tin truyền vào Xóa -->  <i class="fas fa-times"></i>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="button-group mb-4" >
                <form action="newPres" method="get" class="d-inline">
                    <button type="submit" class="btn btn-dark" style="width: 6%"><i class="fa-solid fa-plus"></i></button> <!-- Thêm mới Đơn thuốc --> 
                </form>                 
                <form action="MainPage.jsp" method="get" class="d-inline">
                    <button type="submit" class="btn btn-dark"> <i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</button>
                </form>
            </div>
        </div>

        <!-- Confirmation Modal -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" aria-hidden="true">
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
                        var ID = button.getAttribute('data-ID');
                        var deleteUrl = "presDelete?ID=" + ID;
                        deleteLink.setAttribute('href', deleteUrl);
                    });
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
        <jsp:include page="Footer.jsp" />

    </body>
</html>
