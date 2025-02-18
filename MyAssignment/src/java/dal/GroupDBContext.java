/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package dal;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import moder.Attendence;
import moder.Lecturers;
import moder.Lession;
import moder.Room;
import moder.Students;
import moder.StudentsGroup;
import moder.Subjects;

/**
 *
 * @author nam
 */
public class GroupDBContext extends DBContext<Students> {

    public List<StudentsGroup> getStudentGroupByLecturerId(int lname) {
        List<StudentsGroup> group = new ArrayList<>();
        try {
            String sql = "select sg.gid, sg.gname, su.subid, su.suname from StudentGroup sg\n"
                    + "inner join Subject su on sg.subid = su.subid\n"
                    + "where lid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lname);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Subjects su = new Subjects();
                StudentsGroup sg = new StudentsGroup();
                su.setId(rs.getInt("subid"));
                su.setName(rs.getString("suname"));
                sg.setSubject(su);
                sg.setId(rs.getInt("gid"));
                sg.setName(rs.getString("gname"));
                group.add(sg);
            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return group;
    }

    public ArrayList<Students> getAllStudentByGroupId(int lname) {
        ArrayList<Students> students = new ArrayList<>();
        try {
            String sql = "select s.sid, s.sname from Student s\n"
                    + "join Enrollment e on s.sid = e.sid\n"
                    + "join StudentGroup sg on sg.gid = e.gid\n"
                    + "where sg.gid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lname);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Students student = new Students();
                student.setId(rs.getInt("sid"));
                student.setName(rs.getString("sname"));
                students.add(student);
            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return students;
    }

    public ArrayList<Lession> getAllLessionByGroupId(int groupid) {
        ArrayList<Lession> lessions = new ArrayList<>();
        try {
            String sql = "select l.leid, l.isAttended, l.gid, l.date, l.rid, r.rname, sg.gname, lec.lid, lec.lname from Lession l\n"
                    + "                    join StudentGroup sg on sg.gid = l.gid\n"
                    + "                    join Room r on r.rid = l.rid\n"
                    + "                    join Lecturer lec on lec.lid = l.lid\n"
                    + "                    where sg.gid = ?\n"
                    + "                    order by l.date asc";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, groupid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("rid"));
                r.setName(rs.getString("rname"));
                Lecturers lec = new Lecturers();
                lec.setId(rs.getInt("lid"));
                lec.setName(rs.getString("lname"));
                StudentsGroup sg = new StudentsGroup();
                sg.setId(rs.getInt("gid"));
                sg.setName(rs.getString("gname"));
                Lession l = new Lession();
                l.setGroup(sg);
                l.setId(rs.getInt("leid"));
                l.setAttended(rs.getBoolean("isAttended"));
                l.setDate(rs.getDate("date"));
                l.setRoom(r);
                l.setLecturer(lec);
                lessions.add(l);

            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lessions;
    }

    public ArrayList<Attendence> getAllAttendenceByGroupId(int groupid) {
        ArrayList<Attendence> attendences = new ArrayList<>();
        try {
            String sql = "select a.* from Attendence a\n"
                    + "	join Lession l on  l.leid = a.leid\n"
                    + "	where l.gid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, groupid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Students s = new Students();
                s.setId(rs.getInt("sid"));
                Lession l = new Lession();
                l.setId(rs.getInt("leid"));
                Attendence a = new Attendence();
                a.setId(rs.getInt("aid"));
                a.setLession(l);
                a.setStudent(s);
                a.setDescription(rs.getString("description"));
                a.setPresent(rs.getBoolean("isPresent"));
                a.setTime(rs.getDate("capturedtime"));
                attendences.add(a);

            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attendences;
    }

    public ArrayList<Attendence> getAllAttendenceByStudentId(int student) {
        ArrayList<Attendence> attendences = new ArrayList<>();
        try {
            String sql = "select att.*, st.sname from Attendence att\n"
                    + "join Student st on st.sid = att.sid\n"
                    + "join Lession l on l.leid = att.leid\n"
                    + "where st.sid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, student);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Students s = new Students();
                s.setId(rs.getInt("sid"));
                s.setName(rs.getString("sname"));
                Lession l = new Lession();
                l.setId(rs.getInt("leid"));
                Attendence a = new Attendence();
                a.setId(rs.getInt("aid"));
                a.setLession(l);
                a.setStudent(s);
                a.setDescription(rs.getString("description"));
                a.setPresent(rs.getBoolean("isPresent"));
                a.setTime(rs.getDate("capturedtime"));
                attendences.add(a);

            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attendences;
    }

    public Lecturers getLecturerByUsername(String username) {
        Lecturers lecturer = new Lecturers();
        try {
            String sql = "select * from Lecturer where lname = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                lecturer.setId(rs.getInt(1));
                lecturer.setName(rs.getString(2));
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoleDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lecturer;
    }

    public ArrayList<StudentsGroup> getAllStudentGroupByStudentId(int studentId) {
        ArrayList<StudentsGroup> listGroup = new ArrayList<>();
        try {
            String sql = "select sg.*, s.suname from StudentGroup sg\n"
                    + "join Enrollment e on e.gid = sg.gid\n"
                    + "join Subject s on s.subid = sg.subid\n"
                    + "where e.sid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Subjects sb = new Subjects();
                sb.setId(rs.getInt("subid"));
                sb.setName(rs.getString("suname"));
                StudentsGroup sg = new StudentsGroup();
                sg.setId(rs.getInt("gid"));
                sg.setName(rs.getString("gname"));
                sg.setSubject(sb);
                listGroup.add(sg);
            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listGroup;
    }

    @Override
    public ArrayList<Students> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Students entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Students entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Students entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Students get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
