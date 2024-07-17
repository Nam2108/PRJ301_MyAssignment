<%-- 
    Document   : homelecturer
    Created on : Jul 15, 2024, 5:54:43 PM
    Author     : nam
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home</title>
        <link rel="stylesheet" href="css/homelecturer.css"/>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }
            body {
                height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                background-color: #f4f4f4;
            }
            .header {
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .nav-logo img {
                width: 100px;
            }
            .nav-content {
                display: flex;
                gap: 20px;
            }
            .nav-content a {
                text-decoration: none;
                background-color: #f19705;
                color: #fff;
                padding: 10px 15px;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .nav-content a:hover {
                background-color: #d17c03;
            }
            .sign-out-btn a {
                text-decoration: none;
                background-color: rgba(0, 0, 0, 0.1);
                color: #333;
                padding: 10px 15px;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .sign-out-btn a:hover {
                background-color: rgba(0, 0, 0, 0.2);
            }
            .footer {
                background-color: #f19705;
                color: white;
                text-align: center;
                padding: 20px;
            }
            .footer p {
                margin: 5px 0;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="nav-logo">
                <img src="img/Logo.jpg" alt="FPT University Logo">
            </div>
            <div class="nav-content">
                <c:choose>
                    <c:when test="${not empty sessionScope.lecturer.getName()}">
                        <a href="lecturer/timetable?id=${sessionScope.lecturer.id}">Timetable</a>
                        <a href="lecturer/presentreport">Present Report</a>
                        <a href="lecturer/markreport">Report Mark</a>
                    </c:when>
                    <c:when test="${not empty sessionScope.student.getName()}">
                        <a href="student/timetable?id=${sessionScope.student.id}">Timetable</a>
                        <a href="student/presentreport">Present Report</a>
                        <a href="student/markreport">Report Mark</a>
                    </c:when>
                    <c:otherwise>
                        You must login first!
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="sign-out-btn">
                <a href="logout">Sign Out</a>
            </div>
        </div>
        <div class="body">
            <!-- Body content goes here -->
        </div>
        <div class="footer">
            <p>Phòng dịch vụ sinh viên: Email: dichvusinhvien@fe.edu.vn. Điện thoại: (024)7308.13.13</p>
            <p>© Powered by FPT University | CMS | library | books24x7</p>
        </div>
    </body>
</html>

