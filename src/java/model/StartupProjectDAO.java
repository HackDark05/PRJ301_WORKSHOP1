    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package model;

    import java.sql.Connection;
    import java.sql.PreparedStatement;
    import java.sql.ResultSet;
    import java.util.ArrayList;
    import java.util.List;
    import utils.DbUtils;

    public class StartupProjectDAO {

        // SQL Queries
        private static final String GET_ALL = "SELECT project_id, project_name, Description, Status, estimated_launch FROM tblStartupProjects";
        private static final String GET_BY_ID = "SELECT project_id, project_name, Description, Status, estimated_launch FROM tblStartupProjects WHERE project_id = ?";
        private static final String CREATE = "INSERT INTO tblStartupProjects (project_name, Description, Status, estimated_launch) VALUES (?, ?, ?, ?)";
        private static final String UPDATE = "UPDATE tblStartupProjects SET project_name = ?, Description = ?, Status = ?, estimated_launch = ? WHERE project_id = ?";
        private static final String DELETE = "DELETE FROM tblStartupProjects WHERE project_id = ?";

        public List<StartupProjectDTO> getAll() {
            List<StartupProjectDTO> projects = new ArrayList<>();
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                conn = DbUtils.getConnection();
                ps = conn.prepareStatement(GET_ALL);
                rs = ps.executeQuery();

                while (rs.next()) {
                    StartupProjectDTO project = new StartupProjectDTO(rs.getInt("project_id"),
                            rs.getString("project_name"),
                            rs.getString("Description"),
                            rs.getString("Status"),
                            rs.getDate("estimated_launch")
                    );
                    projects.add(project);
                }
            } catch (Exception e) {
                System.err.println("Error in getAll(): " + e.getMessage());
                e.printStackTrace();
            } finally {
                closeResources(conn, ps, rs);
            }

            return projects;
        }

        public StartupProjectDTO getProjectById(String projectId) {
            StartupProjectDTO project = null;
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                conn = DbUtils.getConnection();
                ps = conn.prepareStatement(GET_BY_ID);
                ps.setString(1, projectId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    project = new StartupProjectDTO();
                    project.setProject_id(rs.getInt("project_id"));
                    project.setProject_name(rs.getString("project_name"));
                    project.setDescription(rs.getString("description"));
                    project.setStatus(rs.getString("status"));
                    project.setEstimated_launch(rs.getDate("estimated_launch"));

                }
            } catch (Exception e) {
                System.err.println("Error in getProductByID(): " + e.getMessage());
                e.printStackTrace();
            } finally {
                closeResources(conn, ps, rs);
            }

            return project;
        }

        public boolean create(StartupProjectDTO project) {
            boolean success = false;
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = DbUtils.getConnection();
                ps = conn.prepareStatement(CREATE);

                ps.setString(1, project.getProject_name());
                ps.setString(2, project.getDescription());
                ps.setString(3, project.getStatus());
                ps.setDate(4, project.getEstimated_launch());
                int rowsAffected = ps.executeUpdate();
                success = (rowsAffected > 0);

            } catch (Exception e) {
                System.err.println("Error in create(): " + e.getMessage());
                e.printStackTrace();
            } finally {
                closeResources(conn, ps, null);
            }

            return success;
        }

        public boolean update(StartupProjectDTO project) {
            boolean success = false;
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = DbUtils.getConnection();
                ps = conn.prepareStatement(UPDATE);

                ps.setString(1, project.getProject_name());
                ps.setString(2, project.getDescription());
                ps.setString(3, project.getStatus());
                ps.setDate(4, project.getEstimated_launch());
                ps.setInt(5, project.getProject_id()); // WHERE condition   

                int rowsAffected = ps.executeUpdate();
                success = (rowsAffected > 0);

            } catch (Exception e) {
                System.err.println("Error in update(): " + e.getMessage());
                e.printStackTrace();
            } finally {
                closeResources(conn, ps, null);
            }

            return success;
        }

        public List<StartupProjectDTO> getProjectsByName(String name) {
            List<StartupProjectDTO> projects = new ArrayList<>();
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String query = GET_ALL + " WHERE project_name LIKE ?";

            try {
                conn = DbUtils.getConnection();
                ps = conn.prepareStatement(query);
                ps.setString(1, "%" + name + "%");
                rs = ps.executeQuery();

                while (rs.next()) {
                    StartupProjectDTO project = new StartupProjectDTO();
                    project.setProject_id(rs.getInt("project_id"));
                    project.setProject_name(rs.getString("project_name"));
                    project.setDescription(rs.getString("Description"));
                    project.setStatus(rs.getString("Status"));
                    project.setEstimated_launch(rs.getDate("estimated_launch"));
                    projects.add(project);
                }
            } catch (Exception e) {
                System.err.println("Error in getProjectsByName(): " + e.getMessage());
                e.printStackTrace();
            } finally {
                closeResources(conn, ps, rs);
            }

            return projects;
        }

        public boolean delete(String projectId) {
            boolean success = false;
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = DbUtils.getConnection();
                ps = conn.prepareStatement(DELETE);
                ps.setString(1, projectId);

                int rowsAffected = ps.executeUpdate();
                success = (rowsAffected > 0);

            } catch (Exception e) {
                System.err.println("Error in delete(): " + e.getMessage());
                e.printStackTrace();
            } finally {
                closeResources(conn, ps, null);
            }

            return success;
        }

        private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.err.println("Error closing resources: " + e.getMessage());
                e.printStackTrace();
            }
        }

        /**
         * Check if product exists by ID
         *
         * @param id Product ID to check
         * @return true if exists, false otherwise
         */
        public boolean isProductExists(String project_id) {
            return getProjectById(project_id) != null;
        }

        public boolean updateStatus(String projectId, String status) {
            StartupProjectDTO project = getProjectById(projectId);
            if (project != null) {
                project.setStatus(status);
                return update(project);
            }
            return false;
        }

    }
