

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Present Report</title>
    <link rel="stylesheet" href="presentreport.css">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #eef2f7;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #007bff;
            font-size: 36px;
            font-weight: 700;
        }

        form {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

        label {
            flex: 1 1 100%;
            margin-bottom: 5px;
            font-weight: 500;
        }

        select,
        button,
        input[type="text"] {
            flex: 1 1 45%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th,
        td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        td {
            background-color: #fff;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
        }

        .nav-content a,
        .sign-out-btn a {
            color: #fff;
            text-decoration: none;
            margin: 0 10px;
            padding: 8px 16px;
            border-radius: 4px;
            background-color: #0056b3;
            transition: background-color 0.3s ease;
        }

        .nav-content a:hover,
        .sign-out-btn a:hover {
            background-color: #00408d;
        }
    </style>
</head>

<body>
    <div class="header">
        <div class="nav-content">
            <a href="../homelecturer">Home</a>
            <a href="../lecturer/timetable?id=${sessionScope.lecturer.id}">Timetable</a>
        </div>
        <div class="sign-out-btn">
            <a href="../logout">Sign out</a>
        </div>
    </div>
    <div class="container">
        <h1>View Attendance</h1>
        <form action="../lecturer/presentreport" method="get">
            <label for="term">Select a term:</label>
            <select id="term">
                <option value="fall2023">Fall 2023</option>
                <option value="spring2024">Spring 2024</option>
                <!-- Add more terms here -->
            </select>
            <label for="course">Select a course:</label>
            <select id="course" name="groupchoosen">
                <c:forEach items="${studentgroup}" var="group">
                    <c:choose>
                        <c:when test="${groupchoosen == group.id}">
                            <option value="${group.id}" selected>${group.getName()}-${group.subject.name}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${group.id}">${group.getName()}-${group.subject.name}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
            <button type="submit" id="submit">See Report</button>
        </form>
        <!--<h3 style="color: green">${sessionScope.mess}</h3>-->
        <table id="gradeReport">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th></th>
                    <c:set var="counter" value="0" />
                    <c:forEach items="${listLession}" var="l">
                        <c:set var="counter" value="${counter + 1}" />
                        <th title="${l.date}">${counter}</th>
                    </c:forEach>
                    <th>Total</th>
                </tr>
                <c:forEach items="${listStudent}" var="student">
                    <tr>
                        <td>${student.id}</td>
                        <td>${student.name}</td>
                        <td>
                            
                        </td>
                        <c:forEach items="${listLession}" var="les">
                            <c:forEach items="${listAttendence}" var="atten">
                                <c:if test="${atten.lession.id == les.id && atten.student.id == student.id}">
                                    <td>${atten.present ? 'P' : 'A'}</td>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                        <td>..%</td>
                    </tr>
                </c:forEach>
            </thead>
        </table>
    </div>

    <script>
        window.onload = function () {
            var table = document.getElementById('gradeReport');

            for (var i = 1, row; row = table.rows[i]; i++) {
                var countA = 0;
                var totalColumns = 0;

                for (var j = 3, col; col = row.cells[j]; j++) {
                    if (j < row.cells.length - 1) {
                        totalColumns++;
                        if (col.textContent === 'A') {
                            countA++;
                        }
                    }
                }

                var percentage = (countA / totalColumns) * 100;
                var totalCell = row.cells[row.cells.length - 1];
                totalCell.textContent = percentage.toFixed(0) + '%';

                if (percentage > 20) {
                    totalCell.style.color = 'red';
                } else {
                    totalCell.style.color = 'green';
                }
            }
        };
    </script>
</body>

</html>
