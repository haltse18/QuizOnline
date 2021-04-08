/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.quiz;

import java.sql.Timestamp;

/**
 *
 * @author Luong Thanh Ha
 */
public class QuizDTO {
    int id;
    String userID;
    String subjectID;
    double mark;
    Timestamp time;

    public QuizDTO(int id, String userID, String subjectID, double mark, Timestamp time) {
        this.id = id;
        this.userID = userID;
        this.subjectID = subjectID;
        this.mark = mark;
        this.time = time;
    }

    public QuizDTO(String userID, String subjectID, double mark, Timestamp time) {
        this.userID = userID;
        this.subjectID = subjectID;
        this.mark = mark;
        this.time = time;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public double getMark() {
        return mark;
    }

    public void setMark(double mark) {
        this.mark = mark;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "QuizDTO{" + "id=" + id + ", userID=" + userID + ", subjectID=" + subjectID + ", mark=" + mark + ", time=" + time + '}';
    }

    
    
    
}
