<%-- 
    Document   : AccountDetails
    Created on : 2 Jul 2024, 23:15:30
    Author     : Kz
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .account-details {
                border: 1px solid #ddd;
                padding: 20px;
                border-radius: 8px;
                background-color: #f9f9f9;
            }

            .btn-group {
                margin-top: 20px;
            }
        </style>
    </head>
    <jsp:include page="Header.jsp" />
    <body>
        <div id="account-details" class="container account-details " style="margin-top: 100px">
            <h2 class="text-dark">Thông tin Tài Khoản</h2>
            <form id="accountForm" action="updateAccount" method="post">
                <div class="mb-3">
                    <label for="uuid" class="form-label">UUID:</label>
                    <input type="text" class="form-control" id="uuid" name="uuid" value="${sessionScope.user.getUUID()}" readonly>
                </div>
                <div class="mb-3">
                    <label for="username" class="form-label">Tên người dùng:</label>
                    <input type="text" class="form-control" id="username" name="username" value="${sessionScope.user.getUsername()}" readonly>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.getEmail()}" readonly>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại:</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.user.getPhone()}" readonly>
                </div>
                <div class="mb-3">
                    <label for="roleid" class="form-label">Vai Trò:</label>
                    <input type="text" class="form-control" value="${sessionScope.role}" disabled>
                </div>
                <div class="btn-group d-flex" style="width: 100%">
                    <div class="p-2">
                        <button type="button" class="btn btn-dark" id="editBtn" onclick="enableEditing()" style="width: 80px"><i class="fa-solid fa-pen-to-square"></i></button>
                        <button type="submit" class="btn btn-success" id="submitBtn" style="display:none; margin-right: 3px">Submit</button>
                        <button type="button" class="btn btn-secondary" id="cancelBtn" style="display:none;" onclick="window.location.reload();">Cancel</button>
                        <c:if test="${not empty requestScope.alarm}">
                            <span class="text-dark" style="margin-left:10px">${requestScope.alarm}</span>
                        </c:if>
                    </div>

                    <div class="ml-auto p-2" style="margin-left: auto">
                        <a href="MainPage.jsp" class="btn btn-dark"><i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</a>
                    </div>
                </div>

            </form>
        </div>

        <script>
            function enableEditing() {
                document.querySelectorAll('#accountForm input').forEach(input => {
                    if (input.id !== 'uuid') {
                        input.removeAttribute('readonly');
                    }
                });
                document.getElementById('editBtn').style.display = 'none';
                document.getElementById('submitBtn').style.display = 'inline-block';
                document.getElementById('cancelBtn').style.display = 'inline-block';
            }
        </script>
    </body>
</html>
