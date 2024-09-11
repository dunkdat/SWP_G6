<%-- 
    Document   : register
    Created on : Sep 11, 2024, 12:19:57 PM
    Author     : DAT
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
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
                width: 350px;
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
            .container input[type="email"],
            .container input[type="password"],
            .container input[type="address"],
            .container textarea {
                width: 90%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .container select {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .container input[type="submit"] {
                width: 100%;
                padding: 10px;
                border: none;
                border-radius: 4px;
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
                font-size: 16px;
            }
            .container input[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Register</h1>
            <form action="register" method="post">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${name}" required>

                <label for="address">Address:</label>
                <input type="address"id="address" name="address" value="${address}"required></input>

                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="" disabled selected>Select Gender</option>
                    <option value="1" ${gender == 1 ? 'slected' : ''}>Male</option>
                    <option value="0" ${gender == 0 ? 'slected' : ''}>Female</option>
                </select>

                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="${phone}"required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${email}"required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <label for="confirm-password">Confirm Password:</label>
                <input type="password" id="confirm-password" name="cfpassword" required>

                <input type="submit" value="Register">
            </form>
                 <div style="color:red; font-style: italic">${message}</div>
        </div>
       
    </body>
</html>
