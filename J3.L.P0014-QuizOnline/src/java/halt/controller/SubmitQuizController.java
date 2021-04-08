/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.controller;

import halt.question.AnswerDTO;
import halt.question.QuestionDTO;
import halt.quiz.DetailsDTO;
import halt.quiz.QuizDAO;
import halt.quiz.QuizDTO;
import halt.records.AnswerRecords;
import halt.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Luong Thanh Ha
 */
public class SubmitQuizController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        String url = "";

        try {
            if (session != null) {
                AnswerRecords records = (AnswerRecords) session.getAttribute("RECORDS");

                if (records != null) {
                    int noq = (int) session.getAttribute("TOTAL");

                    int result = records.getResult(noq);
                    double mark = records.getMark(noq);
                    String time = request.getParameter("timeremain");
                    double timeremain = Double.parseDouble(time);
                    double m = Math.floor((timeremain % (1000 * 60 * 60)) / (1000 * 60));
                    double s = Math.floor((timeremain % (1000 * 60)) / 1000);
                    request.setAttribute("RESULT", result);
                    request.setAttribute("MARK", mark);
                    request.setAttribute("TIMEREMAIN", (int) m + ":" + (int) s);

                    ArrayList<QuestionDTO> list = (ArrayList<QuestionDTO>) session.getAttribute("QUESTIONLIST");
                    System.out.println("result" + result);
                    String subjectId = list.get(0).getSubjectID();
                    request.setAttribute("SUBJECT", subjectId);
                    
//                  
                    UserDTO user = (UserDTO) session.getAttribute("USERINFO");
                    Timestamp submitTime = Timestamp.valueOf(LocalDateTime.now());
                    QuizDAO dao = new QuizDAO();
                    QuizDTO quiz = new QuizDTO(user.getId(), subjectId, mark, submitTime);

                    HashMap<Integer, ArrayList<AnswerDTO>> answermap = (HashMap<Integer, ArrayList<AnswerDTO>>) session.getAttribute("ANSWERMAP");
                    boolean insertQuizlog = dao.insertQuiz(quiz);
                    if (insertQuizlog) {
                        int quizid = dao.getLastQuizID();
                        ArrayList<DetailsDTO> details = new ArrayList<>();
                        for (Integer questionid : records.records.keySet()) {
                            for (AnswerDTO answer : answermap.get(questionid)) {
                                if (answer.isCheck()) {
                                    DetailsDTO dto = new DetailsDTO(quizid, questionid, answer.getId());
                                    details.add(dto);
                                }
                            }

                        }
                        if (records.records.size() == details.size()) {
                            boolean insertDetails = dao.insertDetails(details);
                            if (insertDetails) {
                                session.removeAttribute("RECORDS");
                                session.removeAttribute("ANSWERMAP");
                                session.removeAttribute("QUESTIONLIST");
                                request.setAttribute("QUIZID", quizid);
                                url = "resultjsp";

                            }
                        }
                    }

                }
            }
        } catch (NamingException ex) {
            log("NamingException_SubmitQuizController: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_SubmitQuizController: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
