<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:12:10 AM
    Author     : tungi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<%@page import="java.util.List" %>
<%@page import="model.StartupProjectDTO" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Startup Project Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-section h1 {
            color: #4a5568;
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .add-project-btn, .logout-btn {
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .add-project-btn {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
        }

        .add-project-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
        }

        .logout-btn {
            background: linear-gradient(135deg, #f44336, #d32f2f);
            color: white;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.4);
        }

        .content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .search-section {
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-label {
            font-weight: 600;
            color: #4a5568;
            font-size: 16px;
        }

        .search-input {
            flex: 1;
            min-width: 250px;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-btn {
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .no-results {
            text-align: center;
            padding: 40px;
            color: #6b7280;
        }

        .no-results h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .projects-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .projects-table thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .projects-table th,
        .projects-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .projects-table th {
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .projects-table tbody tr {
            transition: all 0.3s ease;
        }

        .projects-table tbody tr:hover {
            background-color: #f8fafc;
            transform: scale(1.01);
        }

        .project-id {
            font-weight: 600;
            color: #667eea;
        }

        .project-name {
            font-weight: 600;
            color: #2d3748;
        }

        .project-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-ideation {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-development {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .status-launch {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-scaling {
            background-color: #e0e7ff;
            color: #3730a3;
        }

        .status-select {
            padding: 8px 12px;
            border: 2px solid #e2e8f0;
            border-radius: 6px;
            background: white;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .status-select:focus {
            outline: none;
            border-color: #667eea;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .access-denied {
            text-align: center;
            padding: 60px 20px;
            color: #4a5568;
        }

        .access-denied h2 {
            font-size: 2rem;
            margin-bottom: 15px;
            color: #e53e3e;
        }

        .access-denied p {
            margin-bottom: 25px;
            font-size: 1.1rem;
        }

        .login-link {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .login-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                text-align: center;
            }

            .header-section h1 {
                font-size: 2rem;
            }

            .search-form {
                flex-direction: column;
                align-items: stretch;
            }

            .search-input {
                min-width: auto;
            }

            .projects-table {
                font-size: 14px;
            }

            .projects-table th,
            .projects-table td {
                padding: 10px 8px;
            }
        }

        @media (max-width: 600px) {
            .projects-table,
            .projects-table thead,
            .projects-table tbody,
            .projects-table th,
            .projects-table td,
            .projects-table tr {
                display: block;
            }

            .projects-table thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }

            .projects-table tr {
                border: 1px solid #ccc;
                margin-bottom: 10px;
                padding: 10px;
                border-radius: 8px;
                background: white;
            }

            .projects-table td {
                border: none;
                position: relative;
                padding-left: 50% !important;
                text-align: right;
            }

            .projects-table td:before {
                content: attr(data-label) ": ";
                position: absolute;
                left: 6px;
                width: 45%;
                text-align: left;
                font-weight: bold;
                color: #4a5568;
            }
        }
    </style>
</head>
<body>
    <%
      if(AuthUtils.isLoggedIn(request)){
         UserDTO user = AuthUtils.getCurrentUser(request);
         String keyword = (String) request.getAttribute("keyword");
         String message = (String) request.getAttribute("message");
         String checkError = (String) request.getAttribute("checkError");
    %>
    <div class="container">
        <div class="header-section">
            <h1>Welcome <%= user.getName() %>!</h1>
            <div class="header-actions">
                <% if(AuthUtils.isFounder(request)){ %>
                <a href="projectForm.jsp" class="add-project-btn">Add Project</a>
                <% } %>
                <a href="MainController?action=logout" class="logout-btn">Logout</a>
            </div>
        </div>

        <div class="content">
            <!-- Display Messages -->
            <% if(message != null && !message.isEmpty()) { %>
            <div class="message success-message">
                <%= message %>
            </div>
            <% } %>
            
            <% if(checkError != null && !checkError.isEmpty()) { %>
            <div class="message error-message">
                <%= checkError %>
            </div>
            <% } %>

            <div class="search-section">
                <% if(AuthUtils.isFounder(request)){ %>
                <form action="ProjectController" method="post" class="search-form">
                    <input type="hidden" name="action" value="searchProject"/>
                    <label class="search-label">Search project by name:</label>
                    <input type="text" name="keyword" value="<%=keyword!=null?keyword:""%>" 
                           class="search-input" placeholder="Enter project name..."/>
                    <input type="submit" value="Search" class="search-btn"/>
                </form>
                <% } %>
            </div>

            <%
                List<StartupProjectDTO> list = (List<StartupProjectDTO>)request.getAttribute("list");
                
                // Show search results or no results message when searching
                if(keyword != null && !keyword.isEmpty()) {
                    if(list != null && list.isEmpty()) {
            %>
            <div class="no-results">
                <h3>No projects found</h3>
                <p>No projects have name matching with the keyword "<strong><%= keyword %></strong>".</p>
            </div>
            <%
                    }
                }
                
                // Show table when there are projects (either from search or show all)
                if(list != null && !list.isEmpty()) {
            %>

            <div class="table-container">
                <table class="projects-table">
                    <thead>
                        <tr>
                            <th>Project ID</th>
                            <th>Project Name</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Estimated Launch</th>
                            <% if(AuthUtils.isFounder(request)){ %>
                            <th>Action</th>
                            <%}%>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(StartupProjectDTO p: list) { %>
                        <tr>
                            <td data-label="Project ID" class="project-id"><%=p.getProject_id()%></td>
                            <td data-label="Project Name" class="project-name"><%=p.getProject_name()%></td>
                            <td data-label="Description"><%=p.getDescription()%></td>
                            <td data-label="Status">
                                <span class="project-status status-<%=p.getStatus() != null ? p.getStatus().toLowerCase().replace(" ", "-") : ""%>">
                                    <%=p.getStatus() != null ? p.getStatus() : "N/A"%>
                                </span>
                            </td>
                            <td data-label="Estimated Launch">
                                <%if(p.getEstimated_launch() != null) {%>
                                <%=p.getEstimated_launch()%>
                                <%} else {%>
                                N/A
                                <%}%>
                            </td>
                            <% if(AuthUtils.isFounder(request)){ %>
                            <td data-label="Action">
                                <div class="action-buttons">
                                    <form action="ProjectController" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="changeProjectStatus"/>
                                        <input type="hidden" name="projectId" value="<%=p.getProject_id()%>"/>
                                        <input type="hidden" name="keyword" value="<%=keyword!=null?keyword:""%>" />
                                        <select name="status" onchange="this.form.submit()" class="status-select">
                                            <option value="">Change Status</option>
                                            <option value="Ideation" <%= "Ideation".equals(p.getStatus()) ? "disabled" : "" %>>Ideation</option>
                                            <option value="Development" <%= "Development".equals(p.getStatus()) ? "disabled" : "" %>>Development</option>
                                            <option value="Launch" <%= "Launch".equals(p.getStatus()) ? "disabled" : "" %>>Launch</option>
                                            <option value="Scaling" <%= "Scaling".equals(p.getStatus()) ? "disabled" : "" %>>Scaling</option>
                                        </select>
                                    </form>
                                </div>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <%} else { %>
    <div class="container">
        <div class="content">
            <div class="access-denied">
                <h2>Access Denied</h2>
                <p><%=AuthUtils.getAccessDeniedMessage("welcome.jsp")%></p>
                <a href="<%=AuthUtils.getLoginURL()%>" class="login-link">Login Now</a>
            </div>
        </div>
    </div>
    <%}%>
</body>
</html>