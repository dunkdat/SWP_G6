<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #e9ecef;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                box-sizing: border-box;
                text-align: center;
            }
            .container h1 {
                font-size: 26px;
                margin-bottom: 20px;
                color: #333;
                font-weight: bold;
            }
            .container label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #555;
            }
            .container input[type="text"],
            .container input[type="password"] {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
                font-size: 16px;
            }
            .container input[type="submit"] {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 5px;
                background-color: #28a745;
                color: white;
                font-size: 18px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .container input[type="submit"]:hover {
                background-color: #218838;
            }
            .container .button-container {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }
            .container a {
                color: #007bff;
                text-decoration: none;
                margin-right: 15px;
            }
            .container a:hover {
                text-decoration: underline;
            }
            .container .links {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .container .error-message {
                color: red;
                font-style: italic;
                margin-top: 10px;
            }
            .or {
                margin: 20px 0;
                font-size: 18px;
                color: #999;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .or:before, .or:after {
                content: "";
                flex: 1;
                border-bottom: 1px solid #ccc;
                margin: 0 10px;
            }
            .or span {
                display: inline-block;
                background: white;
                padding: 0 10px;
                filter: blur(1px);
                opacity: 0.7;
            }
            
            /* CSS for Google login button */
            .google-btn {
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 90%;
                padding: 12px;
                margin-top: 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: white;
                font-size: 16px;
                color: #333;
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
            }
            .google-btn img {
                height: 20px;
                margin-right: 10px;
            }
            .google-btn:hover {
                background-color: #f0f0f0;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            @media (max-width: 500px) {
                .container {
                    padding: 20px;
                }
                .container h1 {
                    font-size: 22px;
                }
                .container input[type="submit"] {
                    font-size: 16px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Login</h1>
            <form action="login" method="post">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" placeholder="Enter your email" required="Please enter email">

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required="Please enter password">
                    
                <input type="submit" value="Login">
            </form>

            <div class="or"><span>or</span></div>

            <!-- Google Login Button -->
            <a class="google-btn" href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20
 profile openid

&redirect_uri=http://localhost:8081/Bad_Sport/gglogin

&response_type=code

&client_id=614333023710-0svuqckuhffj6sqvrrf9ds8rbsrvke67.apps.googleusercontent.com

&approval_prompt=force">
                
                <img src="images/gglogo.png" alt="Google logo">
                Login with Google
            </a>

            <div class="links">
                <a href="register.jsp">Register</a>
                <a href="resetpassword.jsp">Reset Password</a>
            </div>
            <div class="error-message">${message}</div>
        </div>
    </body>
</html>
