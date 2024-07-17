/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.lecturer;

import controller.authentication.authorization.BaseRBACController;
import dal.GroupDBContext;
import dal.LessionDBContext;
import dal.ScoreDBContext;
import dal.TimeSlotDBContext;
import moder.Account;
import moder.Lecturers;
import moder.Lession;
import moder.Role;
import moder.Score;
import moder.ScoreType;
import moder.Students;
import moder.StudentsGroup;
import moder.TimeSlost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import util.DateTimeHelper;
/**
 *
 * @author nam
 */
public class MarkReportController extends BaseRBACController {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Account account, ArrayList<Role> roles) throws ServletException, IOException {

        GroupDBContext db = new GroupDBContext();
        ScoreDBContext sdb = new ScoreDBContext();
        int groupchoosen = Integer.parseInt(req.getParameter("groupchoosen"));
        int subjectchoosen = Integer.parseInt(req.getParameter("subjectchoosen"));
        List<Students> listStudent = db.getAllStudentByGroupId(groupchoosen);
        List<ScoreType> listScoreType = sdb.getScoreTypeBySubjectId(subjectchoosen);
        List<Score> listScore = new ArrayList<>();
        for (Students student : listStudent) {
            for (ScoreType scoreType : listScoreType) {
                double score = Double.parseDouble(req.getParameter("score" + student.getId() + "and" + scoreType.getSctid()));
                Score scoreObj = new Score();
                scoreObj.setScore(score);
                scoreObj.setStudent(student);
                scoreObj.setScoreType(scoreType);
                listScore.add(scoreObj);
//                PrintWriter out = resp.getWriter();
//                out.print(student.getName() + " " + scoreType.getSctname() + " " + scoreObj.getScore() + "\n");
            }
        }

        int flag = 0;
        List<Score> score1st = sdb.getAllScoreByGroupIdAndSubjectId(groupchoosen, subjectchoosen);
        if (score1st.size() < listScore.size()) {
            req.setAttribute("messageAlert", "Save successfully!");
        } else {
            for (int i = 0; i < listScore.size(); i++) {
                if (score1st.get(i).getScore() != listScore.get(i).getScore()) {
                    flag = 1;
                }
            }
            if(flag == 1){
                req.setAttribute("messageAlert", "Save successfully!");
            }
        }

        sdb.UpdateScoreByGroupIdAndSubjetId(listScore, groupchoosen, subjectchoosen);
        req.setAttribute("groupchoosen", groupchoosen);
        req.setAttribute("subjectchoosen", subjectchoosen);
//        req.setAttribute("messageAlert", "Save successfully!");
        doGet(req, resp, account, roles);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, Account account, ArrayList<Role> roles) throws ServletException, IOException {
        GroupDBContext db = new GroupDBContext();
        ScoreDBContext sdb = new ScoreDBContext();
        HttpSession session = req.getSession();
        //in ra lowps theo lecturer id
        Lecturers lecturer = (Lecturers) session.getAttribute("lecturer");
        List<StudentsGroup> studentgroup = db.getStudentGroupByLecturerId(lecturer.getId());
        if (req.getParameter("groupchoosen") != null) {
            int groupchoosen = Integer.parseInt(req.getParameter("groupchoosen"));//id lop
            req.setAttribute("listStudent", db.getAllStudentByGroupId(groupchoosen));
            int subjectchoosen = Integer.parseInt(req.getParameter("subjectchoosen"));//id mon hoc
            req.setAttribute("listScoreType", sdb.getScoreTypeBySubjectId(subjectchoosen));
            ScoreDBContext scdb = new ScoreDBContext();
            req.setAttribute("listScore", scdb.getAllScoreByGroupIdAndSubjectId(groupchoosen, subjectchoosen));
            req.setAttribute("groupchoosen", groupchoosen);
            req.setAttribute("subjectchoosen", subjectchoosen);
        }
        req.setAttribute("studentgroup", studentgroup);
        req.getRequestDispatcher("../view/lecturer/markreport.jsp").forward(req, resp);

    }
}
