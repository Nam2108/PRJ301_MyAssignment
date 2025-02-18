<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Attendance</title>
        <link rel="stylesheet" href="css/takenattendance.css">
        
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
