/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.controller;

import halt.question.AnswerDTO;
import halt.question.QnADAO;
import halt.question.QuestionDTO;
import halt.records.AnswerRecords;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;
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
public class GenerateQuizController extends HttpServlet {

    private final String FAIL = "home";
    private final String SUCCESS = "quizpage";

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

        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        ArrayList<QuestionDTO> list = (ArrayList<QuestionDTO>) session.getAttribute("QUESTIONLIST");

        String url = FAIL;
        try {
            if (list == null) {

                String subjectID = request.getParameter("subjectID");

                if (subjectID != null) {
//                    int NoQuestion = 50;
//                    int TimeofQuiz = 80;
                    int NoQuestion = 5;
                    int TimeofQuiz = 5;
                    if (subjectID.contains("PRJ311")) {
//                        NoQuestion = 40;
//                        TimeofQuiz = 60;
                        NoQuestion = 5;
                        TimeofQuiz = 1;
                    }
                    QnADAO dao = new QnADAO();
                    int max = dao.getLastQuestionID();
                    Random r = new Random();
                    int n = 0;
                    list = new ArrayList<>();
                    while (n < NoQuestion) {
                        int id = r.nextInt(max) + 1;
                        QuestionDTO q = dao.getQuestion(id);
                        if (q != null && q.getSubjectID().equals(subjectID) && checkDupPlicate(list, q)) {
                            list.add(q);
                            n++;
                        }
                    }

                    HashMap<Integer, ArrayList<AnswerDTO>> answermap = new HashMap<>();
                    for (QuestionDTO q : list) {
                        ArrayList<AnswerDTO> ans = dao.searchAnswer(q.getId());

                        if (ans.size() > 0) {
                            answermap.put(q.getId(), ans);
                        }
                    }

                    if (answermap.size() == NoQuestion) {
                        session.setAttribute("QUESTIONLIST", list);
                        session.setAttribute("ANSWERMAP", answermap);
                        session.setAttribute("TIMEQUIZ", TimeofQuiz);
                        session.setAttribute("MAINTIME", TimeofQuiz);
                        request.setAttribute("CURRENTQUESTION", list.get(0).getId());
                        request.setAttribute("NUMBER", 0);
                        session.setAttribute("TOTAL", NoQuestion);
                        url = SUCCESS;
                        AnswerRecords records = new AnswerRecords();
                        session.setAttribute("RECORDS", records);

                    }

                }
            } 
                
                

            

        } catch (NamingException ex) {
            log("NamingException_GenerateQuizController: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_GenerateQuizController: " + ex.getMessage());
        } finally {

            request.getRequestDispatcher(url).forward(request, response);

        }
    }

    boolean checkDupPlicate(ArrayList<QuestionDTO> list, QuestionDTO dto) {
        for (QuestionDTO questionDTO : list) {
            if (dto.getId() == questionDTO.getId()) {
                return false;
            }
        }
        return true;
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
