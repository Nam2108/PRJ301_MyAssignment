/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.lecturer;

import controller.authentication.authorization.BaseRBACController;
import dal.GroupDBContext;
import entity.Account;
import entity.Lecturer;
import entity.Role;
import entity.StudentGroup;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DEll
 */
public class PresentReportController extends BaseRBACController {
   
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account, ArrayList<Role> roles) throws ServletException, IOException {

        

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, Account account, ArrayList<Role> roles) throws ServletException, IOException {
        
        GroupDBContext db = new GroupDBContext();
        HttpSession session = req.getSession();
        Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
        List<StudentGroup> studentgroup = db.getStudentGroupByLecturerId(lecturer.getId());
        req.setAttribute("studentgroup", studentgroup);
        
        if(req.getParameter("groupchoosen") != null){
            req.getSession().removeAttribute("mess");
            int groupchoosen = Integer.parseInt(req.getParameter("groupchoosen"));
            req.setAttribute("listStudent", db.getAllStudentByGroupId(groupchoosen));
            req.setAttribute("listLession", db.getAllLessionByGroupId(groupchoosen));
            req.setAttribute("listAttendence", db.getAllAttendenceByGroupId(groupchoosen));
            req.setAttribute("groupchoosen", groupchoosen);
        }
        
        req.getRequestDispatcher("../view/lecturer/presentreport.jsp").forward(req, resp);
    }

}
