/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.student;

import controller.authentication.authorization.BaseRBACController;
import dal.GroupDBContext;
import dal.LessionDBContext;
import dal.TimeSlotDBContext;
import entity.Account;
import entity.Attendence;
import entity.Lession;
import entity.Role;
import entity.TimeSlot;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import util.DateTimeHelper;

/**
 *
 * @author DEll
 */
public class TimeTableController extends BaseRBACController {
   
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
            out.println("<title>Servlet TimeTableController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TimeTableController at " + request.getContextPath () + "</h1>");
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
        GroupDBContext gdb = new GroupDBContext();
        int sid = Integer.parseInt(request.getParameter("id"));
        String raw_from = request.getParameter("from");
        String raw_to = request.getParameter("to");
        java.sql.Date from = null;
        java.sql.Date to = null;
        
        Date today = new Date();
        if(raw_from ==null)
        {
            from = DateTimeHelper.convertUtilDateToSqlDate(DateTimeHelper.getWeekStart(today));
        }
        else
        {
            from = java.sql.Date.valueOf(raw_from);
        }
        
        if(raw_to ==null)
        {
            to =DateTimeHelper.convertUtilDateToSqlDate(
                    DateTimeHelper.addDaysToDate(DateTimeHelper.getWeekStart(today),6));
        }
        else
        {
            to = java.sql.Date.valueOf(raw_to);
        }
        
        ArrayList<java.sql.Date> dates = DateTimeHelper.getListBetween(
                DateTimeHelper.convertSqlDateToUtilDate(from), 
                DateTimeHelper.convertSqlDateToUtilDate(to));
        
        TimeSlotDBContext slotDB = new TimeSlotDBContext();
        ArrayList<TimeSlot> slots = slotDB.list();
        
        LessionDBContext lessDB = new LessionDBContext();
        ArrayList<Lession> lessions = lessDB.getStudentLessionByStudentID(sid, from, to);
        ArrayList<Attendence> listAttendences = gdb.getAllAttendenceByStudentId(sid);
        request.setAttribute("listAttendences", listAttendences);
        request.setAttribute("slots", slots);
        request.setAttribute("dates", dates);
        request.setAttribute("from", from);
        request.setAttribute("to", to);
        request.setAttribute("lessions", lessions);
        request.getRequestDispatcher("../view/student/studenttimetable.jsp").forward(request, response);
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
