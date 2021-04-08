/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.controller;

import halt.quiz.QuizDAO;
import halt.quiz.QuizDTO;
import halt.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class SearchHistoryController extends HttpServlet {

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

        try {
            String subjectID = request.getParameter("cbSubject");
            UserDTO user = (UserDTO) session.getAttribute("USERINFO");
            if (subjectID == null) {
                subjectID = "";
            }
            QuizDAO dao = new QuizDAO();
            ArrayList<QuizDTO> quizlist = dao.getQuiz(subjectID);
            if (!quizlist.isEmpty()) {
                out.append(quizlist.size() + "");
                ArrayList<QuizDTO> quizarray = new ArrayList<>();
                for (QuizDTO quiz : quizlist) {

                    if (quiz.getUserID().equals(user.getId())) {
                        quizarray.add(quiz);

                    }
                }
                out.append(quizarray.size() + "");
                if (!quizarray.isEmpty()) {
                    out.append(quizarray.size() + "");
                    request.setAttribute("QUIZLIST", quizarray);

                }
            }
        } catch (NamingException ex) {
            log("NamingException_SearchHistoryController: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_SearchHistoryController: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher("history").forward(request, response);
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
