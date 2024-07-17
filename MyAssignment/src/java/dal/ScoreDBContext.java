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
import moder.Score;
import moder.ScoreType;
import moder.Students;
import moder.Subjects;

/**
 *
 * @author nam
 */
public class ScoreDBContext extends DBContext<Students> {

    public List<ScoreType> getScoreTypeBySubjectId(int subjectId) {
        List<ScoreType> scores = new ArrayList<>();
        try {
            String sql = "select sc.sctid, sc.sctname, sc.sctpercent, su.subid, su.suname from ScoreType sc \n"
                    + "join Subject su on su.subid = sc.subid\n"
                    + "where su.subid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, subjectId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ScoreType scoreType = new ScoreType();
                Subjects subject = new Subjects();
                subject.setId(rs.getInt("subid"));
                subject.setName(rs.getString("suname"));
                scoreType.setSubject(subject);
                scoreType.setSctid(rs.getInt("sctid"));
                scoreType.setSctname(rs.getString("sctname"));
                scoreType.setSctpercent(rs.getString("sctpercent"));
                scores.add(scoreType);
            }

        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return scores;
    }

    public ArrayList<Score> getAllScoreByGroupIdAndSubjectId(int sgid, int subid) {
        ArrayList<Score> scores = new ArrayList<>();
        try {
            String sql = "  select sc.scid, sc.score,sc.sid, sct.sctid from Score sc\n"
                    + "  join ScoreType sct on sc.sctid = sct.sctid\n"
                    + "  join Subject su on su.subid = sct.subid\n"
                    + "  join StudentGroup sg on sg.subid = su.subid\n"
                    + "  where sct.subid = ? and sg.gid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, subid);
            stm.setInt(2, sgid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Students student = new Students();
                student.setId(rs.getInt("sid"));
                ScoreType scoreType = new ScoreType();
                scoreType.setSctid(rs.getInt("sctid"));
                Score score = new Score();
                score.setStudent(student);
                score.setScoreType(scoreType);
                score.setScid(rs.getInt("scid"));
                score.setScore(rs.getDouble("score"));
                scores.add(score);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ScoreDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return scores;
    }

    public void UpdateScoreByGroupIdAndSubjetId(List<Score> listScore, int groupchoosen, int subjectchoosen) {
        try {
            String sql_remove_score = "  Delete from Score where scid in (select sc.scid from Score sc\n"
                    + "  join ScoreType sct on sc.sctid = sct.sctid\n"
                    + "  join Subject su on su.subid = sct.subid\n"
                    + "  join StudentGroup sg on sg.subid = su.subid\n"
                    + "  where sct.subid = ? and sg.gid = ?)";
            PreparedStatement stm_remove_score = connection.prepareStatement(sql_remove_score);
            stm_remove_score.setInt(1, subjectchoosen);
            stm_remove_score.setInt(2, groupchoosen);
            stm_remove_score.executeUpdate();

            for (Score score : listScore) {
                String sql_insert_att = "Insert into Score(score, sid, sctid) values(?, ?, ?)";
                PreparedStatement stm_insert_att = connection.prepareStatement(sql_insert_att);
                stm_insert_att.setDouble(1, score.getScore());
                stm_insert_att.setInt(2, score.getStudent().getId());
                stm_insert_att.setInt(3, score.getScoreType().getSctid());
                stm_insert_att.executeUpdate();
            }
        }catch (SQLException ex) {
            Logger.getLogger(ScoreDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

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