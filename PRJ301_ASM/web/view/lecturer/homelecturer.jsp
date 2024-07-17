
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home</title>
        <link rel="stylesheet" href="css/homelecturer.css"/>
        
    </head>
    <body>
        <div class="header">
            
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
        
    </body>
</html>
