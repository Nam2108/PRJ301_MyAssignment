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
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 2rem;
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            color: #333333;
            background-color: #3E4BB2;
            color: #ffffff;
            padding: 10px;
            border-radius: 8px;
        }

        form {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 2rem;
            font-weight: 600;
        }

        form input,
        form select {
            width: calc(50% - 20px);
            margin: 10px;
            padding: 10px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            background-color: #f2f2f2;
        }

        form button {
            margin: 10px;
            padding: 10px 20px;
            font-weight: 600;
            background-color: #18100B;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        form button:hover {
            background-color: #111;
        }

        label {
            flex-basis: 100%;
            margin: 10px;
            color: #4a4a4a;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
        }

        th,
        td {
            text-align: left;
            padding: 1rem;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #f2f2f2;
            color: #4a4a4a;
            font-weight: bold;
        }

        td {
            color: #4a4a4a;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .nav-logo img {
            width: 100px;
        }

        .sign-out-btn a {
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 4px;
            border: none;
            background-color: #f27935;
            color: #ffffff;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .sign-out-btn a:hover {
            background-color: #d96529;
        }

        .nav-content a {
            text-decoration: none;
            margin-right: 15px;
            background-color: #3E4BB2;
            color: #ffffff;
            padding: 10px 20px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .nav-content a:hover {
            background-color: #333;
        }
    </style>
</head>

<body>
    <div class="header">
        <div class="nav-logo">
            <img src="logo.png" alt="Logo">
        </div>
        <div class="nav-content">
            <a href="../homelecturer">Home</a>
            <a href="../student/timetable?id=${sessionScope.student.id}">Timetable</a>
            <a href="../student/markreport">Report Mark</a>
        </div>
        <div class="sign-out-btn">
            <a href="../logout">Sign out</a>
        </div>
    </div>
    <div class="container">
        <h1>Present Report</h1>
        <form action="../student/presentreport" method="get">
            <label for="term">Select a term:</label>
            <select id="term" name="term">
                <option value="fall2023">Fall 2023</option>
                <option value="spring2024">Spring 2024</option>
                <!-- Add more terms here -->
            </select>
            <label for="course">Select a course:</label>
            <select id="course" name="groupchoosen">
                <c:forEach items="${listgroup}" var="group">
                    <c:choose>
                        <c:when test="${groupchoosen == group.subject.id}">
                            <option value="${group.id}" selected="">
                                ${group.getName()}-${group.subject.name}
                            </option>
                        </c:when>
                        <c:otherwise>
                            <option value="${group.id}">${group.getName()}-${group.subject.name}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
            <button type="submit" id="submit">See Report</button>
        </form>
        <table id="gradeReport">
            <thead>
                <tr>
                    <th>SLOT</th>
                    <th>DATE</th>
                    <th>ROOM</th>
                    <th>LECTURER</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="counter" value="0" />
                <c:forEach items="${listLession}" var="lession">
                    <tr>
                        <td><c:set var="counter" value="${counter + 1}" />${counter}</td>
                        <td>${lession.date}</td>
                        <td>${lession.room.name}</td>
                        <td>${lession.lecturer.name}</td>
                        <c:forEach items="${listAttendence}" var="atten">
                            <c:if test="${atten.lession.id == lession.id && atten.student.id == sessionScope.student.id}">
                                <c:choose>
                                    <c:when test="${atten.present}">
                                        <td style="color: green">Present</td>
                                    </c:when>
                                    <c:when test="${!atten.present}">
                                        <td style="color: red">Absent</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>Not Yet</td>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                    </tr>
                </c:forEach>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            calculateAttendancePercentage();
        });

        function calculateAttendancePercentage() {
            var absentCount = 0;
            var totalSlots = 20; // Tổng số buổi là 20

            // Lặp qua mỗi dòng trong bảng
            var tableRows = document.querySelectorAll('#gradeReport tbody tr');
            tableRows.forEach(function (row) {
                // Lấy giá trị của cột "Status"
                var statusCell = row.querySelector('td:nth-child(5)');
                if (statusCell) {
                    var status = statusCell.textContent.trim();
                    if (status === 'Absent') {
                        absentCount++;
                    }
                }
            });

            // Tính toán tỷ lệ phần trăm vắng mặt
            var absentPercentage = (absentCount / totalSlots) * 100;
            var totalCell = document.querySelector('#gradeReport tbody tr:last-child td:last-child');
            if (totalCell) {
                totalCell.textContent = '' + absentPercentage.toFixed(2) + '%';
                // Đổi màu nền dựa trên tỷ lệ phần trăm vắng mặt
                if (absentPercentage > 20) {
                    totalCell.style.color = 'red';
                } else {
                    totalCell.style.color = 'green';
                }
            }
        }
    </script>
</body>

</html>
