/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.question;

/**
 *
 * @author Luong Thanh Ha
 */
public class AnswerDTO {
    int id;
    int questionID;
    String content;
    boolean correct;
    boolean check;

    public AnswerDTO(int id, int questionID, String content, boolean correct, boolean check) {
        this.id = id;
        this.questionID = questionID;
        this.content = content;
        this.correct = correct;
        this.check = check;
    }

    public boolean isCheck() {
        return check;
    }

    public void setCheck(boolean check) {
        this.check = check;
    }
    

    public AnswerDTO(int id, int questionID, String content, boolean correct) {
        this.id = id;
        this.questionID = questionID;
        this.content = content;
        this.correct = correct;
    }

    public AnswerDTO(int questionID, String content, boolean correct) {
        this.questionID = questionID;
        this.content = content;
        this.correct = correct;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isCorrect() {
        return correct;
    }

    public void setCorrect(boolean correct) {
        this.correct = correct;
    }

    @Override
    public String toString() {
        return "AnswerDTO{" + "id=" + id + ", questionID=" + questionID + ", content=" + content + ", correct=" + correct + '}';
    }

    
    
    
}
