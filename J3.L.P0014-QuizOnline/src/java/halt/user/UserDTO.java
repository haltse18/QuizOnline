/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.user;

/**
 *
 * @author Luong Thanh Ha
 */
public class UserDTO {
    String id;
    String name;
    byte[] password;
    String role;
    String status;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getPassword() {
        return password;
    }

    public void setPassword(byte[] password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public UserDTO(String id, String name, byte[] password, String role, String status) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "id=" + id + ", name=" + name + ", password=" + password + ", role=" + role + ", status=" + status + '}';
    }

    
    
    
}
