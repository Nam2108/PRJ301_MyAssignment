<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Grade Report</title>
        
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
