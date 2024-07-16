

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Timetable</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="css/timetable.css"/>
    <style>
        body {
            background-color: #eef2f7;
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 20px;
        }

        .header, .header-para {
            margin-bottom: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 8px;
            color: white;
        }

        .header a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            padding: 8px 16px;
            border-radius: 4px;
            background-color: #0056b3;
            transition: background-color 0.3s ease;
        }

        .header a:hover {
            background-color: #00408d;
        }

        .logo img {
            width: 300px;
            margin-bottom: 20px;
        }

        .lecturer h1 {
            margin-bottom: 20px;
        }

        .header-para pre {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
        }

        .select-month-option-find {
            background-color: white;
            padding: 10px 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .select-month-option-find input,
        .select-month-option-find button {
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 16px;
        }

        .select-month-option-find button {
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .select-month-option-find button:hover {
            background-color: #0056b3;
        }

        .body-mine {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .body-table {
            width: 100%;
        }

        .body-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .body-table table th,
        .body-table table td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        .body-table table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        .body-table table tr:hover {
            background-color: #f1f1f1;
        }

        .event-details p {
            margin: 5px 0;
        }
    </style>
</head>

<body>
    <div class="header">
        <div class="nav-content">
            <a href="../homelecturer">Home</a>
            <a href="../lecturer/presentreport">Present Report</a>
            <a href="../lecturer/markreport">Report Mark</a>
        </div>
        <div class="sign-out-btn">
            <a href="../logout">Sign Out</a>
        </div>
    </div>
    <div class="logo">
    </div>
    <div class="lecturer">
    </div>
    <div class="header-para">
    </div>
    <div class="select-month-option-find">
        <form action="timetable" method="GET">
            <input type="hidden" value="${sessionScope.lecturer.id}" name="id"/>
            From: <input type="date" name="from" value="${requestScope.from}"/> -
            <input type="date" name="to" value="${requestScope.to}"/>
            <button type="submit">View</button>
        </form>
    </div>
    <div class="body-mine">
        <div class="body-table">
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Slot</th>
                        <th></th>
                        <th>Room</th>
                        <th>Subject - Class</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.dates}" var="d">
                        <c:forEach items="${requestScope.slots}" var="slot">
                            <c:forEach items="${requestScope.lessions}" var="les">
                                <c:if test="${les.date eq d and les.slot.id eq slot.id}">
                                    <tr>
                                        <td>
                                            <h5 class="no-padding-margin">
                                                (<fmt:formatDate pattern="E" value="${d}" />)
                                                ${d.toString().substring(8,10)}/${d.toString().substring(5,7)}
                                            </h5>
                                        </td>
                                        <td>${slot.name}</td>
                                        <td></td>
                                        <td>BE301</td>
                                        <td>${les.group.name} - ${les.group.subject.name}
                                            (<a href="att?id=${les.id}&date=${d}&slot=${slot.name}&subject=${les.group.subject.name}&group=${les.group.name}&room=${les.room.name}">
                                                <c:if test="${les.attended}">Edit</c:if>
                                                <c:if test="${!les.attended}">Take</c:if>
                                            </a>)
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
    crossorigin="anonymous"></script>
</body>

</html>
