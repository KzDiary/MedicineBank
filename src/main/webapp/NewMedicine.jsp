<%-- 
    Document   : NewMedicine
    Created on : 3 Jul 2024, 20:28:00
    Author     : Kz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Thuốc</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
                       .topnav {
                background-color: #343a40;
                overflow: hidden;
                display: flex;
                justify-content: space-between;
                padding: 10px;
                height: 50px;
            }
            .topnav a {
                color: #ffffff;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }

            .btn-custom {
                margin-left: 10px;
            }
            .medicine-details {
                display: flex;
                flex-wrap: wrap;
                margin: 20px;
            }
            .medicine-image {
                flex: 1 1 30%;
                text-align: center;
            }
            .medicine-image img {
                max-width: 100%;
                height: auto;
            }
            .medicine-info {
                flex: 1 1 70%;
                padding: 20px;
            }
            .medicine-info h2 {
                margin-top: 0;
            }
            .medicine-info table {
                width: 100%;
                border-collapse: collapse;
            }
            .medicine-info table th, .medicine-info table td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }
            .medicine-info table th {
                text-align: left;
                font-weight: bold;
                width: 30%;
            }
            .btn-custom {
                margin-left: 10px;
            }
            .dropdown-menu {
                min-width: 0;
            }
        </style>
    </head>       
    <jsp:include page="Header.jsp" />

    <body id="container" style="margin-top: 100px">
       <div class="container" >
            <form id="medicine-form" action="newMed" method="post">
                <div class="medicine-details mt-4">
                    <div class="medicine-info" style="text-align: center">
                        <h2 class="mb-4 text-dark" >Thông Tin Thuốc Mới</h2>
                        <table>
                            <tr>
                                <th>Số Đăng Ký</th>
                                <td><input name="regNumber" type="text" class="form-control"></td>
                            </tr>
                            <tr>
                                <th>Tên Thuốc</th>
                                <td><input name="medName" type="text" class="form-control"></td>
                            </tr>
                            <tr>
                                <th>URL Ảnh</th>
                                <td><input name="imgURL" id="imgURL" type="url" class="form-control"></td>
                            </tr>
                            <tr>
                                <th>Hoạt chất</th>
                                <td>
                                    <div class="input">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">Thành phần</th>
                                                    <th style="text-align: center">Liều lượng</th>
                                                </tr>
                                            </thead>
                                            <tbody id="ingredient-rows">
                                                <tr>
                                                    <td style="border-bottom: none">
                                                        <select name="ingreName" class="form-select">
                                                            <c:forEach var="i" items="${listIngre}">
                                                                <option value="${i.getName()}">${i.getName()}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </td>
                                                    <td style="border-bottom: none">
                                                        <input name="dosageAmount" type="text" class="form-control" required>
                                                    </td>
                                                    <td style="border-bottom: none; width: 1%;">
                                                        <button class="btn btn-outline-secondary delete-btn" type="button">Xóa</button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tr>
                                                <td colspan="3" style="text-align: center; border-bottom: none">
                                                    <button type="button" class="btn btn-sm btn-success mt-2" id="add-ingredient-btn">Thêm Hoạt chất</button>
                                                    <button type="button" class="btn btn-sm btn-success mt-2" data-bs-toggle="modal" data-bs-target="#newIngreModal">Thêm Mới</button>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>Thuốc kê đơn:</th>
                                <td>
                                    <div class="form-check form-check-inline">
                                        <input name="Rx" class="form-check-input" type="radio" id="Rx_yes" value="true" required>
                                        <label class="form-check-label" for="Rx_yes">Yes</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input name="Rx" class="form-check-input" type="radio" id="Rx_No" value="false" required>
                                        <label class="form-check-label" for="Rx_No">No</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>Dạng Bào Chế</th>
                                <td><input name="dosageForm" type="text" class="form-control" required></td>
                            </tr>
                            <tr>
                                <th>Hạn Sử Dụng</th>
                                <td><input name="EXPDate" type="text" class="form-control" required></td>
                            </tr>
                            <tr>
                                <th>Công ty Sản Xuất</th>
                                <td>
                                    <div class="input-group">
                                        <select name="GCN" class="form-select">
                                            <c:forEach var="c" items="${listCSKD}">
                                                <option value="${c.getGCN()}">${c.getName()}</option>
                                            </c:forEach>
                                        </select>
                                        <a href="getCSKD" class="btn btn-outline-secondary">Thêm Mới</a>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <button class="btn btn-sm btn-success save-btn mt-4" type="submit" style="width: 80px;">Lưu</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Modal for new ingredient -->
        <div class="modal fade" id="newIngreModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="newIngreForm" action="newIngre" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="newIngreModalLabel">Thêm Hoạt Chất Mới</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="ingreName" class="form-label">Tên Hoạt Chất</label>
                                <input type="text" class="form-control" id="ingreName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="ingreFormula" class="form-label">Công Thức Hóa Học</label>
                                <input type="text" class="form-control" id="ingreFormula" name="formula" required>
                            </div>
                            <div class="mb-3">
                                <label for="ingreDescription" class="form-label">Chú Thích</label>
                                <textarea class="form-control" id="ingreDescription" name="description" rows="3" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            <c:if test="${not empty requestScope.error}">
            var body = document.getElementById("container");
            body.onload = alert('${requestScope.error}');
            </c:if>
            document.getElementById('add-ingredient-btn').addEventListener('click', function () {
                var newRow = document.createElement('tr');
                newRow.innerHTML = `
                <td style="border-bottom: none">
                    <select name="ingreName" class="form-select">
            <c:forEach var="i" items="${listIngre}">
                            <option value="${i.getName()}">${i.getName()}</option>
            </c:forEach>
                    </select>
                </td>
                <td style="border-bottom: none">
                    <input name="dosageAmount" type="text" class="form-control" required>
                </td>
                <td style="border-bottom: none; width: 1%;">
                    <button class="btn btn-outline-secondary delete-btn" type="button">Xóa</button>
                </td>
            `;
                document.getElementById('ingredient-rows').appendChild(newRow);
                addDeleteEvent(newRow.querySelector('.delete-btn'));
            });

            function addDeleteEvent(button) {
                button.addEventListener('click', function () {
                    var row = button.closest('tr');
                    row.remove();
                });
            }

            document.querySelectorAll('.delete-btn').forEach(function (button) {
                addDeleteEvent(button);
            });

            document.querySelector('.save-btn').addEventListener('click', function (event) {
                if (hasDuplicateIngreNames()) {
                    event.preventDefault();
                    alert('Vui lòng điền hết các trường và chắc chắn Thành Phần thuốc không được lặp lại');
                }
            });

            function hasDuplicateIngreNames() {
                var ingreNames = document.querySelectorAll('select[name="ingreName"]');
                var values = [];
                for (var i = 0; i < ingreNames.length; i++) {
                    if (values.includes(ingreNames[i].value)) {
                        return true;
                    }
                    values.push(ingreNames[i].value);
                }
                return false;
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
