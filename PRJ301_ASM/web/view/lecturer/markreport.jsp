<%-- 
    Document   : markreport
    Created on : Mar 5, 2024, 10:48:24 PM
    Author     : DEll
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Attendance</title>
       
         
    </head>
    <body>
        <div class="nav-header">
            <div class="nav-content">
                <a href="../homelecturer">Home</a>
                <a href="../lecturer/timetable?id=${sessionScope.lecturer.id}">Timetable</a>
            </div>
            <div class="sign-out-btn">
                <a href="../logout">Sign out</a>
            </div>
        </div>

        <div class="header">
            <h1>View Attendance</h1>
        </div>

        <div class="information">
            <table>
                <tr>
                    <th>Class-Subject</th>
                </tr>
                <c:forEach items="${studentgroup}" var="group">
                    <tr>
                        <td><a href="../lecturer/markreport?groupchoosen=${group.id}&subjectchoosen=${group.subject.id}">${group.getName()}-${group.subject.name}</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <div class="body">
            <form action="../lecturer/markreport" method="post">
                <table>
                    <tr>
                        <th>Id</th>
                        <th>Name</th>
                        <c:forEach items="${listScoreType}" var="score">
                            <th>${score.sctname}<br/>(${score.sctpercent})</th>
                        </c:forEach>
                    </tr>
                    <c:forEach items="${listStudent}" var="student">
                        <tr>
                            <td>${student.id}</td>
                            <td>${student.name}</td>
                            <c:forEach items="${listScoreType}" var="type">
                                <c:forEach items="${listScore}" var="score">
                                    <c:if test="${(score.scoreType.sctid == type.sctid) and (score.student.id == student.id)}">
                                        <c:set var="scoreofstudent" value="${score.score}"/>
                                    </c:if>
                                </c:forEach>
                                <td>
                                    <input type="number" max="10" min="0" step="0.1" name="score${student.id}and${type.sctid}" value="${scoreofstudent == null ? 0 : scoreofstudent}">
                                    <input type="hidden" value="${student.id}" name="student${student.id}"/>
                                    <input type="hidden" value="${type.sctid}" name="scoreType${type.sctid}"/>
                                </td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>
                <input type="hidden" name="groupchoosen" value="${groupchoosen}"/>
                <input type="hidden" name="subjectchoosen" value="${subjectchoosen}"/>
                <c:if test="${listStudent != null}">
                    <div class="body-footer">
                        <h3>${messageAlert}</h3>
                        <button type="submit">Save</button>
                    </div>
                </c:if>
            </form>
        </div>
    </body>
</html>
