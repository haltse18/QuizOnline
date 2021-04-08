/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.quiz;

import halt.util.DBHelpers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import javax.naming.NamingException;

/**
 *
 * @author Luong Thanh Ha
 */
public class QuizDAO {

    public boolean insertQuiz(QuizDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        int rs = 0;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO "
                        + "tbl_Quiz(subjectID, userID, mark, time) "
                        + "VALUES(?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.subjectID);
                stm.setString(2, dto.userID);
                stm.setDouble(3, dto.mark);
                stm.setTimestamp(4, dto.time);
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

    public boolean insertDetails(ArrayList<DetailsDTO> list) throws NamingException, SQLException {
        Connection con = null;
        Statement stm = null;

        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                con.setAutoCommit(false);
                stm = con.createStatement();
                for (DetailsDTO dto : list) {
                    String sql = "INSERT INTO "
                            + "tbl_Details(quizID, questionID, answerID) "
                            + "VALUES(" + dto.quizID + "," + dto.questionID + ", " + dto.answerID + ")";
                    stm.addBatch(sql);
                }
                int count = stm.executeBatch().length;

                if (count == list.size()) {
                    con.commit();
                    return true;

                } else {
                    con.rollback();
                    return false;

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

    public int getLastQuizID() throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT MAX(id) AS id "
                        + "FROM tbl_Quiz ";
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

    public ArrayList<DetailsDTO> getDetails(int id) throws NamingException, SQLException {
        ArrayList<DetailsDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT quizID, questionID, answerID "
                        + "FROM tbl_Details "
                        + "WHERE quizID=" + id;
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int quizID = rs.getInt("quizID");
                    int questionID = rs.getInt("questionID");
                    int answerID = rs.getInt("answerID");
                    DetailsDTO dto = new DetailsDTO(id, quizID, questionID, answerID);
                    list.add(dto);
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

    public QuizDTO getQuiz(int id) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT  userID, subjectID, mark, time "
                        + "FROM tbl_Quiz "
                        + "WHERE id=" + id;
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                   
                    String userID = rs.getString("userID");
                    String subjectID = rs.getString("subjectID");
                    double mark = rs.getDouble("mark");
                    Timestamp time = rs.getTimestamp("time");
                    QuizDTO dto = new QuizDTO(id, userID,subjectID, mark, time);
                    return dto;
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
    public ArrayList<QuizDTO> getQuiz(String subjectid) throws NamingException, SQLException {
        ArrayList<QuizDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT id, userID, subjectID, mark, time "
                        + "FROM tbl_Quiz "
                        + "WHERE subjectID like '" + subjectid + "%'";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String userID = rs.getString("userID");
                    String subjectID = rs.getString("subjectID");
                    double mark = rs.getDouble("mark");
                    Timestamp time = rs.getTimestamp("time");
                    QuizDTO dto = new QuizDTO(id, userID,subjectID, mark, time);
                    list.add(dto);
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

}
