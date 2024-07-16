<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Grade Report</title>
        <link rel="stylesheet" href="viewmarkstudent.css">
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f0f4f8;
                padding: 20px;
            }

            .container {
                max-width: 900px;
                margin: auto;
                padding: 20px;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            h1 {
                text-align: center;
                margin-bottom: 30px;
                color: #333333;
                font-size: 24px;
                font-family: 'Cambria', 'Cochin', 'Georgia', 'Times', 'Times New Roman', serif;
                background-color: #f5b640;
                border-radius: 8px;
                padding: 10px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .nav-content a, .sign-out-btn a {
                text-decoration: none;
                padding: 10px 15px;
                margin-right: 10px;
                border-radius: 5px;
                color: white;
            }

            .nav-content a {
                background-color: #f19705;
            }

            .sign-out-btn a {
                background-color: rgba(0, 0, 0, 0.3);
            }

            form {
                display: flex;
                flex-wrap: wrap;
                margin-bottom: 20px;
                justify-content: space-between;
            }

            form label, form select, form button {
                flex: 1 1 calc(33.333% - 10px);
                margin: 5px;
            }

            form button {
                background-color: rgba(24, 15, 7, 0.5);
                color: #333333;
                border: none;
                border-radius: 5px;
                padding: 10px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            form button:hover {
                background-color: rgba(24, 15, 7, 0.7);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                text-align: left;
                padding: 12px;
                border-bottom: 1px solid #e0e0e0;
                font-size: 14px;
                color: #333333;
            }

            th {
                background-color: #f5f5f5;
                color: #666666;
            }

            .footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 0;
                border-top: 1px solid #e0e0e0;
            }

            .footer h4 {
                margin: 0;
                font-size: 16px;
                color: #333333;
            }

            .footer #status {
                color: green;
            }

            .footer #status.fail {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="nav-content">
                <a href="../homelecturer">Home</a>
                <a href="../student/timetable?id=${sessionScope.lecturer.id}">Timetable</a>
                <a href="../student/presentreport">Present report</a>
            </div>
            <div class="sign-out-btn">
                <a href="../logout">Sign out</a>
            </div>
        </div>
        <div class="container">
            <h1>Grade Report</h1>
            <form action="../student/markreport" method="get">
                <label for="term">Select a term:</label>
                <select id="term" name="term">
                    <option value="fall2023">Fall 2023</option>
                    <option value="spring2024">Spring 2024</option>
                </select>
                <label for="course">Select a course:</label>
                <select id="course" name="subjectchoosen">
                    <c:forEach items="${listgroup}" var="group">
                        <c:choose>
                            <c:when test="${subjectchoosen == group.subject.id}">
                                <option value="${group.subject.id},${group.id}" selected>
                                    ${group.getName()}-${group.subject.name}
                                </option>
                            </c:when>
                            <c:otherwise>
                                <option value="${group.subject.id},${group.id}">${group.getName()}-${group.subject.name}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                <button type="submit" id="submit">View Mark</button>
            </form>
            <table id="gradeReport">
                <thead>
                    <tr>
                        <th>Grade Item</th>
                        <th>Weight</th>
                        <th>Value</th>
                        <th>Comment</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="totalWeightedScore" value="0"/>
                    <c:set var="totalWeight" value="0"/>
                    <c:forEach items="${listScoreType}" var="scoreType">
                        <tr>
                            <td>${scoreType.sctname}</td>
                            <td>${scoreType.sctpercent}</td>
                            <c:set var="weight" value="${fn:replace(scoreType.sctpercent, '%', '') / 100}"/>
                            <c:forEach items="${listScore}" var="score">
                                <c:if test="${(score.scoreType.sctid == scoreType.sctid) && (score.student.id == sessionScope.student.id)}">
                                    <c:set var="scoreofstudent" value="${score.score}"/>
                                    <c:set var="weightedScore" value="${scoreofstudent * weight}"/>
                                    <c:set var="totalWeightedScore" value="${totalWeightedScore + weightedScore}"/>
                                    <c:set var="totalWeight" value="${totalWeight + weight}"/>
                                </c:if>
                            </c:forEach>
                            <td>${scoreofstudent == null ? 0 : scoreofstudent}</td>
                            <td>No comment!</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="footer">
                <h4>AVERAGE: <c:if test="${totalWeight > 0}">${totalWeightedScore / totalWeight}</c:if></h4>
                <h4 id="status">STATUS: <c:if test="${totalWeight > 0}">
                    <span id="passFail">${(totalWeightedScore / totalWeight) < 5 ? 'NOT PASSED' : 'PASSED'}</span>
                </c:if></h4>
            </div>
        </div>
        <script>
            window.onload = function () {
                var average = parseFloat("${totalWeightedScore / totalWeight}").toFixed(1);
                var statusSpan = document.getElementById("passFail");
                if (average < 5.0) {
                    statusSpan.textContent = "NOT PASSED";
                    statusSpan.style.color = "red";
                } else {
                    statusSpan.textContent = "PASSED";
                    statusSpan.style.color = "green";
                }
            };
        </script>
    </body>
</html>
