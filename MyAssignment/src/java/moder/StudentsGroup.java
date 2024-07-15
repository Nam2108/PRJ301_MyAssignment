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
public class StudentsGroup {
    private int id;
    private String name;
    private ArrayList<Students> students = new ArrayList<>();
    private Lecturers lecturer; 
    private Subjects subject;

    public Lecturers getLecturer() {
        return lecturer;
    }

    public void setLecturer(Lecturers lecturer) {
        this.lecturer = lecturer;
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
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
