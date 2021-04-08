/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.question;

import java.sql.Timestamp;

/**
 *
 * @author Luong Thanh Ha
 */
public class QuestionDTO {
    int id;
    String content;
    String subjectID;
    Timestamp createDate;
    String status;

    public QuestionDTO(String content, String subjectID, Timestamp createDate, String status) {
        this.content = content;
        this.subjectID = subjectID;
        this.createDate = createDate;
        this.status = status;
    }

    public QuestionDTO(String content, String subjectID, String status) {
        this.content = content;
        this.subjectID = subjectID;
        this.status = status;
    }

    
    public QuestionDTO(int id, String content, String subjectID, Timestamp createDate, String status) {
        this.id = id;
        this.content = content;
        this.subjectID = subjectID;
        this.createDate = createDate;
        this.status = status;
    }

    public QuestionDTO(int id, String content, String subjectID, String status) {
        this.id = id;
        this.content = content;
        this.subjectID = subjectID;
        this.status = status;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "QuestionDTO{" + "id=" + id + ", content=" + content + ", subjectID=" + subjectID + ", createDate=" + createDate + ", status=" + status + '}';
    }
    
    
}
