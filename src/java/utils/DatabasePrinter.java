package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.StartupProjectDTO;
import model.UserDTO;
import java.util.List;
import model.StartupProjectDAO;
import model.UserDAO;

public class DatabasePrinter {

    public static void main(String[] args) {
        System.out.println("========== DỮ LIỆU TỪ tblStartupProjects ==========");
        printAllStartupProjects();

        System.out.println("\n========== DỮ LIỆU TỪ tblUsers ==========");
        printAllUsers();
    }

    public static void printAllStartupProjects() {
        StartupProjectDAO dao = new StartupProjectDAO();
        List<StartupProjectDTO> list = dao.getAll();

        for (StartupProjectDTO project : list) {
            System.out.println(project);
        }
    }

    public static void printAllUsers() {
        try {
            Connection conn = DbUtils.getConnection();
            String sql = "SELECT * FROM tblUsers";
            PreparedStatement pr = conn.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();

            while (rs.next()) {
                String username = rs.getString("username");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String role = rs.getString("role");

                UserDTO user = new UserDTO(username, name, password, role);
                System.out.println(user);
            }

            rs.close();
            pr.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("Error printing users: " + e.getMessage());
        }
    }
}
