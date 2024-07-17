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
