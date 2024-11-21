<%-- 
    Document   : CompanyDetails
    Created on : 2 Jul 2024, 14:16:15
    Author     : Kz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Chi Tiết CSKD</title>
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

            .company-details {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .company-image {
                width: 30%;
                text-align: center;
            }
            .company-image img {
                max-width: 100%;
                height: auto;
            }
            .company-info {
                width: 70%;
                padding-left: 20px;
            }
            .company-info h2 {
                margin-top: 0;
            }
            .company-info table {
                width: 100%;
                border-collapse: collapse;
            }
            .company-info table th, .company-info table td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }
            .company-info table th {
                text-align: left;
                font-weight: bold;
                width: 30%;
            }
        </style>
    </head>
    <jsp:include page="Header.jsp" />

    <body>
        <div class="company-details" style="margin-top:auto">
            <div class="company-image">
                <img src="${company.getImgURL()}" alt="Company Image">
            </div>
            <div class="company-info">
                <h2 class="text-dark my-4">${company.getName()}</h2>
                <table>
                    <tr>
                        <th>Số Đăng Ký</th>
                        <td>${company.getGCN()}</td>
                    </tr>
                    <tr>
                        <th>Địa chỉ </th>
                        <td>${company.getAddress()}</td>
                    </tr>
                    <tr>
                        <th>Điện thoại</th>
                        <td>${company.getPhone()}</td>
                    </tr>
                </table>
                <div class="d-flex" style="width: 100%">
                    <div style="margin-right: auto">
                        <a href="getCSKD" class="btn btn-dark mt-4"><i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</a>
                    </div>
                    <div class="mx-3" style="margin-left: auto">
                        <a href="getMedOfCompany?GCN=${company.getGCN()}&name=${company.getName()}&address=${company.getAddress()}&phone=${company.getPhone()}" class="btn btn-primary mt-4"><i class="fa-solid fa-pills"></i> &nbsp;Thuốc do Doanh Nghiệp SX &nbsp;<i style="font-size: 15px" class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </div> 
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="Footer.jsp" />
    </body>
</html>
