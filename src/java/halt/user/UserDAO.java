/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.user;

import halt.util.DBHelpers;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Luong Thanh Ha
 */
public class UserDAO {

    public boolean checkLogin(String username, byte[] password) throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT id "
                        + "FROM tbl_Users "
                        + "WHERE id = ? and password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                
                stm.setBytes(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return true;
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
        return false;
    }

    public boolean createNewUser(UserDTO user) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        int rs = 0;
        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO "
                        + "tbl_Users "
                        + "VALUES(?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, user.id);
                stm.setString(2, user.name);
                stm.setBytes(3, user.password);
                stm.setString(4, user.role);
                stm.setString(5, user.status);

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

    public UserDTO getUserById(String username) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelpers.makeConnection();
            if (con != null) {
                String sql = "SELECT password, name, role, status "
                        + "FROM tbl_Users "
                        + "WHERE id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                rs = stm.executeQuery();
                if (rs.next()) {
                    byte[] password = rs.getBytes("password");
                    String name = rs.getString("name");
                    String role = rs.getString("role");
                    String status = rs.getString("status");
                    UserDTO user = new UserDTO(username, name, password, role, status);
                    return user;
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
