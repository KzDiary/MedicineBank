<%-- 
Document   : MainPage
Created on : 19 Jun 2024, 14:04:39
Author     : Kz
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>CSKD</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
    <body id="container" style="margin-top:70px; height: 100%">
        <div class="container custom-table-container">
            <h2 class="mb-4 text-center text-dark" accesskey="">Doanh nghiệp Sản Xuất</h2>
            <div class="table-responsive" >
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">Số GCN ĐKKD</th>
                            <th scope="col">Tên Công Ty</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Chi tiết</th>
                                <c:if test="${sessionScope.role == 'Admin'}">
                                <th scope="col">Chỉnh sửa</th>         
                                </c:if>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="d" items="${listCSKD}">
                            <tr>
                                <td>${d.getGCN()}</td>
                                <td>${d.getName()}</td>
                                <td>${d.getAddress()}</td>
                                <td style="width: 85px"><a href="companyDetails?GCN=${d.getGCN()}" class="btn btn-sm btn-dark" style="width: 100%">Chi tiết</a></td>
                                <c:if test="${sessionScope.role == 'Admin'}">
                                    <td style="width: 100px">
                                        <button style="width: 47%" class="btn btn-sm btn-dark edit-btn" data-bs-toggle="modal" data-bs-target="#editModal"
                                                data-imgURL="${d.getImgURL()}"
                                                data-gcn="${d.getGCN()}" 
                                                data-name="${d.getName()}" 
                                                data-address="${d.getAddress()}" 
                                                data-phone="${d.getPhone()}"><i class="fa-solid fa-pen-to-square"></i></button>
                                        <a style="width:47%; margin-top: 3px" href="#" class="btn btn-sm btn-danger delete-btn"
                                           data-GCN="${d.getGCN()}" 
                                           data-bs-toggle="modal" 
                                           data-bs-target="#confirmationModal"><i class="fas fa-times"></i></a>
                                    </td>
                                </c:if>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="button-group">
                <c:if test="${sessionScope.role == 'Admin'}">
                    <button style="width: 6%" type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#addModal"><i class="fa-solid fa-plus"></i></button>
                </c:if>
                <form action="MainPage.jsp" method="get" class="d-inline">
                    <button type="submit" class="btn btn-dark"><i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</button>
                </form>
            </div>
        </div>

        <!-- Add Modal -->
        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Thêm Công Ty Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="newCompany" method="post">
                            <div class="mb-3">
                                <label for="new-gcn" class="form-label">Số GCN ĐKKD</label>
                                <input type="text" class="form-control" id="new-gcn" name="GCN" required>
                            </div>
                            <div class="mb-3">
                                <label for="new-name" class="form-label">Tên Công Ty</label>
                                <input type="text" class="form-control" id="new-name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="new-address" class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" id="new-address" name="address" required>
                            </div>
                            <div class="mb-3">
                                <label for="new-address" class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" id="new-address" name="phone" required>
                            </div>
                            <div class="mb-3">
                                <label for="new-address" class="form-label">Link Ảnh</label>
                                <input type="text" class="form-control" name="imgURL" required>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <form id="" action="updateCompany" method="post">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editModalLabel">Chỉnh sửa công ty</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="gcn" class="form-label">Số GCN ĐKKD</label>
                                <input name="gcn" type="text" class="form-control" id="gcn" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="name" class="form-label">Tên Công Ty</label>
                                <input name="name" type="text" class="form-control" id="name">
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <input name="address" type="text" class="form-control" id="address">
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input name="phone" type="text" class="form-control" id="phone">
                            </div>
                            <div class="mb-3">
                                <label for="imgURL" class="form-label">Link Ảnh</label>
                                <input name="imgURL" type="text" class="form-control" id="imgURL"  required>
                            </div>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </div>
                </div>
            </form>

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
                        <b>Xóa Công ty sẽ đồng thời xóa tất cả các loại dược phẩm<br/> thuộc sở hữu của công ty này.<br/></b>
                        <br/><span class="text-danger"><i><b>Bạn có chắc chắn muốn xóa?</b></i></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <a id="deleteLink" href="#" class="btn btn-danger">Xóa</a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            <c:if test="${not empty requestScope.alarm}">
            var body = document.getElementById("container");
            body.onload = alert('${requestScope.alarm}');
            <%request.removeAttribute("alarm");%>
            </c:if>
            document.addEventListener('DOMContentLoaded', function () {
                var editButtons = document.querySelectorAll('.edit-btn');
                var editForm = document.getElementById('editForm');

                editButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var gcn = button.getAttribute('data-gcn');
                        var name = button.getAttribute('data-name');
                        var address = button.getAttribute('data-address');
                        var imgURL = button.getAttribute('data-imgURL');
                        var phone = button.getAttribute('data-phone');

                        document.getElementById('gcn').value = gcn;
                        document.getElementById('name').value = name;
                        document.getElementById('address').value = address;
                        document.getElementById('imgURL').value = imgURL;
                        document.getElementById('phone').value = phone;
                    });
                });

                editForm.addEventListener('submit', function (event) {
                    event.preventDefault();
                });
            });

            document.addEventListener('DOMContentLoaded', function () {
                var deleteButtons = document.querySelectorAll('.delete-btn');
                var deleteLink = document.getElementById('deleteLink');

                deleteButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var GCN = button.getAttribute('data-GCN');
                        var deleteUrl = "companyDelete?GCN=" + GCN;
                        deleteLink.setAttribute('href', deleteUrl);
                    });
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
        <jsp:include page="Footer.jsp" />
    </body>
</html>
