/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.records;

import java.util.HashMap;

/**
 *
 * @author Luong Thanh Ha
 */
public class AnswerRecords {

    public HashMap<Integer, Boolean> records;
    public HashMap<Integer, Integer> details;

    public AnswerRecords(HashMap<Integer, Boolean> records) {
        this.records = records;
    }
    
    
    public AnswerRecords() {
        records = new HashMap<>();
        details = new HashMap<>();
    }

    public void addAnswer(int questionid, boolean correct) {
        if (this.records == null) {
            this.records = new HashMap<>();

        }
        if (this.records.containsKey(questionid)) {
            this.records.replace(questionid, correct);
            return;
        }
        this.records.put(questionid, correct);
    }
    
    public void addDetail(int questionid, int answerid) {
        if (this.details == null) {
            this.details = new HashMap<>();

        }
        if (this.details.containsKey(questionid)) {
            this.details.replace(questionid, answerid);
            return;
        }
        this.details.put(questionid, answerid);
    }
    
    public int getResult(int noq){
        //int gap = 10/noq;
        int mark = 0;
        for (Boolean value : this.records.values()) {
            if (value == true) {
              mark += 1; 
            }
        }
        return mark;
    }
    
    public double getMark(int noq){
        double gap = 10/noq;
        double mark = 0;
        for (Boolean value : this.records.values()) {
            if (value == true) {
              mark += gap; 
            }
        }
        return mark;
    }
    

}
