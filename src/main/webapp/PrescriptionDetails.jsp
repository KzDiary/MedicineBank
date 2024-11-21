<%-- 
    Document   : PrescriptionDetails
    Created on : 14 Jul 2024, 13:12:10
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
            .form-control hidden input{
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
            .form-control hidden input:focus{
                border-color: #00bcd9;
                -webkit-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                -moz-box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
                box-shadow: 0px 0px 20px rgba(0, 0, 0, .1);
            }
            textarea.form-control hidden input{
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
            .hidden {
                display: none;
            }
        </style>
    </head>
    <jsp:include page="Header.jsp" />
    <body style="font-family: Roboto!important">
        <div class="container" style="margin-bottom: 100px">
            <header class="header">
<%--                <h1 id="title" class="text-center text-dark" style="font-family: Roboto">Đơn Thuốc ${pres.getID()}</h1>--%>
            </header>
            <div class="form-wrap">	
                <form id="precription-form" method="post" action="editPres">
<%--                    <input type="text" name="ID" value="${pres.getID()}" style="display: none">--%>
                    <div class="row">
                        <h4 class="text-dark pb-4" style="font-family: Roboto"><b>Thông tin bệnh nhân</b></h4>
                        <div class="col-md-6">
                            <div class="form-group">
<%--                                <label for="patientName"><b>Tên bệnh nhân</b></label>--%>
<%--                                <input type="text" name="patientName" id="patientName" class="form-control hidden input" value="${pres.getPatientName()}" required>--%>
                                <span class="text">${pres.getPatientName()}</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
<%--                                <label for="age"><b>Tuổi</b></label>--%>
<%--                                <input type="number" name="age" id="age" min="10" max="99" class="form-control hidden input" placeholder="18" value="${pres.getAge()}" required>--%>
                                <span class="text">${pres.getAge()}</span>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="height"><b>Chiều cao<small>(cm)</small></b></label>
                                <input type="number" name="height" id="height" min="100" max="300" class="form-control hidden input" placeholder="160" value="${pres.getHeight()}">
                                <span class="text">${pres.getHeight()}</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="weight"><b>Cân nặng<small>(kg)</small></b></label>
                                <input type="number" name="weight" id="weight" min="30" max="200" class="form-control hidden input" value="${pres.getWeight()}">
                                <span class="text">${pres.getWeight()}</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
<%--                                <label for="diagnose"><b>Chuẩn đoán</b></label>--%>
<%--                                <input type="text" name="diagnose" id="diagnose" class="form-control hidden input" value="${pres.getDiagnose()}" required>--%>
                                <span class="text">${pres.getDiagnose()}</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="medicalHistory"><b>Tiền sử bệnh</b></label>
                                <input type="text" name="medicalHistory" id="medicalHistory" class="form-control hidden input" value="${pres.getMedicalHistory()}" required>
                                <span class="text">${pres.getMedicalHistory()}</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="createDate"><b>Ngày tạo đơn</b></label>
                                <input type="date" name="createDate" id="createDate" value="${pres.getCreateDate()}" class="form-control hidden input" required>
                            </div>
                            <span class="text">${pres.getCreateDate()}</span>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="doctorName"><b>Tên bác sĩ</b></label>
                                <input type="text" name="doctorName" id="doctorName" value="${pres.getDoctorName()}" class="form-control hidden input" required>
                                <span class="text">${pres.getDoctorName()}</span>
                            </div>
                        </div>
                    </div>
                    <div class=" row input d-flex align-items-center">
                        <h4 class="text-dark pt-5" style="font-family: Roboto"><b>Thông tin Đơn Thuốc:</b></h4>
                        <span class="text">
                            <c:set var="STT" value="1" />
                            <c:forEach var="i" items="${pres.getMedicineList()}">
                                <b>${STT}. ${i.key.getName()}</b> <i>(
                                <c:forEach var="type" items="${i.key.getIngredents()}">
                                    ${type.key} - ${type.value}
                                </c:forEach>)</i> <br/><c:set var="STT" value="${STT + 1}" />
                                ${i.value} <br/><br/>
                            </c:forEach>
                        </span>

                        <table class="input hidden">
                            <thead>
                                <tr>
                                    <th style="text-align: center">Thuốc</th>
                                    <th style="text-align: center">Ghi chú</th>
                                </tr>
                            </thead>
                            <tbody id="medicine-rows">
                                <c:forEach var="type" items="${pres.getMedicineList()}">
                                    <tr>
                                        <td style="border-bottom: none">
                                            <select name="regNumber" class="form-select" id="regNumber">
                                                <option value="${type.key.getRegNumber()}" selected>${type.key.getName()}</option>
                                                <c:forEach var="i" items="${listMedicine}">
                                                    <c:if test="${!type.key.getName().equals(i.getName())}">
                                                        <option value="${i.getRegNumber()}">${i.getName()}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td style="border-bottom: none">
                                            <input name="medNote" type="text" class="form-control" value="${type.value}">
                                        </td>
                                        <td style="border-bottom: none;width: 1%;">
                                            <button class="btn btn-outline-secondary delete-btn" type="button">Xóa</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tr>
                                <td style="border-bottom: none;text-align: center">
                                    <button type="button" class="btn btn-sm btn-dark mt-2 " id="add-medicine-btn" style="font-size: 14px">Thêm Thuốc</button>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="row">
                        <div class="col-md-12 pt-2">
                            <div class="form-group">
                                <label for="Note"><b>Ghi chú</b></label>
                                <textarea  id="Note" class="form-control hidden input" name="Note">${pres.getNote()}</textarea>
                                <span class="text">${pres.getNote()}</span>

                            </div>
                        </div>
                    </div>

                    <div class="row d-flex align-items-center">
                        <div class="col-md-12 text-center">
                            <button class="btn btn-dark edit-btn mt-4" style="width: 80px;"><i style="font-size: 20px" class="fa-solid fa-pen-to-square"></i></button>
                            <button class="btn btn-success save-btn mt-4 hidden input" style="width: 80px;"><i class="fa-regular fa-floppy-disk"></i></button>
                            <button class="btn btn-dark cancel-btn mt-4 hidden input" style="width: 80px;">Hủy</button>
                            <a href="showPres" class="btn btn-dark mt-4"><i style="font-size: 13px" class="fa-solid fa-arrow-left"></i>&nbsp; Quay lại</a>

                        </div>
                    </div>

                </form>
            </div>	
        </div>
        <script>
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
                document.getElementById('precription-form').addEventListener('submit', function (event) {
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

                document.getElementById('precription-form').removeEventListener('submit', function (event) {
                    event.preventDefault();
                });
            });

            document.querySelector('.save-btn').addEventListener('click', function () {
                if (!hasDuplicateMedNames()) {
                    document.getElementById('precription-form').submit();
                } else {
                    alert('Thuốc trong đơn không được lặp lại');
                }
            });

            function hasDuplicateMedNames() {
                var MedNames = document.querySelectorAll('select[name="regNumber"]');
                var values = [];
                for (var i = 0; i < MedNames.length; i++) {
                    if (values.includes(MedNames[i].value)) {
                        return true;
                    }
                    values.push(MedNames[i].value);
                }
                return false;
            }

            document.getElementById('add-medicine-btn').addEventListener('click', function () {
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

        </script>
    </body>
    <jsp:include page="Footer.jsp" />

</html>
