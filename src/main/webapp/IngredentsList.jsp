<%-- 
    Document   : IngredentsList
    Created on : 7 Jul 2024, 23:00:52
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <jsp:include page="Header.jsp" />
    <body id="container">
        <h1 class="text-dark text-center mb-5" style="margin-top: 120px">Danh sách Hoạt Chất</h1>
        <section id="gallery" class="p-1 mb-4">
            <div class="container">
                <div class="row">
                    <c:forEach var="ingre" items="${listIngre}">
                        <div class="col-lg-4 mb-4">
                            <div class="card" style="width: 365px;height: 450px">
                                <div class="card-body">
                                    <h5 class="card-title text-center">${ingre.getName()}</h5>
                                    <p class="card-text"><b>Công thức hóa học:</b> ${ingre.getFormula()}</p>
                                    <p class="card-text"><b>Mô tả:</b> ${ingre.getDescription()}</p>
                                    <p class="text-center" style="width: 100%">

                                        <a href="getMedByIngre?name=${ingre.getName()}" class="btn btn-outline-success btn-sm text-center">DS Thuốc</a>
                                        <c:if test="${sessionScope.role == 'Admin'}">
                                            <a href="#" class="btn btn-sm btn-danger delete-btn"
                                               data-name="${ingre.getName()}" 
                                               data-bs-toggle="modal" 
                                               data-bs-target="#confirmationModal">&nbsp; Xóa &nbsp;</i></a>
                                            <button style="width: 18%" class="btn btn-sm btn-dark edit-btn" data-bs-toggle="modal" data-bs-target="#editModal"
                                                    data-name="${ingre.getName()}"
                                                    data-formula="${ingre.getFormula()}" 
                                                    data-description="${ingre.getDescription()}"><i class="fa-solid fa-pen-to-square"></i></button>
                                        </c:if>  

                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </section>
        <!-- Confirmation Modal -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel">Xác nhận xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <a id="deleteLink" href="#" class="btn btn-danger">Xóa</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <form id="" action="updateIngre" method="post">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editModalLabel">Chỉnh sửa Hoạt chất</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="name" class="form-label">Tên Hoạt Chất</label>
                                <input name="name" type="text" class="form-control" id="name" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="formula" class="form-label">Công thức Hóa Học</label>
                                <input name="formula" type="text" class="form-control" id="formula">
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="6"></textarea>

                            </div>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </div>
                </div>
            </form>

        </div>

        <script>
            <c:if test="${not empty requestScope.alarm}">
            var body = document.getElementById("container");
            body.onload = alert('${requestScope.alarm}');
                <%request.removeAttribute("alarm");%>
            </c:if>
            document.addEventListener('DOMContentLoaded', function () {
                var deleteButtons = document.querySelectorAll('.delete-btn');
                var deleteLink = document.getElementById('deleteLink');

                deleteButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var name = button.getAttribute('data-name');
                        var deleteUrl = "ingreDelete?name=" + name;
                        deleteLink.setAttribute('href', deleteUrl);
                    });
                });
            });

            document.addEventListener('DOMContentLoaded', function () {
                var editButtons = document.querySelectorAll('.edit-btn');
                var editForm = document.getElementById('editForm');

                editButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var name = button.getAttribute('data-name');
                        var formula = button.getAttribute('data-formula');
                        var description = button.getAttribute('data-description');

                        document.getElementById('name').value = name;
                        document.getElementById('formula').value = formula;
                        document.getElementById('description').value = description;
                    });
                });

                editForm.addEventListener('submit', function (event) {
                    event.preventDefault();
                });
            });

        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>

        <jsp:include page="Footer.jsp" />
    </body>
</html>
