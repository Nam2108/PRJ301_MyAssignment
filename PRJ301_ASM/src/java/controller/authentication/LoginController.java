/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authentication;

import dal.AccountDBContext;
import dal.StudentDBContext;
import entity.Account;
import entity.Lecturer;
import entity.Student;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 *
 */
public class LoginController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/authentication/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AccountDBContext db = new AccountDBContext();
        Account account = db.getByUsernamePassword(username, password);

        if (account != null) {
            //login success
            HttpSession session = request.getSession();
            StudentDBContext sdb = new StudentDBContext();
            Student student = sdb.getStudentByUsername(username);// lấy thông tin sinh viên qua username
            Lecturer lecturer = sdb.getLecturerByUsername(username);
            String remember = request.getParameter("remember");
            if (remember != null) {
                Cookie c_user = new Cookie("username", username);
                Cookie c_pass = new Cookie("password", password);

                c_user.setMaxAge(3600 * 24 * 7);
                c_pass.setMaxAge(3600 * 24 * 7);

                response.addCookie(c_pass);
                response.addCookie(c_user);
            }



            session.setAttribute("account", account);
            session.setAttribute("lecturer", lecturer);
            session.setAttribute("student", student);
            response.sendRedirect("homelecturer");
        } else {
            //login failed!
            String mess = "Wrong username or password";
            request.setAttribute("mess", mess);
            request.getRequestDispatcher("view/authentication/login.jsp").forward(request, response);

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
