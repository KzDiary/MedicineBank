<%-- 
    Document   : IngredentMedicine
    Created on : 7 Jul 2024, 23:37:09
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
    </head>
    <jsp:include page="Header.jsp" />
    <body>
        <h2 class="text-dark text-center mb-5" style="margin-top: 100px">${name}</h2>

        <section id="gallery" class="p-1">
            <div class="container">
                <div class="row">
                    <c:forEach var="med" items="${listMedicine}">
                        <div class="col-lg-4 mb-4">
                            <div class="card" style="width: 365px;height: 580px">
                                <img src="${med.getImgURL()}" alt="Medicine Image" class="card-img-top text-center" style="max-width: 364px;max-height: 280px;min-height: 200px">
                                <div class="card-body">
                                    <h5 class="card-title text-center">${med.getName()}</h5>
                                    <p class="card-text"><b>Hoạt chất:</b> 
                                        <c:forEach var="type" items="${med.getIngredents()}">
                                            ${type.key} - ${type.value};                                  </tr>
                                        </c:forEach>
                                    </p>
                                    <p class="card-text"><b>Dạng Bào Chế:</b> ${med.getDosageForm()}</p>
                                    <p class="card-text"><b>Hạn Sử Dụng:</b> ${med.getEXPDate()}</p>
                                    <p class="card-text"><b>Công ty Sản Xuất:</b> ${med.getCompany().getName()}</p>
                                    <p class="text-center" style="width: 100%"><a href="medDetails?regNumber=${med.getRegNumber()}" class="btn btn-outline-success btn-sm text-center">Đọc Thêm</a></p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </section>
        <jsp:include page="Footer.jsp" />
    </body>
</html>
