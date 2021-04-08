/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.controller;

import halt.question.AnswerDTO;
import halt.question.QnADAO;
import halt.question.QuestionDTO;
import halt.quiz.DetailsDTO;
import halt.quiz.QuizDAO;
import halt.quiz.QuizDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Luong Thanh Ha
 */
public class ReviewController extends HttpServlet {

    //private final String FAIL = "";
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
        PrintWriter out = response.getWriter();
        // String url = FAIL;
        try {
            String quizid = request.getParameter("quizID");
            if (quizid != null) {
                int id = Integer.parseInt(quizid);
                QuizDAO dao = new QuizDAO();
                QuizDTO quiz = dao.getQuiz(id);
                if (quiz != null) {
                    ArrayList<DetailsDTO> details = dao.getDetails(id);
                    if (!details.isEmpty()) {
                        QnADAO qDAO = new QnADAO();
                        ArrayList<QuestionDTO> questionlist = new ArrayList<>();
                        HashMap<Integer, ArrayList<AnswerDTO>> questionmap = new HashMap<>();
                        for (DetailsDTO detail : details) {
                            QuestionDTO q = qDAO.getQuestion(detail.getQuestionID());
                            ArrayList<AnswerDTO> ans = qDAO.searchAnswer(q.getId());
                            for (AnswerDTO answer : ans) {
                                if (detail.getAnswerID() == answer.getId()) {
                                    answer.setCheck(true);
                                    break;
                                }
                            }
                            questionmap.put(q.getId(), ans);
                            questionlist.add(q);
                        }
                        if (questionmap.size() == details.size()) {                           
                            request.setAttribute("QUESTION_LIST", questionlist);
                            request.setAttribute("QUESTION_MAP", questionmap);
                            request.setAttribute("QUIZDTO", quiz);
                        }
                    }
                }
            }

        } catch (NamingException ex) {
            log("NamingException_ReviewController: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_ReviewController: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher("reviewjsp").forward(request, response);
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
