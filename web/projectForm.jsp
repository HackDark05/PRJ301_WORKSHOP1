<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.StartupProjectDTO" %>
<%@page import="utils.AuthUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Project Form</title>
        <style>
            /* Reset and Base Styles */
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
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Header Section */
            .header-section {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 30px;
                margin-bottom: 30px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .header-section h1 {
                color: #4a5568;
                font-size: 2.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 10px;
            }

            .header-section p {
                color: #6b7280;
                font-size: 1.1rem;
            }

            /* Form Container */
            .form-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 40px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            }

            /* Messages */
            .message, .alert {
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-weight: 500;
            }

            .success-message, .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .error-message, .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #4a5568;
                font-size: 14px;
            }

            .required {
                color: #f44336;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s ease;
                font-family: inherit;
                background: white;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .form-group input[readonly] {
                background-color: #f8fafc;
                color: #6b7280;
                cursor: not-allowed;
            }

            .form-group textarea {
                min-height: 120px;
                resize: vertical;
            }

            .form-group select {
                cursor: pointer;
            }

            /* Button Group */
            .button-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
                flex-wrap: wrap;
            }

            .button-group input[type="submit"],
            .button-group input[type="reset"],
            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }

            .button-group input[type="submit"], .btn-primary {
                background: linear-gradient(135deg, #4CAF50, #45a049);
                color: white;
            }

            .button-group input[type="submit"]:hover, .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
            }

            .button-group input[type="reset"], .btn-secondary {
                background: linear-gradient(135deg, #6b7280, #4b5563);
                color: white;
            }

            .button-group input[type="reset"]:hover, .btn-secondary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(107, 114, 128, 0.4);
            }

            .btn-back {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                margin-bottom: 20px;
            }

            .btn-back:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            }

            /* Access Denied */
            .access-denied-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 15px;
                padding: 60px 40px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .access-denied-container h1 {
                font-size: 2.5rem;
                margin-bottom: 20px;
                color: #e53e3e;
                background: linear-gradient(135deg, #e53e3e, #c53030);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .access-denied-container p {
                margin-bottom: 30px;
                font-size: 1.1rem;
                color: #4a5568;
                line-height: 1.6;
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

            /* Form Title */
            .form-title {
                text-align: center;
                margin-bottom: 30px;
            }

            .form-title h2 {
                color: #4a5568;
                font-size: 1.8rem;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .form-title .subtitle {
                color: #6b7280;
                font-size: 1rem;
            }

            /* Navigation */
            .nav-buttons {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 10px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .container {
                    padding: 10px;
                }

                .header-section {
                    padding: 20px;
                }

                .header-section h1 {
                    font-size: 2rem;
                }

                .form-container {
                    padding: 25px;
                }

                .button-group {
                    flex-direction: column;
                }

                .button-group input[type="submit"],
                .button-group input[type="reset"] {
                    width: 100%;
                }

                .nav-buttons {
                    flex-direction: column;
                    align-items: stretch;
                }

                .nav-buttons .btn {
                    width: 100%;
                }
            }

            @media (max-width: 480px) {
                .header-section h1 {
                    font-size: 1.5rem;
                }

                .form-container {
                    padding: 20px;
                }

                .access-denied-container {
                    padding: 40px 20px;
                }

                .access-denied-container h1 {
                    font-size: 2rem;
                }
            }

            /* Animation for form appearance */
            .form-container {
                animation: slideInUp 0.6s ease-out;
            }

            @keyframes slideInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <% if (AuthUtils.isFounder(request)) {
                String checkError = (String)request.getAttribute("checkError");
                String message = (String)request.getAttribute("message");
                StartupProjectDTO project = (StartupProjectDTO)request.getAttribute("project");
                boolean isEdit = request.getAttribute("isEdit") != null;
                String keyword = (String)request.getAttribute("keyword");
            %>

            <!-- Header Section -->
            <div class="header-section">
                <h1><%= isEdit ? "Edit Project" : "Add New Project" %></h1>
                <p><%= isEdit ? "Update your project details" : "Create a new startup project" %></p>
            </div>

            <div class="form-container">
                <!-- Navigation -->
                <form action="MainController" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="showAllProject"/>
                    <button type="submit" class="btn btn-back">← Back to Home</button>
                </form>


                <!-- Messages -->
                <% if (message != null) { %>
                <div class="message success-message">
                    <%= message %>
                </div>
                <% } %>

                <% if (checkError != null) { %>
                <div class="message error-message">
                    <%= checkError %>
                </div>
                <% } %>

                <!-- Form -->
                <form action="ProjectController" method="post">
                    <input type="hidden" name="action" value="<%= isEdit ? "updateProject" : "addProject" %>" />

                    <% if (isEdit) { %>
                    <div class="form-group">
                        <label for="project_id">Project ID <span class="required">*</span></label>
                        <input type="text" id="project_id" name="project_id" required
                               value="<%= project != null ? project.getProject_id() : "" %>"
                               readonly />
                    </div>
                    <% } %>

                    <div class="form-group">
                        <label for="project_name">Project Name <span class="required">*</span></label>
                        <input type="text" id="project_name" name="project_name" required
                               value="<%= project != null ? project.getProject_name() : "" %>"
                               placeholder="Enter your project name" />
                    </div>

                    <div class="form-group">
                        <label for="description">Description <span class="required">*</span></label>
                        <textarea id="description" name="description" required
                                  placeholder="Describe your project goals, features, and target audience..."><%= project != null ? project.getDescription() : "" %></textarea>
                    </div>

                    <div class="form-group">
                        <label for="estimated_launch">Estimated Launch Date</label>
                        <input type="date" id="estimated_launch" name="estimated_launch"
                               value="<%= project != null && project.getEstimated_launch() != null ? project.getEstimated_launch().toString() : "" %>" />
                    </div>

                    <div class="form-group">
                        <label for="status">Status <span class="required">*</span></label>
                        <select id="status" name="status" required>
                            <option value="Ideation" <%= project != null && "Ideation".equals(project.getStatus()) ? "selected" : "" %>>💡 Ideation</option>
                            <option value="Development" <%= project != null && "Development".equals(project.getStatus()) ? "selected" : "" %>>🔨 Development</option>
                            <option value="Launch" <%= project != null && "Launch".equals(project.getStatus()) ? "selected" : "" %>>🚀 Launch</option>
                            <option value="Scaling" <%= project != null && "Scaling".equals(project.getStatus()) ? "selected" : "" %>>📈 Scaling</option>
                        </select>
                    </div>

                    <div class="button-group">
                        <input type="hidden" name="keyword" value="<%= keyword != null ? keyword : "" %>" />
                        <input type="submit" value="<%= isEdit ? "Update Project" : "Create Project" %>" />
                        <input type="reset" value="Reset Form" />
                    </div>
                </form>
            </div>

            <% } else { %>
            <div class="access-denied-container">
                <h1>ACCESS DENIED</h1>
                <p><%= AuthUtils.getAccessDeniedMessage("Project Form") %></p>
                <a href="login.jsp" class="login-link">Go to Login</a>
            </div>
            <% } %>
        </div>
    </body>
</html>