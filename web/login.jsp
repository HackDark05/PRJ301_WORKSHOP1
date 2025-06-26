<%-- 
    Document   : login
    Created on : May 23, 2025, 9:50:21 AM
    Author     : tungi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Startup Project Management System</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
            padding: 20px;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 450px;
            transition: transform 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-5px);
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-title {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }

        .login-subtitle {
            color: #6b7280;
            font-size: 1.1rem;
            font-weight: 400;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-weight: 600;
            color: #4a5568;
            font-size: 16px;
            margin-left: 4px;
        }

        .form-input {
            padding: 16px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            width: 100%;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            background: rgba(255, 255, 255, 1);
            transform: translateY(-2px);
        }

        .form-input::placeholder {
            color: #9ca3af;
        }

        .login-btn {
            padding: 16px 24px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 10px;
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #5a6fd8, #6b5b95);
        }

        .login-btn:active {
            transform: translateY(-1px);
        }

        .error-message {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            color: #dc2626;
            padding: 15px 20px;
            border-radius: 12px;
            font-weight: 500;
            text-align: center;
            border: 1px solid #fca5a5;
            margin-top: 20px;
            animation: slideIn 0.3s ease;
        }

        .success-redirect {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #059669;
            padding: 15px 20px;
            border-radius: 12px;
            font-weight: 500;
            text-align: center;
            border: 1px solid #6ee7b7;
            margin-top: 20px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .floating-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 70%;
            right: 10%;
            animation-delay: 2s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            top: 50%;
            left: 80%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.7;
            }
            50% {
                transform: translateY(-20px) rotate(180deg);
                opacity: 0.3;
            }
        }

        .input-icon {
            position: relative;
            width: 100%;
        }

        .input-icon::before {
            content: '';
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            width: 18px;
            height: 18px;
            background-size: contain;
            background-repeat: no-repeat;
            opacity: 0.5;
            z-index: 1;
        }

        .username-input::before {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='currentColor'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z' /%3E%3C/svg%3E");
        }

        .password-input::before {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='currentColor'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z' /%3E%3C/svg%3E");
        }

        .icon-input {
            padding-left: 50px;
            width: 100%;
            box-sizing: border-box;
        }

        @media (max-width: 600px) {
            .login-container {
                padding: 30px 20px;
                margin: 10px;
            }

            .login-title {
                font-size: 2rem;
            }

            .login-subtitle {
                font-size: 1rem;
            }

            .form-input {
                padding: 14px 18px;
                font-size: 14px;
            }

            .icon-input {
                padding-left: 45px;
            }

            .login-btn {
                padding: 14px 20px;
                font-size: 14px;
            }
        }

        @media (max-width: 400px) {
            .login-container {
                padding: 25px 15px;
            }

            .login-title {
                font-size: 1.75rem;
            }
        }
    </style>
</head>
<body>
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <div class="login-container">
                <div class="success-redirect">
                    <p>You are already logged in. Redirecting to dashboard...</p>
                </div>
            </div>
            <c:redirect url="welcome.jsp"/>
        </c:when>
        <c:otherwise>
            <div class="login-container">
                <div class="login-header">
                    <h1 class="login-title">Welcome Back</h1>
                    <p class="login-subtitle">Sign in to your account</p>
                </div>

                <form action="MainController" method="post" class="login-form">
                    <input type="hidden" name="action" value="login"/>
                    
                    <div class="form-group">
                        <label for="username" class="form-label">Username</label>
                        <div class="input-icon username-input">
                            <input type="text" 
                                   id="username"
                                   name="strUsername" 
                                   class="form-input icon-input"
                                   placeholder="Enter your username"
                                   required 
                                   autocomplete="username"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-icon password-input">
                            <input type="password" 
                                   id="password"
                                   name="strPassword" 
                                   class="form-input icon-input"
                                   placeholder="Enter your password"
                                   required 
                                   autocomplete="current-password"/>
                        </div>
                    </div>

                    <button type="submit" class="login-btn">
                        Sign In
                    </button>
                </form>

                <c:if test="${not empty requestScope.message}">
                    <div class="error-message">
                        ${requestScope.message}
                    </div>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>

    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('.form-input');
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });

            // Add loading state to login button
            const loginForm = document.querySelector('.login-form');
            const loginBtn = document.querySelector('.login-btn');
            
            if (loginForm && loginBtn) {
                loginForm.addEventListener('submit', function() {
                    loginBtn.innerHTML = 'Signing In...';
                    loginBtn.disabled = true;
                    loginBtn.style.opacity = '0.7';
                });
            }
        });
    </script>
</body>
</html>