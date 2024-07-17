/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package moder;

import java.util.ArrayList;

/**
 *
 * @author nam
 */
public class ScoreType {
    private int sctid;
    private String sctname;
    private String sctpercent;
    private Subjects subject;
    ArrayList<Students> students;

    public ScoreType() {
    }

    public ScoreType(int sctid, String sctname, String sctpercent, Subjects subject, ArrayList<Students> students) {
        this.sctid = sctid;
        this.sctname = sctname;
        this.sctpercent = sctpercent;
        this.subject = subject;
        this.students = students;
    }

    public int getSctid() {
        return sctid;
    }

    public void setSctid(int sctid) {
        this.sctid = sctid;
    }

    public String getSctname() {
        return sctname;
    }

    public void setSctname(String sctname) {
        this.sctname = sctname;
    }

    public String getSctpercent() {
        return sctpercent;
    }

    public void setSctpercent(String sctpercent) {
        this.sctpercent = sctpercent;
    }

    public Subjects getSubject() {
        return subject;
    }

    public void setSubject(Subjects subject) {
        this.subject = subject;
    }

    public ArrayList<Students> getStudents() {
        return students;
    }

    public void setStudents(ArrayList<Students> students) {
        this.students = students;
    }

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
    
}
