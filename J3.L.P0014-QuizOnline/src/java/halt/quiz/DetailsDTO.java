/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.quiz;

/**
 *
 * @author Luong Thanh Ha
 */
public class DetailsDTO {

    int id;
    int quizID;
    int questionID;
    int answerID;

    public DetailsDTO(int id, int quizID, int questionID, int answerID) {
        this.id = id;
        this.quizID = quizID;
        this.questionID = questionID;
        this.answerID = answerID;
    }

    public DetailsDTO(int quizID, int questionID, int answerID) {
        this.quizID = quizID;
        this.questionID = questionID;
        this.answerID = answerID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public int getAnswerID() {
        return answerID;
    }

    public void setAnswerID(int answerID) {
        this.answerID = answerID;
    }

}
