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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Luong Thanh Ha
 */
public class SearchController extends HttpServlet {

    private final String HOME = "home";
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
        String searchValue = request.getParameter("txtSearchValue");
        String subjectId = request.getParameter("cbSubject");
        String status = request.getParameter("cbStatus");
        
        try {
            QnADAO dao = new QnADAO();
            ArrayList<QuestionDTO> questionlist = dao.searchQuestions(searchValue, subjectId, status);
            if (!questionlist.isEmpty()) {
                HashMap<Integer, ArrayList<AnswerDTO>> questionMap = new HashMap<>();
                for (QuestionDTO question : questionlist) {
                    ArrayList<AnswerDTO> answerlist = dao.searchAnswer(question.getId());
                    questionMap.put(question.getId(), answerlist);
                }
                for (QuestionDTO questionDTO : questionlist) {
                    out.append(questionDTO.toString());
                    for (AnswerDTO answerDTO : questionMap.get(questionDTO.getId())) {
                        out.append(answerDTO.toString());
                    }
                }
                request.setAttribute("QUESTION_LIST", questionlist);
                request.setAttribute("QUESTION_MAP", questionMap);
            }
        } catch (NamingException ex) {
            log("NamingException_SearchServlet: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_SearchServlet: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(HOME).forward(request, response);
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
