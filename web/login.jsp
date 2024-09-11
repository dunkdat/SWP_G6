<%-- 
    Document   : login
    Created on : Sep 11, 2024, 12:00:30 PM
    Author     : DAT
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 300px;
            }
            .container h1 {
                font-size: 24px;
                margin-bottom: 20px;
            }
            .container label {
                display: block;
                margin-bottom: 8px;
            }
            .container input[type="text"],
            .container input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .container input[type="submit"] {
                width: 48%;
                padding: 10px;
                border: none;
                border-radius: 4px;
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
                font-size: 16px;
            }
            .container input[type="submit"]:nth-of-type(2) {
                background-color: #f44336;
                float: right;
            }
            .container .button-container {
                display: flex;
                justify-content: space-between;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Login</h1>
            <form action="login" method="post">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <div class="button-container">
                    <input type="submit" value="Login">
                    <input type="submit" value="Register" formaction="register.jsp">
                </div>
            </form>
            <div style="color:red; font-style: italic">${message}</div>
        </div>
    </body>
</html>
