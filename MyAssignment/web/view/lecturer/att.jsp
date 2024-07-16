<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
        <link rel="stylesheet" href="css/takenattendance.css">
        <style>
            /* New CSS below */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                color: #333;
                padding: 20px;
                margin: 0;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            .header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding-bottom: 20px;
                border-bottom: 2px solid #eee;
                margin-bottom: 20px;
            }

            .header img {
                height: 80px;
            }

            .header .title {
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }

            .nav {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .nav a {
                text-decoration: none;
                color: #fff;
                background-color: #007bff;
                padding: 10px 20px;
                border-radius: 5px;
                margin-right: 10px;
                transition: background-color 0.3s;
            }

            .nav a:hover {
                background-color: #0056b3;
            }

            .sign-out-btn a {
                background-color: #dc3545;
            }

            .information {
                background-color: #f9f9f9;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 20px;
            }

            .information table {
                width: 100%;
                border-collapse: collapse;
            }

            .information td {
                padding: 10px;
                border: 1px solid #ddd;
            }

            .body {
                margin-top: 20px;
            }

            .body table {
                width: 100%;
                border-collapse: collapse;
            }

            .body th, .body td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .body th {
                background-color: #007bff;
                color: #fff;
            }

            .body-footer {
                margin-top: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .body-footer h3 {
                color: #dc3545;
                margin: 0;
            }

            .body-footer button {
                padding: 10px 20px;
                background-color: #28a745;
                color: #fff;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .body-footer button:hover {
                background-color: #218838;
            }

            input[type="radio"], input[type="text"] {
                margin: 5px 0;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div class="title">View Attendance </div>
            </div>

            <div class="nav">
                <div>
                    <a href="../homelecturer">Home</a>
                    <a href="../lecturer/markreport">Report Mark</a>
                    <a href="../lecturer/timetable?id=${sessionScope.lecturer.id}">Timetable</a>
                </div>
                <div class="sign-out-btn">
                    <a href="../logout">Sign out</a>
                </div>
            </div>

            <div class="information">
                <table>
                    <tr>
                        <td>Class:</td>
                        <td>${group}</td>
                    </tr>
                    <tr>
                        <td>Subject:</td>
                        <td>${subject}</td>
                    </tr>
                    <tr>
                        <td>Room:</td>
                        <td>${room}</td>
                    </tr>
                    <tr>
                        <td>Slot:</td>
                        <td>${slot}</td>
                    </tr>
                    <tr>
                        <td>Date:</td>
                        <td>${date}</td>
                    </tr>
                </table>
            </div>

            <div class="body">
                <form action="att" method="POST">
                    <input type="hidden" name="id" value="${param.id}" />
                    <table>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Presented</th>
                            <th>Note</th>
                            <th>Time</th>
                        </tr>
                        <c:forEach items="${requestScope.atts}" var="a">
                            <tr>
                                <td>${a.student.id}</td>
                                <td>${a.student.name}</td>
                                <td>
                                    <input type="hidden" name="aid${a.student.id}" value="${a.getId()}"/>
                                    <input type="radio" ${!a.present?"checked=\"checked\"":""} name="present${a.student.id}" value="no"/> No
                                    <input type="radio" ${a.present?"checked=\"checked\"":""} name="present${a.student.id}" value="yes"/> Yes
                                </td>
                                <td>
                                    <input type="text" name="description${a.student.id}" value="${a.description}"/>
                                </td>
                                <td>${a.time.toString().substring(0)}</td>
                            </tr>    
                        </c:forEach>
                    </table>
                    <div class="body-footer">
                        <input type="hidden" name="room" value="${room}"/>
                        <input type="hidden" name="group" value="${group}"/>
                        <input type="hidden" name="subject" value="${subject}"/>
                        <input type="hidden" name="slot" value="${slot}"/>
                        <input type="hidden" name="date" value="${date}"/>
                        <h3>${messageAlert}</h3>
                        <button type="submit">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
