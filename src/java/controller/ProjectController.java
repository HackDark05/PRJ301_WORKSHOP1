package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;
import model.StartupProjectDAO;
import model.StartupProjectDTO;
import utils.AuthUtils;

/**
 *
 * @author tungi
 */
@WebServlet(name = "ProjectController", urlPatterns = {"/ProjectController"})
public class ProjectController extends HttpServlet {

    StartupProjectDAO pdao = new StartupProjectDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");
            if (action.equals("addProject")) {
                url = handleProjectAdding(request, response);
            } else if (action.equals("searchProject")) {
                url = handleProjectSearching(request, response);
            } else if (action.equals("changeProjectStatus")) {
                url = handleProjectStatusChanging(request, response);
            } else if (action.equals("showAllProject")) {
                url = handleProjectShowAll(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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

    private String handleProjectAdding(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isFounder(request)) {
            String checkError = "";
            String message = "";
            String projectName = request.getParameter("project_name");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String estimatedLaunchStr = request.getParameter("estimated_launch");
            String keyword = request.getParameter("keyword");

            Date estimatedLaunch = null;

            // Validation cho các field bắt buộc
            if (projectName == null || projectName.trim().isEmpty()) {
                checkError += "Project name is required.<br/>";
            }

            if (description == null || description.trim().isEmpty()) {
                checkError += "Description is required.<br/>";
            }

            if (status == null || status.trim().isEmpty()) {
                checkError += "Status is required.<br/>";
            }

            // Validation cho Date - CHỈ parse khi có giá trị
            if (estimatedLaunchStr != null && !estimatedLaunchStr.trim().isEmpty()) {

                estimatedLaunch = Date.valueOf(estimatedLaunchStr.trim());

            }

            // CHỈ tạo project khi không có lỗi
            if (checkError.isEmpty()) {
                try {
                    // Tạo project mới với ID = 0 (sẽ được auto-generate bởi database)
                    StartupProjectDTO project = new StartupProjectDTO(0,
                            projectName.trim(),
                            description.trim(),
                            status.trim(),
                            estimatedLaunch);

                    if (pdao.create(project)) {
                        message = "Project added successfully!";
                        // Clear form sau khi add thành công bằng cách redirect về search
                        request.setAttribute("message", message);
                        request.setAttribute("keyword", keyword);
                        return handleProjectSearching(request, response);
                    } else {
                        checkError += "Failed to add project to database. Please try again.<br/>";
                        // Giữ lại data để user sửa
                        StartupProjectDTO tempProject = new StartupProjectDTO();
                        tempProject.setProject_id(0);
                        tempProject.setProject_name(projectName);
                        tempProject.setDescription(description);
                        tempProject.setStatus(status);
                        tempProject.setEstimated_launch(estimatedLaunch);
                        request.setAttribute("project", tempProject);
                    }
                } catch (Exception e) {
                    checkError += "Error creating project: " + e.getMessage() + "<br/>";
                    e.printStackTrace();
                }
            } else {
                // Giữ lại data để user sửa khi có lỗi validation
                StartupProjectDTO tempProject = new StartupProjectDTO();
                tempProject.setProject_id(0);
                tempProject.setProject_name(projectName);
                tempProject.setDescription(description);
                tempProject.setStatus(status);
                tempProject.setEstimated_launch(estimatedLaunch);
                request.setAttribute("project", tempProject);
            }

            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
            request.setAttribute("keyword", keyword);
        } else {
            // Không có quyền
            request.setAttribute("checkError", "Access denied. Only founders can add projects.");
        }

        return "projectForm.jsp";
    }

    private String handleProjectSearching(HttpServletRequest request, HttpServletResponse response) {
        String keyword = request.getParameter("keyword");
        List<StartupProjectDTO> list;

        if (keyword == null || keyword.trim().isEmpty()) {
            list = pdao.getAll();
        } else {
            list = pdao.getProjectsByName(keyword);
        }

        request.setAttribute("list", list);
        request.setAttribute("keyword", keyword);
        return "welcome.jsp";
    }

    private String handleProjectShowAll(HttpServletRequest request, HttpServletResponse response) {
        List<StartupProjectDTO> showList;
        showList = pdao.getAll();
        request.setAttribute("list", showList);
        return "welcome.jsp";
    }

    private String handleProjectStatusChanging(HttpServletRequest request, HttpServletResponse response) {
        String projectIdStr = request.getParameter("projectId");
        String newStatus = request.getParameter("status");
        String keyword = request.getParameter("keyword");

        String message = "";
        String checkError = "";

        if (AuthUtils.isFounder(request)) {
            // Validate projectId
            if (projectIdStr == null || projectIdStr.trim().isEmpty()) {
                checkError = "Project ID is required.";
            } else if (newStatus == null || newStatus.trim().isEmpty()) {
                checkError = "Status is required.";
            } else {
                try {
                    int projectId = Integer.parseInt(projectIdStr.trim());

                    if (pdao.updateStatus(String.valueOf(projectId), newStatus.trim())) {
                        message = "Status updated successfully!";
                    } else {
                        checkError = "Failed to update status. Please try again.";
                    }
                } catch (NumberFormatException e) {
                    checkError = "Invalid project ID format.";
                } catch (Exception e) {
                    checkError = "Error updating status: " + e.getMessage();
                    e.printStackTrace();
                }
            }
        } else {
            checkError = "Access denied. Only founders can change project status.";
        }

        // Set attributes for displaying messages
        if (!message.isEmpty()) {
            request.setAttribute("message", message);
        }
        if (!checkError.isEmpty()) {
            request.setAttribute("checkError", checkError);
        }

        // Preserve the keyword for search results
        request.setAttribute("keyword", keyword);

        // Return to the search results (which will show the updated project)
        return handleProjectSearching(request, response);
    }

    private String handleProjectUpdating(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isFounder(request)) {
            String checkError = "";
            String message = "";
            String projectIdStr = request.getParameter("project_id");
            String projectName = request.getParameter("project_name");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String estimatedLaunchStr = request.getParameter("estimated_launch");

            int projectId = 0;
            Date estimatedLaunch = null;

            try {
                projectId = Integer.parseInt(projectIdStr);
            } catch (Exception e) {
                checkError += "Invalid project ID format.<br/>";
            }

            try {
                estimatedLaunch = Date.valueOf(estimatedLaunchStr);
            } catch (Exception e) {
                checkError += "Invalid date format.<br/>";
            }

            // Validation
            if (projectName == null || projectName.trim().isEmpty()) {
                checkError += "Project name is required.<br/>";
            }

            if (description == null || description.trim().isEmpty()) {
                checkError += "Description is required.<br/>";
            }

            if (checkError.isEmpty()) {
                StartupProjectDTO project = new StartupProjectDTO(projectId, projectName, description, status, estimatedLaunch);
                if (pdao.update(project)) {
                    message = "Project updated successfully.";
                    // Redirect to welcome page after successful update
                    return handleProjectSearching(request, response);
                } else {
                    checkError += "Cannot update project.<br/>";
                }
                request.setAttribute("project", project);
            } else {
                // Keep form data for user to correct
                StartupProjectDTO project = new StartupProjectDTO(projectId, projectName, description, status, estimatedLaunch);
                request.setAttribute("project", project);
            }

            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
            request.setAttribute("isEdit", true);
        }
        return "projectForm.jsp";
    }

}
