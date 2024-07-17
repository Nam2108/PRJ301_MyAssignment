/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;

/**
 *
 * @author sonnt
 */
public class Student {
    private int id;
    private String name;
    private String email;
    private ArrayList<StudentGroup> groups = new ArrayList<>();
    private ArrayList<ScoreType> scores = new ArrayList<>();

    public Student() {
    }

    public Student(int id, String name, String email) {
        this.id = id;
        this.name = name;
        this.email = email;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public ArrayList<StudentGroup> getGroups() {
        return groups;
    }

    public void setGroups(ArrayList<StudentGroup> groups) {
        this.groups = groups;
    }

    public ArrayList<ScoreType> getScores() {
        return scores;
    }

    public void setScores(ArrayList<ScoreType> scores) {
        this.scores = scores;
    }

    
}
