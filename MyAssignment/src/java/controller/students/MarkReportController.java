/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.students;

import controller.authentication.authorization.BaseRBACController;
import dal.GroupDBContext;
import dal.ScoreDBContext;
import moder.Account;
import moder.Role;
import moder.ScoreType;
import moder.Students;
import moder.StudentsGroup;
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
 * @author nam
 */
public class MarkReportController extends BaseRBACController {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MarkReportController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarkReportController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account, ArrayList<Role> roles)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Students student = (Students)session.getAttribute("student");
        GroupDBContext gdb = new GroupDBContext();
        List<StudentsGroup> listgroup = gdb.getAllStudentGroupByStudentId(student.getId());
        
        
        if (request.getParameter("subjectchoosen") != null) {
            ScoreDBContext sdb = new ScoreDBContext();
            String[] array = request.getParameter("subjectchoosen").split(",");
            int subjectchoosen = Integer.parseInt(array[0]);
            int groupchoosen = Integer.parseInt(array[1]);
            List<ScoreType> listScoreType = sdb.getScoreTypeBySubjectId(subjectchoosen);
            request.setAttribute("listScoreType", listScoreType);
            request.setAttribute("subjectchoosen", subjectchoosen);
            request.setAttribute("listScore", sdb.getAllScoreByGroupIdAndSubjectId(groupchoosen, subjectchoosen));
        }
        
        request.setAttribute("listgroup", listgroup);
        request.getRequestDispatcher("../view/student/studentmarkreport.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account, ArrayList<Role> roles)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
