<%-- 
    Document   : markreport
    Created on : Jul 16, 2024, 8:49:50 PM
    Author     : nam
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Attendance</title>
        <link rel="stylesheet" href="/markreport.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f9;
                color: #333;
                padding: 20px;
            }

            .header {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                padding: 10px;
                background-color: #007bff;
                color: white;
                border-radius: 5px;
            }

            .header img {
                height: 50px;
                margin-right: 15px;
            }

            .header h1 {
                font-size: 24px;
            }

            .nav-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .nav-header a {
                padding: 10px 20px;
                text-decoration: none;
                color: white;
                background-color: #007bff;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .nav-header a:hover {
                background-color: #0056b3;
            }

            .information {
                width: 220px;
                float: left;
                margin-right: 20px;
                padding: 10px;
                background-color: white;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .information table {
                width: 100%;
                border-collapse: collapse;
            }

            .information td, .information th {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .information th {
                background-color: #f8f9fa;
                font-weight: bold;
            }

            .body {
                padding: 20px;
                background-color: white;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .body table {
                width: 100%;
                border-collapse: collapse;
            }

            .body th, .body td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }

            .body th {
                background-color: #007bff;
                color: white;
            }

            .body-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 20px;
            }

            .body-footer button {
                padding: 10px 20px;
                color: white;
                background-color: #007bff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .body-footer button:hover {
                background-color: #0056b3;
            }
            
            input[type="text"] {
                width: 100%;
                padding: 10px;
                margin: 5px 0;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
        </style>
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

