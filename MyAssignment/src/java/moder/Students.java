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
public class Students {
    private int id;
    private String name;
    private ArrayList<StudentsGroup> groups = new ArrayList<>();
    private ArrayList<ScoreType> scores = new ArrayList<>();

    public Students() {
    }

    public Students(int id, String name) {
        this.id = id;
        this.name = name;
 
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
    

    public ArrayList<StudentsGroup> getGroups() {
        return groups;
    }

    public void setGroups(ArrayList<StudentsGroup> groups) {
        this.groups = groups;
    }

    public ArrayList<ScoreType> getScores() {
        return scores;
    }

    public void setScores(ArrayList<ScoreType> scores) {
        this.scores = scores;
    }
}
