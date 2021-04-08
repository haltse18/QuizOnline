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
public class ConfirmUpdateController extends HttpServlet {

    private final String FAIL = "updateQuestion";
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
        int id = Integer.parseInt(request.getParameter("txtQuestionID"));
        String q_content = request.getParameter("txtQ_Content");
        String subjectID = request.getParameter("cbSubject");
        String correct_ans = request.getParameter("txtCorrect_answer");
        String status = request.getParameter("cbstatus");

        String url = FAIL;

        try {
            QnADAO dao = new QnADAO();

//            QuestionDTO question = dao.getQuestion(id);
            int answer_count = dao.searchAnswer(id).size();
            HashMap<Integer, String> answermap = new HashMap<>();
            for (int i = 1; i <= answer_count; i++) {
                int ans_id = Integer.parseInt(request.getParameter("txtAnswerID" + i));
                String ans_ctent = request.getParameter("txtA_Content" + i);
                answermap.put(ans_id, ans_ctent);
            }
            QuestionDTO newQuestion = new QuestionDTO(id,q_content, subjectID, status);
            boolean updateQuestion = dao.updateQuestion(newQuestion);
            ArrayList<AnswerDTO> answerList = new ArrayList<>();
            if (updateQuestion) {
                for (Integer key : answermap.keySet()) {
                    boolean isCorrect = false;
                    if (answermap.get(key).trim().equals(correct_ans)) {
                        isCorrect = true;
                    }
                    AnswerDTO answer = new AnswerDTO(key, id, answermap.get(key), isCorrect);
                    answerList.add(answer);
                }
            }
            
            boolean updateAnswer = dao.updateAnswer(answerList);
            if (updateAnswer) {
                url = SUCCESS;

            }

        } catch (NamingException ex) {
            log("NamingException_ConfirmUpdateController: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_ConfirmUpdateController: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            out.close();
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
