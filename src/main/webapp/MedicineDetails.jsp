<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .medicine-details {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .medicine-image {
                width: 30%;
                text-align: center;
            }
            .medicine-image img {
                max-width: 100%;
                height: auto;
            }
            .medicine-info {
                width: 70%;
                padding-left: 20px;
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

            .hidden {
                display: none;
            }
        </style>
    </head>
    <jsp:include page="Header.jsp" />
    <body id="container" style="margin-top: 70px">

        <form id="medicine-form" action="updMed" method="post">

            <div class="medicine-details mt-4">
                <div class="medicine-image">
                    <img src="${med.getImgURL()}" alt="Medicine Image">
                    <label class="form-check-label hidden input" for="imgURL"><b><i>Link Ảnh</i></b></label>
                    <input name="imgURL" id="imgURL" type="url" class="form-control hidden input" value="${med.getImgURL()}">
                </div>
                <div class="medicine-info">
                    <h2>${med.getName()}</h2>
                    <input name="medName" class="hidden" value="${med.getName()}">
                    <table>
                        <tr>
                            <th>Số Đăng Ký</th>
                            <td>
                                <span class="text">${med.getRegNumber()}</span>
                                <input name="regNumber" type="text" class="form-control hidden input" value="${med.getRegNumber()}" readonly>
                            </td>
                        </tr>
                        <tr>
                            <th>Hoạt chất</th>
                            <td>
                                <span class="text">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th style="text-align: center">Thành phần</th>
                                                <th style="text-align: center">Liều lượng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="type" items="${med.getIngredents()}">
                                                <tr>
                                                    <td style="border-bottom: none">${type.key}</td>
                                                    <td style="border-bottom: none">${type.value}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </span>
                                <div class="hidden input">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th style="text-align: center">Thành phần</th>
                                                <th style="text-align: center">Liều lượng</th>
                                            </tr>
                                        </thead>
                                        <tbody id="ingredient-rows">
                                            <c:forEach var="type" items="${med.getIngredents()}">
                                                <tr>
                                                    <td style="border-bottom: none">
                                                        <select name="ingreName" class="form-select" id="ingreName">
                                                            <option value="${type.key}" selected>${type.key}</option>
                                                            <c:forEach var="i" items="${listIngre}">
                                                                <c:if test="${!type.key.equals(i.getName())}">
                                                                    <option value="${i.getName()}">${i.getName()}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </td>
                                                    <td style="border-bottom: none">
                                                        <input name="dosageAmount" type="text" class="form-control" value="${type.value}" >
                                                    </td>
                                                    <td style="border-bottom: none;width: 1%;">
                                                        <button class="btn btn-outline-secondary delete-btn" type="button">Xóa</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tr>
                                            <td style="border-bottom: none">
                                                <div style="text-align: center">
                                                    <button type="button" class="btn btn-sm btn-secondary mt-2" id="add-ingredient-btn">Thêm Hoạt chất</button>
                                                    <button type="button" class="btn btn-sm btn-success mt-2" data-bs-toggle="modal" data-bs-target="#newIngreModal">Thêm Mới</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>Thuốc kê đơn:</th>
                            <td>
                                <span class="text">${med.isRx() ? "Có" : "Không"}</span>
                                <input name="Rx" class="form-check-input hidden input" type="radio" id="Rx_yes" value="true"  ${med.isRx() ? "checked" : ""}>
                                <label class="form-check-label hidden input" for="Rx_yes">Yes</label>
                                <input name="Rx" class="form-check-input hidden input" type="radio" id="Rx_No" value="false"   ${!med.isRx() ? "checked" : ""}>
                                <label class="form-check-label hidden input" for="Rx_No">No</label>
                            </td>
                        </tr>
                        <tr>
                            <th>Dạng Bào Chế</th>
                            <td>
                                <span class="text">${med.getDosageForm()}</span>
                                <input name="dosageForm" type="text" class="form-control hidden input" value="${med.getDosageForm()}" >
                            </td>
                        </tr>
                        <tr>
                            <th>Hạn Sử Dụng:</th>
                            <td>
                                <span class="text">${med.getEXPDate()}</span>
                                <input name="EXPDate" type="text" class="form-control hidden input" value="${med.getEXPDate()}">
                            </td>
                        </tr>
                        <tr>
                            <th>Công ty Sản Xuất</th>
                            <td>
                                <span class="text">${med.getCompany().getName()}<br/><i>${med.getCompany().getAddress()}</i></span>
                                <div class="input-group hidden input">
                                    <select name="GCN" class="form-select" id="company-gcn">
                                        <option value="${med.getCompany().getGCN()}" selected>${med.getCompany().getName()}</option>
                                        <c:forEach var="c" items="${listCSKD}">
                                            <c:if test="${!med.getCompany().getName().equals(c.getName())}">
                                                <option value="${c.getGCN()}">${c.getName()}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <a href="getCSKD" class="btn btn-outline-secondary">Thêm Mới</a>
                                </div> 
                            </td>
                        </tr>
                    </table>


                    <div class="btn-group d-flex" style="width: 100%">
                        <div class="p-2">
                            <c:if test="${sessionScope.user.getRoleid() == 1}">
                                <button class="btn btn-dark edit-btn mt-4" style="width: 80px;"><i style="font-size: 20px" class="fa-solid fa-pen-to-square"></i></button>
                                <button class="btn btn-success save-btn mt-4 hidden input" style="width: 80px;"><i class="fa-regular fa-floppy-disk"></i></button>
                                <button class="btn btn-dark cancel-btn mt-4 hidden input" style="width: 80px;">Hủy</button>
                            </c:if>
                        </div>
                        <div class="ml-auto p-2" style="margin-left: auto">
                            <a href="getMedicine" class="btn btn-dark mt-4"><i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Modal for new ingredient -->
        <div class="modal fade" id="newIngreModal" tabindex="-1" aria-labelledby="newIngreModalLabel" aria-hidden="true">
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
            document.querySelector('.edit-btn').addEventListener('click', function () {
                document.querySelectorAll('.text').forEach(function (element) {
                    element.classList.toggle('hidden');
                });
                document.querySelectorAll('.input').forEach(function (element) {
                    element.classList.toggle('hidden');
                });
                document.querySelector('.edit-btn').classList.add('hidden');
                document.querySelector('.save-btn').classList.remove('hidden');
                document.querySelector('.cancel-btn').classList.remove('hidden');
                document.getElementById('medicine-form').addEventListener('submit', function (event) {
                    event.preventDefault();
                });
            });

            document.querySelector('.cancel-btn').addEventListener('click', function () {
                document.querySelectorAll('.text').forEach(function (element) {
                    element.classList.toggle('hidden');
                });
                document.querySelectorAll('.input').forEach(function (element) {
                    element.classList.toggle('hidden');
                });
                document.querySelector('.edit-btn').classList.remove('hidden');
                document.querySelector('.save-btn').classList.add('hidden');
                document.querySelector('.cancel-btn').classList.add('hidden');

                document.getElementById('medicine-form').removeEventListener('submit', function (event) {
                    event.preventDefault();
                });
            });

            document.querySelector('.save-btn').addEventListener('click', function () {
                if (!hasDuplicateIngreNames()) {
                    document.getElementById('medicine-form').submit();
                } else {
                    alert('Vui lòng điền hết các trường và chắc chắn Thành Phần thuốc không được lặp lại');
                }
            });

            // Function to validate the form
            function validateForm() {
                var isValid = true;
                // Loop through all required inputs and check if they are empty
                document.querySelectorAll('input[required]').forEach(function (input) {
                    if (input.value.trim() === '') {
                        isValid = false;
                    }
                });
                // Add additional checks for select elements or other required fields as needed

                return isValid;
            }

            // Function to check for duplicate ingredient names
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


            document.getElementById('add-ingredient-btn').addEventListener('click', function () {
                var newRow = document.createElement('tr');
                newRow.innerHTML = `
                    <td style="border-bottom: none">
                        <select name="ingreName" class="form-select" id="ingreName">
            <c:forEach var="i" items="${listIngre}">
                                <option value="${i.getName()}">${i.getName()}</option>
            </c:forEach>
                        </select>
                    </td>
                    <td style="border-bottom: none">
                        <input name="dosageAmount" type="text" class="form-control" required>
                    </td>
                    <td style="border-bottom: none;width: 1%;">
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
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    <jsp:include page="Footer.jsp" />
</html>
