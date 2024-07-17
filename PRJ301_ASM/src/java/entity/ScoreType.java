/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.lang.reflect.Array;
import java.util.ArrayList;

/**
 *
 * @author DEll
 */
public class ScoreType {
    private int sctid;
    private String sctname;
    private String sctpercent;
    private Subject subject;
    ArrayList<Student> students;

    public ScoreType() {
    }

    public ScoreType(int sctid, String sctname, String sctpercent, Subject subject, ArrayList<Student> students) {
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

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public ArrayList<Student> getStudents() {
        return students;
    }

    public void setStudents(ArrayList<Student> students) {
        this.students = students;
    }

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
    
}
