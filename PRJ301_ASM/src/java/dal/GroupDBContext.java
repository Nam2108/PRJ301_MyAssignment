/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dal.DBContext;
import entity.Attendence;
import entity.Lecturer;
import entity.Lession;
import entity.Role;
import entity.Room;
import entity.Student;
import entity.StudentGroup;
import entity.Subject;
import java.lang.reflect.Array;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.jasper.tagplugins.jstl.core.ForEach;

/**
 *
 * @author nam
 */
public class GroupDBContext extends DBContext<Student> {

    public List<StudentGroup> getStudentGroupByLecturerId(int lname) {
        List<StudentGroup> group = new ArrayList<>();
        try {
            String sql = "select sg.gid, sg.gname, su.subid, su.suname from StudentGroup sg\n"
                    + "inner join Subject su on sg.subid = su.subid\n"
                    + "where lid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lname);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Subject su = new Subject();
                StudentGroup sg = new StudentGroup();
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

    public ArrayList<Student> getAllStudentByGroupId(int lname) {
        ArrayList<Student> students = new ArrayList<>();
        try {
            String sql = "select s.sid, s.sname, s.email from Student s\n"
                    + "join Enrollment e on s.sid = e.sid\n"
                    + "join StudentGroup sg on sg.gid = e.gid\n"
                    + "where sg.gid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lname);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("sid"));
                student.setName(rs.getString("sname"));
                student.setEmail(rs.getString("email"));
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
                Lecturer lec = new Lecturer();
                lec.setId(rs.getInt("lid"));
                lec.setName(rs.getString("lname"));
                StudentGroup sg = new StudentGroup();
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
                Student s = new Student();
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
                Student s = new Student();
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

    public Lecturer getLecturerByUsername(String username) {
        Lecturer lecturer = new Lecturer();
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

    public ArrayList<StudentGroup> getAllStudentGroupByStudentId(int studentId) {
        ArrayList<StudentGroup> listGroup = new ArrayList<>();
        try {
            String sql = "select sg.*, s.suname from StudentGroup sg\n"
                    + "join Enrollment e on e.gid = sg.gid\n"
                    + "join Subject s on s.subid = sg.subid\n"
                    + "where e.sid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Subject sb = new Subject();
                sb.setId(rs.getInt("subid"));
                sb.setName(rs.getString("suname"));
                StudentGroup sg = new StudentGroup();
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
    public ArrayList<Student> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Student entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Student entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Student entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Student get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
