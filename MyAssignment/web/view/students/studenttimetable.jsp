<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>  
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="css/timetable.css"/>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            padding: 20px;
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        .header, .nav-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: #ffc107;
            color: white;
            border-radius: 5px;
        }

        .nav-content a, .sign-out-btn a {
            text-decoration: none;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .nav-content a:hover, .sign-out-btn a:hover {
            background-color: #495057;
        }

        .logo img {
            width: 200px;
            display: block;
            margin: 20px auto;
        }

        .lecturer {
            text-align: center;
            margin-bottom: 20px;
        }

        .select-month-option-find {
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 10px;
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .select-month-option-find form {
            display: flex;
            align-items: center;
        }

        .select-month-option-find input,
        .select-month-option-find button {
            margin-left: 10px;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
        }

        .select-month-option-find button {
            background-color: #007bff;
            color: white;
            border: none;
            transition: background-color 0.3s ease;
        }

        .select-month-option-find button:hover {
            background-color: #0056b3;
        }

        .body-mine {
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }

        .body-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .body-table table th,
        .body-table table td {
            padding: 15px;
            text-align: left;
        }

        .body-table table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        .body-table table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .body-table table tr:hover {
            background-color: #e9ecef;
        }

        .body-table table tr td div {
            display: flex;
            align-items: center;
        }

        .body-table table tr td div p {
            margin: 0;
            margin-right: 10px;
        }

        .edit-event-detail-popper {
            width: 500px;
            height: 300px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            padding: 20px;
        }

        .edit-event-detail-popper-header {
            display: flex;
            justify-content: flex-end;
            padding: 10px 0;
        }

        .edit-event-detail-popper-header i {
            font-size: 20px;
            padding: 5px;
            border-radius: 50%;
            color: #6c757d;
            transition: background-color 0.3s ease;
        }

        .edit-event-detail-popper-header i:hover {
            background-color: #e9ecef;
        }

        .edit-event-detail-popper-header-body {
            padding: 0 30px;
        }

        .edit-event-detail-popper-header-body table td {
            padding: 10px 20px;
        }

        .edit-event-detail-popper-header-body i {
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="nav-content">
            <a href="../homelecturer">Home</a>
            <a href="../student/presentreport">Present report</a>
            <a href="../student/markreport">Report Mark</a>
        </div>
        <div class="sign-out-btn">
            <a href="../logout">Sign out</a>
        </div>
    </div>
    <div class="logo">
    </div>
    <div class="lecturer">
        <h1 style="margin-top: 20px">Student name: ${sessionScope.account.displayname}</h1>
    </div>
    <div class="header-para">
        
    </div>
    <div class="select-month-option-find">
        <form action="timetable" method="GET">
            <input type="hidden" value="${sessionScope.student.id}" name="id"/>
            From: <input type="date" name="from" value="${requestScope.from}"/> -
            <input type="date" name="to" value="${requestScope.to}"/>
            <button> View </button>
        </form>
    </div>

    <div class="body-mine">
        <div class="body-table">
            <table>
                <tr class="table-header">
                    <th>Date</th>
                    <th></th>
                    <th>
                        <p>Slot</p>
                        <p></p>
                        <p>Room</p>
                        <p>Subject - Class</p>
                    </th>
                </tr>
                <c:forEach items="${requestScope.dates}" var="d">
                    <c:set var="hasLessons" value="false"/>
                    <c:forEach items="${requestScope.lessions}" var="les">
                        <c:if test="${les.date eq d}">
                            <c:set var="hasLessons" value="true"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasLessons}">
                        <tr>
                            <td>
                                <div>
                                    <h5 class="no-padding-margin">(<fmt:formatDate pattern="E" value="${d}" />)
                                        ${d.toString().substring(8,10)}/${d.toString().substring(5,7)}</h5>
                                </div>
                            </td>
                            <td></td>
                            <td>
                                <c:forEach items="${requestScope.slots}" var="slot">
                                    <c:forEach items="${requestScope.lessions}" var="les">
                                        <c:if test="${les.date eq d and les.slot.id eq slot.id}">
                                            <div style="cursor: pointer;">
                                                <p><i class="fas fa-circle" style="color: red"></i>${slot.name}</p>
                                                <p></p>
                                                <p>BE301</p>
                                                <p>${les.group.name} - ${les.group.subject.name} 
                                                    (<c:if test="${les.attended}">
                                                        <c:forEach items="${listAttendences}" var="att">
                                                            <c:if test="${att.lession.id == les.id and att.present}">
                                                                <span style="color: green">Present</span>
                                                            </c:if>
                                                            <c:if test="${att.lession.id == les.id and !att.present}">
                                                                <span style="color: red">Absent</span>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                    <c:if test="${!les.attended}">
                                                        <span style="color: gray">Not yet</span>
                                                    </c:if>)
                                                </p>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
    crossorigin="anonymous"></script>        
</body>
</html>
