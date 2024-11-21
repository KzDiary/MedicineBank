<%-- 
    Document   : Login
    Created on : 11 Jun 2024, 07:36:12
    Author     : Khanh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f2f2f2;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .login-form {
                background: white;
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
            }
            .login-form h3 {
                margin-bottom: 1.5rem;
                color: #333;
                text-align: center;
            }
            .login-form .form-control {
                margin-bottom: 1rem;
            }
            .login-form .btn-secondary {
                width: 100%;
            }
            .login-form .link-group {
                text-align: center;
                margin-top: 1rem;
            }
            .login-form .alert {
                margin-top: 1rem;
                text-align: center;
            }
            p{
                margin-bottom: 7px;
            }
        </style>
    </head>
    <body>
        <form class="login-form" name="loginForm" method="post" action="login">
            <h3>Login Form</h3>
            <div class="mb-3">
                <p>Tên tài khoản:</p>
                <input type="text" class="form-control" name="username" placeholder="Username" required>
            </div>
            <div class="mb-3">
                <p>Mật khẩu:</p>
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            <div>
                <input type="submit" class="btn btn-secondary" value="Login">
            </div>
            <div class="link-group">
                <a href="Register.jsp" class="text-decoration-none d-block mt-2 text-dark">Create Account</a>
                <a href="MainPage.jsp" class="btn btn-dark mt-4">Quay lại</a>
            </div>
            <c:if test="${error!=null}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
        </form>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
