/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.controller;

import halt.user.UserDAO;
import halt.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;
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
public class CreateUserController extends HttpServlet {

    private final String FAIL = "signup";
    private final String SUCCESS = "";

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
        String mail = request.getParameter("txtEmail");
        String name = request.getParameter("txtFullname");
        String password = request.getParameter("txtPassword");
        String passwordRepeat = request.getParameter("txtPasswordRepeat");
        String url = FAIL;
        UserDAO dao = new UserDAO();
        try {
            if (mail != null) {
                if (!password.equals(passwordRepeat)) {
                    request.setAttribute("CREATE_ERROR", "Password is not matched.");
                } else if (dao.getUserById(mail) != null) {
                    request.setAttribute("CREATE_ERROR", "Email has been existed.");
                }else {
                    MessageDigest digest = MessageDigest.getInstance("SHA-256");
                    byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
                    
                    UserDTO user = new UserDTO(mail, name, hash, "Student", "New");
                    boolean result = dao.createNewUser(user);
                    if (result) {
                        url = SUCCESS;
                    }
                    
                            
                }
            }
        } catch (NamingException ex) {
            log("NamingException_CreateUserController: " + ex.getMessage());
        } catch (SQLException ex) {
            log("SQLException_CreateUserController: " + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log("NoSuchAlgorithmException_CreateUserController: " + ex.getMessage());
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
