<%-- 
    Document   : NewPrescription
    Created on : 13 Jul 2024, 22:11:12
    Author     : Kz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body{
                padding: 100px 0;
                background: #ecf0f4;
                width: 100%;
                height: 100%;
                font-size: 18px;
                line-height: 1.5;
                font-family: 'Roboto', sans-serif;
                color: #222;
            }
            .container{
                max-width: 1230px;
                width: 100%;
            }

            h1{
                font-weight: 700;
                font-size: 45px;
                font-family: 'Roboto';
            }

            .header{
                background-color: white !important;
                margin-bottom: 80px;
            }
            #description{
                font-size: 24px;
            }

            .form-wrap{
                background: rgba(255,255,255,1);
                width: 100%;
                max-width: 850px;
                padding: 50px;
                margin: 0 auto;
                position: relative;
                -webkit-border-radius: 10px;
                -moz-border-radius: 10px;
                border-radius: 10px;
                -webkit-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
                -moz-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
                box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
            }
            .form-wrap:before{
                content: "";
                width: 90%;
                height: calc(100% + 60px);
                left: 0;
                right: 0;
                margin: 0 auto;
                position: absolute;
                top: -30px;
                background: black;
                z-index: -1;
                opacity: 0.8;
                -webkit-border-radius: 10px;
                -moz-border-radius: 10px;
                border-radius: 10px;
                -webkit-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
                -moz-box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
                box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.15);
            }
            .form-group{
                margin-bottom: 25px;
            }
            .form-group > label{
                display: block;
                font-size: 18px;
                color: #000;
            }
            .custom-control-label{
                color: #000;
                font-size: 16px;
            }
            .form-control{
                height: 50px;
                background: #ecf0f4;
                border-color: transparent;
                padding: 0 15px;
                font-size: 16px;
                -webkit-transition: all 0.3s ease-in-out;
                -moz-transition: all 0.3s ease-in-out;
                -o-transition: all 0.3s ease-in-out;
                transition: all 0.3s ease-in-out;
            }
            .form-control:focus{
                border-color: #00bcd9;
                -webkit-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                -moz-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
            }
            textarea.form-control{
                height: 160px;
                padding-top: 15px;
                resize: none;
            }

            .btn{
                padding: .657rem .75rem;
                font-size: 18px;
                letter-spacing: 0.050em;
                -webkit-transition: all 0.3s ease-in-out;
                -moz-transition: all 0.3s ease-in-out;
                -o-transition: all 0.3s ease-in-out;
                transition: all 0.3s ease-in-out;
            }


            .btn-dark:hover {
                color: #00bcd9;
                background-color: #ffffff;
                border-color: #00bcd9;
                -webkit-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                -moz-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
            }

            .btn-dark:focus, .btn-dark.focus {
                color: #00bcd9;
                background-color: #ffffff;
                border-color: #00bcd9;
                -webkit-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                -moz-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
            }

            .btn-dark:not(:disabled):not(.disabled):active, .btn-dark:not(:disabled):not(.disabled).active,
            .show > .btn-dark.dropdown-toggle {
                color: #00bcd9;
                background-color: #ffffff;
                border-color: #00bcd9;
            }

            .btn-dark:not(:disabled):not(.disabled):active:focus, .btn-dark:not(:disabled):not(.disabled).active:focus,
            .show > .btn-dark.dropdown-toggle:focus {
                -webkit-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                -moz-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
            }
        </style>
    </head>
    <jsp:include page="Header.jsp" />
    <body style="font-family: Roboto!important">
        <div class="container" style="margin-bottom: 100px">
            <header class="header">
                <h1 id="title" class="text-center text-dark" style="font-family: Roboto">Thêm Đơn Thuốc</h1>

            </header>
            <div class="form-wrap">	
                <form id="survey-form" method="post" action="newPres">
                    <div class="row">
                        <h4 class="text-dark pb-4" style="font-family: Roboto"><b>Thông tin bệnh nhân</b></h4>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="patientName">Tên bệnh nhân</label>
                                <input type="text" name="patientName" id="patientName" placeholder="Tên bệnh nhân" class="form-control" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="age">Tuổi</label>
                                <input type="number" name="age" id="age" min="10" max="99" class="form-control" placeholder="18" >
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="height">Chiều cao(cm)</label>
                                <input type="number" name="height" id="height" min="100" max="300" class="form-control" placeholder="160" >
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="weight">Cân nặng <small>(kg)</small></label>
                                <input type="number" name="weight" id="weight" min="30" max="200" class="form-control" placeholder="60kg" >
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="diagnose">Chuẩn đoán</label>
                                <input type="text" name="diagnose" id="diagnose" placeholder="Chuẩn đoán bệnh.." class="form-control" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="medicalHistory">Tiền sử bệnh</label>
                                <input type="text" name="medicalHistory" id="medicalHistory" placeholder="Tiền sử sức khỏe.." class="form-control" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="createDate">Ngày tạo đơn</label>
                                <input type="date" name="createDate" id="createDate" placeholder="Ngày tạo đơn" class="form-control" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="doctorName">Tên bác sĩ</label>
                                <input type="text" name="doctorName" id="doctorName" placeholder="Tên Bác Sĩ.." class="form-control" required>
                            </div>
                        </div>
                    </div>
                    <div class=" row input d-flex align-items-center">
                        <h4 class="text-dark py-5" style="font-family: Roboto"><b>Thông tin Đơn Thuốc</b></h4>
                        <table>
                            <thead>
                                <tr>
                                    <th style="text-align: center">Thuốc</th>
                                    <th style="text-align: center">Ghi chú</th>
                                </tr>
                            </thead>
                            <tbody id="medicine-rows">
                            </tbody>
                            <tr>
                                <td style="border-bottom: none;text-align: center">
                                    <button type="button" class="btn btn-sm btn-dark mt-2 " id="add-ingredient-btn" style="font-size: 14px">Thêm Thuốc</button>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="row">
                        <div class="col-md-12 pt-5">
                            <div class="form-group">
                                <label for="Note">Ghi chú</label>
                                <textarea  id="Note" class="form-control" name="Note" placeholder="Ghi chú thông tin đơn thuốc..."></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="row d-flex align-items-center">
                        <div class="col-md-12 text-center">
                            <button type="submit" id="submit" class="btn btn-dark btn-block save-btn">Thêm Mới</button>
                            <a href="showPres" class="btn btn-dark"><i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</a>
                        </div>
                    </div>

                </form>
            </div>	
        </div>
        <script>
            document.getElementById('add-ingredient-btn').addEventListener('click', function () {
                var newRow = document.createElement('tr');
                newRow.innerHTML = `
                <td style="border-bottom: none" class="col-md-6">
                <select id="dropdown" name="regNumber" class="form-control" required>
            <c:forEach var="i" items="${listMedicine}">
                    <option value="${i.getRegNumber()}">${i.getName()}</option>
            </c:forEach>
                </select>
                </td>
                <td style="border-bottom: none" class="col-md-6">
                <input name="medNote" type="text" class="form-control" required>
                </td>
                <td style="border-bottom: none;">
                <button class="btn btn-outline-secondary delete-btn" type="button" style="font-size:16px">Xóa</button>
                </td>
`;
                document.getElementById('medicine-rows').appendChild(newRow);
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
                if (hasDuplicateMedNames()) {
                    event.preventDefault();
                    alert('Vui lòng điền hết các trường và chắc chắn Thành Phần thuốc không được lặp lại');
                }
            });

            function hasDuplicateMedNames() {
                var medNames = document.querySelectorAll('select[name="regNumber"]');
                var values = [];
                for (var i = 0; i < medNames.length; i++) {
                    if (values.includes(medNames[i].value)) {
                        return true;
                    }
                    values.push(medNames[i].value);
                }
                return false;
            }
        </script>
    </body>
    <jsp:include page="Footer.jsp" />

</html>
