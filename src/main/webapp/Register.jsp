<%-- 
    Document   : CreateAccount
    Created on : 12 Jun 2024, 08:00:00
    Author     : Khanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Admin Account</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f2f2f2;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .create-account-form {
                background: white;
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
            }
            .create-account-form h3 {
                margin-bottom: 1.5rem;
                color: #333;
                text-align: center;
            }
            .create-account-form .form-control {
                margin-bottom: 1rem;
            }
            .create-account-form .btn-secondary {
                width: 100%;
            }
            .create-account-form .return-link {
                text-align: center;
                margin-top: 1rem;
            }
            .create-account-form .alert {
                margin-top: 1rem;
                text-align: center;
            }
            p{
                margin-bottom: 7px;
            }
        </style>
    </head>
    <body>
        <form class="create-account-form" name="createAccountForm" method="post" action="newAccount">
            <h3>Đăng ký Tài Khoản</h3>
            <div class="mb-3">
                <p>Tên tài khoản:</p>
                <input type="text" class="form-control" name="username" placeholder="Username" required>
            </div>
            <div class="mb-3">
                <p>Mật khẩu:</p>
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            <div class="mb-3">
                <p>Email:</p>
                <input type="email" class="form-control" name="email" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <p>Số điện thoại:</p>
                <input type="number" class="form-control" name="phone" placeholder="Phone" required>
            </div>
            <div class="mb-3">
                <p>Đối tượng người dùng:</p>
                <div class="form-check">
                    <input class="form-check-input" type="radio" id="student" name="role" value="3" required>
                    <label class="form-check-label" for="student">Sinh viên Y Dược</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" id="doctor" name="role" value="2" required>
                    <label class="form-check-label" for="doctor">Chuyên viên y tế, Bác sĩ</label>
                </div>
            </div>

            <div>
                <input type="submit" class="btn btn-secondary" value="Create Account">
            </div>
            <div class="return-link">
                <a href="MainPage.jsp" class="text-decoration-none text-dark">Return</a>
            </div>
        </form>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
