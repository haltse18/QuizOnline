/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.question;

import halt.util.DBHelpers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Luong Thanh Ha
 */
public class QnADAO {

    public boolean insertQuestion(QuestionDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        int rs = 0;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO "
                        + "tbl_Question(question_content, subjectID, createDate, [status]) "
                        + "VALUES(?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.content);
                stm.setString(2, dto.subjectID);
                stm.setTimestamp(3, dto.createDate);
                stm.setString(4, dto.status);
                rs = stm.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean deleteQuestion(int id) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        int rs = 0;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "DELETE FROM "
                        + "tbl_Question "
                        + "WHERE id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);

                rs = stm.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean deleteAnswer(int id) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        int rs = 0;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "DELETE FROM "
                        + "tbl_Answer "
                        + "WHERE questionID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);

                rs = stm.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean insertAnswer(ArrayList<AnswerDTO> list) throws NamingException, SQLException {
        Connection con = null;
        Statement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                con.setAutoCommit(false);
                stm = con.createStatement();
                for (AnswerDTO answerDTO : list) {
                    String sql = "INSERT INTO "
                            + "tbl_Answer(questionID, answer_content, correct) "
                            + "VALUES(" + answerDTO.questionID + ",'" + answerDTO.content + "','" + answerDTO.correct + "')";
                    stm.addBatch(sql);
                }

                int count = stm.executeBatch().length;
                con.commit();
                if (count == list.size()) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }
    
    public boolean updateAnswer(ArrayList<AnswerDTO> list) throws NamingException, SQLException {
        Connection con = null;
        Statement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                con.setAutoCommit(false);
                stm = con.createStatement();
                for (AnswerDTO answerDTO : list) {
                    String sql = "UPDATE "
                            + "tbl_Answer "
                            + "SET  answer_content='" + answerDTO.content + "', correct= '" + answerDTO.correct + "'"
                            + " WHERE id = " + answerDTO.id;
                    stm.addBatch(sql);
                }

                int count = stm.executeBatch().length;
                con.commit();
                if (count == list.size()) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public int getLastQuestionID() throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT max(id) as id "
                        + "FROM tbl_Question";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();

                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return -1;
    }

    public HashMap<String, String> getAllSubject() throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        HashMap<String, String> map = new HashMap<>();
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT id, name "
                        + "FROM tbl_Subject";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();

                while (rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    map.put(id, name);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return map;
    }

    public ArrayList<AnswerDTO> searchAnswer(int questionId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<AnswerDTO> list = new ArrayList<>();
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {

                String sql = "SELECT id, answer_content, correct "
                        + "FROM tbl_Answer "
                        + "WHERE questionID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, questionId);
                rs = stm.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String content = rs.getString("answer_content");
                    boolean correct = rs.getBoolean("correct");
                    AnswerDTO ans = new AnswerDTO(id, questionId, content, correct,false);
                    list.add(ans);
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
    
    public ArrayList<QuestionDTO> searchQuestions(String searchvalue, String iSubjectID, String iStatus) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<QuestionDTO> list = new ArrayList<>();
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {

                String sql = "SELECT id, question_content, subjectID, createDate, status "
                        + "FROM tbl_Question "
                        + "WHERE question_content LIKE ? AND subjectID LIKE ? AND status LIKE ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchvalue + "%");
                stm.setString(2, iSubjectID + "%");
                stm.setString(3, iStatus + "%");
                rs = stm.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String content = rs.getString("question_content");
                    String subjectID = rs.getString("subjectID");
                    Timestamp createDate = rs.getTimestamp("createDate");
                    String status = rs.getString("status");
                    QuestionDTO question = new QuestionDTO(id, content, subjectID, createDate, status);
                    list.add(question);
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
    
     public boolean updateQuestion(QuestionDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        int rs = 0;
        ArrayList<QuestionDTO> list = new ArrayList<>();
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {

                String sql = "UPDATE "
                        + " tbl_Question SET question_content= ?, subjectID = ? ,status = ? "
                        + "WHERE id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.content);
                stm.setString(2, dto.subjectID);
                stm.setString(3, dto.status);
                stm.setInt(4, dto.id);
                rs = stm.executeUpdate();

                if (rs > 0) {
                    return true;
                }

            }
        } finally {
            
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    
    
    public QuestionDTO getQuestion(int id) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {

                String sql = "SELECT id, question_content, subjectID, createDate, status "
                        + "FROM tbl_Question "
                        + "WHERE id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();

                while (rs.next()) {
                    
                    String content = rs.getString("question_content");
                    String subjectID = rs.getString("subjectID");
                    Timestamp createDate = rs.getTimestamp("createDate");
                    String status = rs.getString("status");
                    QuestionDTO question = new QuestionDTO(id, content, subjectID, createDate, status);
                    return question;
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }
    
    public String getSubjectName(String id) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {

                String sql = "SELECT name "
                        + "FROM tbl_Subject "
                        + "WHERE id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();

                while (rs.next()) {
                    
                    String name = rs.getString("name");
                   
                    return name;
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }
    
}
