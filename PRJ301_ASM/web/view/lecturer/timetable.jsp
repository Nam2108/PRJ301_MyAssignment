

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
