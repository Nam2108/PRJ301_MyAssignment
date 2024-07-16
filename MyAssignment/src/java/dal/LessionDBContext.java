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
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import moder.Attendence;
import moder.Lecturers;
import moder.Lession;
import moder.Room;
import moder.Students;
import moder.StudentsGroup;
import moder.Subjects;
import moder.TimeSlost;

/**
 *
 * @author nam
 */
public class LessionDBContext extends DBContext<Lession> {

    public void takeAttendances(int leid, ArrayList<Attendence> atts) {
        try {
            connection.setAutoCommit(false);
            String sql_remove_atts = "DELETE Attendence WHERE leid = ?";
            PreparedStatement stm_remove_atts = connection.prepareStatement(sql_remove_atts);
            stm_remove_atts.setInt(1, leid);
            stm_remove_atts.executeUpdate();

            for (Attendence att : atts) {
                String sql_insert_att = "INSERT INTO [Attendence]\n"
                        + "           ([leid]\n"
                        + "           ,[sid]\n"
                        + "           ,[description]\n"
                        + "           ,[isPresent]\n"
                        + "           ,[capturedtime])\n"
                        + "     VALUES\n"
                        + "           (?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,GETDATE())";
                PreparedStatement stm_insert_att = connection.prepareStatement(sql_insert_att);
                stm_insert_att.setInt(1, leid);
                stm_insert_att.setInt(2, att.getStudent().getId());
                stm_insert_att.setString(3, att.getDescription());
                stm_insert_att.setBoolean(4, att.isPresent());
                stm_insert_att.executeUpdate();
            }

            String sql_update_lession = "UPDATE Lession SET isAttended = 1 WHERE leid =?";
            PreparedStatement stm_update_lession = connection.prepareStatement(sql_update_lession);
            stm_update_lession.setInt(1, leid);
            stm_update_lession.executeUpdate();

            connection.commit();
        } catch (SQLException ex) {
            Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    public void takeAttendances2(int leid, ArrayList<Attendence> atts) {
        try {

            for (Attendence att : atts) {
                String sql_insert_att = "UPDATE Attendence SET description = ?, isPresent = ?, capturedtime = getdate() WHERE aid = ?";
                PreparedStatement stm_insert_att = connection.prepareStatement(sql_insert_att);
                stm_insert_att.setString(1, att.getDescription());
                stm_insert_att.setBoolean(2, att.isPresent());
                stm_insert_att.setInt(3, att.getId());
                stm_insert_att.executeUpdate();
            }

            String sql_update_lession = "UPDATE Lession SET isAttended = 1 WHERE leid =?";
            PreparedStatement stm_update_lession = connection.prepareStatement(sql_update_lession);
            stm_update_lession.setInt(1, leid);
            stm_update_lession.executeUpdate();

            connection.commit();
        } catch (SQLException ex) {
            ex.printStackTrace();
            Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
        }

    }

    public boolean isAttended(int leid) {
        boolean isAttended = false;
        try {
            String sql = "SELECT * FROM Lession where leid = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, leid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                isAttended = rs.getBoolean("isAttended");
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return isAttended;

    }

    public ArrayList<Students> getStudentsByLession(int leid) {
        ArrayList<Students> students = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "s.sid,s.sname\n"
                    + "FROM Student s INNER JOIN Enrollment e ON s.sid = e.sid\n"
                    + "						INNER JOIN StudentGroup g ON g.gid = e.gid\n"
                    + "						INNER JOIN Lession les ON les.gid = g.gid\n"
                    + "WHERE les.leid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, leid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Students s = new Students();
                s.setId(rs.getInt("sid"));
                s.setName(rs.getString("sname"));
                students.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return students;
    }

    public ArrayList<Attendence> getAttendencesByLession(int leid) {
        ArrayList<Attendence> atts = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "s.sid,s.sname,\n"
                    + "a.aid,a.description,a.isPresent,a.capturedtime\n"
                    + "FROM Student s INNER JOIN Enrollment e ON s.sid = e.sid\n"
                    + "						INNER JOIN StudentGroup g ON g.gid = e.gid\n"
                    + "						INNER JOIN Lession les ON les.gid = g.gid\n"
                    + "						LEFT JOIN Attendence a ON a.leid = les.leid AND a.sid = s.sid\n"
                    + "WHERE les.leid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, leid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Attendence a = new Attendence();
                Students s = new Students();
                Lession les = new Lession();
                s.setId(rs.getInt("sid"));
                s.setName(rs.getString("sname"));
                a.setStudent(s);

                les.setId(leid);
                a.setLession(les);

                a.setId(rs.getInt("aid"));
                if (a.getId() != 0) {
                    a.setDescription(rs.getString("description"));
                    a.setPresent(rs.getBoolean("isPresent"));
                    a.setTime(rs.getTimestamp("capturedtime"));
                }
                atts.add(a);
            }

        } catch (SQLException ex) {
            Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return atts;
    }

    public ArrayList<Lession> getBy(int lid, Date from, Date to) {
        ArrayList<Lession> lessions = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "les.leid,les.isAttended,les.date,\n"
                    + "g.gid,g.gname,su.subid,su.suname,\n"
                    + "t.tid,t.tname,\n"
                    + "r.rid,r.rname,\n"
                    + "l.lid,l.lname\n"
                    + "FROM Lession les INNER JOIN StudentGroup g ON les.gid = g.gid\n"
                    + "				INNER JOIN Subject su ON su.subid = g.subid\n"
                    + "				INNER JOIN TimeSlot t ON t.tid = les.tid\n"
                    + "				INNER JOIN Room r ON r.rid = les.rid\n"
                    + "				INNER JOIN Lecturer l ON l.lid = les.lid\n"
                    + "WHERE les.lid = ? AND les.[date] >= ? and les.[date]<=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lid);
            stm.setDate(2, from);
            stm.setDate(3, to);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lession les = new Lession();
                StudentsGroup g = new StudentsGroup();
                Subjects s = new Subjects();
                TimeSlost slot = new TimeSlost();
                Room r = new Room();
                Lecturers l = new Lecturers();

                les.setId(rs.getInt("leid"));
                les.setAttended(rs.getBoolean("isAttended"));
                les.setDate(rs.getDate("date"));

                g.setId(rs.getInt("gid"));
                g.setName(rs.getString("gname"));
                s.setId(rs.getInt("subid"));
                s.setName(rs.getString("suname"));
                g.setSubject(s);
                les.setGroup(g);

                slot.setId(rs.getInt("tid"));
                slot.setName(rs.getString("tname"));
                les.setSlot(slot);

                r.setId(rs.getInt("rid"));
                r.setName(rs.getString("rname"));
                les.setRoom(r);

                l.setId(rs.getInt("lid"));
                l.setName(rs.getString("lname"));
                les.setLecturer(l);

                lessions.add(les);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lessions;

    }

    public ArrayList<Lession> getStudentLessionByStudentID(int sid, Date from, Date to) {
        ArrayList<Lession> lessions = new ArrayList<>();
        try {
            String sql = "SELECT\n"
                    + "les.leid,les.isAttended,les.date,\n"
                    + "g.gid,g.gname,su.subid,su.suname,\n"
                    + "t.tid,t.tname,\n"
                    + "r.rid,r.rname, les.lid\n"
                    + "FROM Lession les INNER JOIN StudentGroup g ON les.gid = g.gid\n"
                    + "INNER JOIN Subject su ON su.subid = g.subid\n"
                    + "INNER JOIN TimeSlot t ON t.tid = les.tid\n"
                    + "INNER JOIN Room r ON r.rid = les.rid\n"
                    + "INNER JOIN Enrollment enrol on enrol.gid = g.gid\n"
                    + "INNER JOIN Student st on st.sid = enrol.sid\n"
                    + "WHERE st.sid = ? AND les.[date] >= ? and les.[date]<= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, sid);
            stm.setDate(2, from);
            stm.setDate(3, to);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lession les = new Lession();
                StudentsGroup g = new StudentsGroup();
                Subjects s = new Subjects();
                TimeSlost slot = new TimeSlost();
                Room r = new Room();
                Lecturers l = new Lecturers();

                les.setId(rs.getInt("leid"));
                les.setAttended(rs.getBoolean("isAttended"));
                les.setDate(rs.getDate("date"));

                g.setId(rs.getInt("gid"));
                g.setName(rs.getString("gname"));
                s.setId(rs.getInt("subid"));
                s.setName(rs.getString("suname"));
                g.setSubject(s);
                les.setGroup(g);

                slot.setId(rs.getInt("tid"));
                slot.setName(rs.getString("tname"));
                les.setSlot(slot);

                r.setId(rs.getInt("rid"));
                r.setName(rs.getString("rname"));
                les.setRoom(r);

                l.setId(rs.getInt("lid"));

                les.setLecturer(l);

                lessions.add(les);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return lessions;

    }

    @Override
    public ArrayList<Lession> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Lession moder) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Lession moder) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Lession moder) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Lession get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}