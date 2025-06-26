/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author hacke
 */
public class UserDAO {

    public UserDAO() {

    }

    public boolean login(String userID, String password) {
        UserDTO user = getUserByUsername(userID);
        if (user != null) {
            if (user.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }

    public UserDTO getUserByUsername(String username) {
        UserDTO user = null;
        try {
            // B0 - Tao sql
            String sql = "SELECT * FROM tblUsers WHERE Username=?";

            // B1 - ket noi
            Connection conn = DbUtils.getConnection();

            // B2 - Tao cong cu de thuc thi cau lenh sql
//            Statement st = conn.createStatement();
            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, username);
            // B3 - Thuc thi cau lenh
            ResultSet rs = pr.executeQuery();

            // B4 - Duyet bang
            while (rs.next()) {
                String usernameDb = rs.getString("username");
                String nameDb = rs.getString("name");
                String passwordDb = rs.getString("password");
                String roleDb = rs.getString("role");

                user = new UserDTO(usernameDb, nameDb, passwordDb, roleDb);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return user;
    }

    public List<UserDTO> getAllUsers() {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT Username, Name, Password, Role FROM tblUsers";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUsername(rs.getString("Username"));
                user.setName(rs.getString("Name"));
                user.setPassword(rs.getString("Password"));
                user.setRole(rs.getString("Role"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE tblUsers SET Password = ? WHERE Username = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, username);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
