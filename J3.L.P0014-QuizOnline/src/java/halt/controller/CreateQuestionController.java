/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.controller;

import halt.question.AnswerDTO;
import halt.question.QnADAO;
import halt.question.QuestionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Luong Thanh Ha
 */
public class CreateQuestionController extends HttpServlet {

    private final String FAIL = "createJsp";
    private final String SUCCESS = "home";

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
        String url = FAIL;
        String q_content = request.getParameter("txtQ_Content").trim();
        String subjectId = request.getParameter("cbSubject").trim();
        Timestamp createDate = Timestamp.valueOf(LocalDateTime.now());
        String correct_Answer = request.getParameter("txtCorrect_answer").trim();
        QnADAO dao = new QnADAO();
        int questionId = -1;
        try {
            if (subjectId.equals("-1")) {
                request.setAttribute("CREATE_ERROR", "Please select subject.");
            } else {
                String[] answer_content = request.getParameterValues("answer_content");
                if (answer_content == null) {
                    request.setAttribute("CREATE_ERROR", "Please input more answer content.");
                } else {

                    boolean insertedQuestion = dao.insertQuestion(new QuestionDTO(q_content, subjectId, createDate, "active"));
                    if (insertedQuestion) {
                        questionId = dao.getLastQuestionID();
                        ArrayList<AnswerDTO> list = new ArrayList<>();
                        if (questionId > 0) {
                            
                            int count = 0;
                            for (int i = 0; i < answer_content.length; i++) {
                                if (!answer_content[i].isEmpty()) {
                                    boolean correct = false;
                                    if (answer_content[i].trim().equals(correct_Answer)) {
                                        correct = true;
                                        count++;
                                    }
                                    AnswerDTO answer = new AnswerDTO(questionId, answer_content[i].trim(), correct);
                                    list.add(answer);
                                }
                            }
                            if (count == 0) {
                                request.setAttribute("CREATE_ERROR", "Correct answer is invalid. Please try again!");
                                clearInvalidData(questionId);
                            } else {
                                boolean insertedAnswer = dao.insertAnswer(list);
                                if (insertedAnswer) {
                                    url = SUCCESS;
                                }
                            }

                        }
                    }
                }
            }

        } catch (NamingException ex) {
            log("NamingException_CreateQuestionController: " + ex.getMessage());
        } catch (SQLException ex) {
            if (ex.getMessage().contains("duplicate")) {
                request.setAttribute("CREATE_ERROR", "Duplicate answer. Please try again!");
                clearInvalidData(questionId);
            }
            log("SQLException_CreateQuestionController: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            out.close();
        }
    }

    void clearInvalidData(int id) {
        try {
            QnADAO dao = new QnADAO();
            dao.deleteAnswer(id);
            dao.deleteQuestion(id);
        } catch (NamingException ex) {
            log("NamingException_CreateQuestionController_clearInvalidData: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_CreateQuestionController_clearInvalidData: " + ex.getMessage());
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
