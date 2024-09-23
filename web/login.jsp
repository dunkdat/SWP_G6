<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/loginstyle.css"/>
    </head>
    <body>
        <div class="container">
            <!-- Form Section -->
            <div class="form-section">
                <h1>WELCOME TO OUR SHOP</h1>
                <p>Please enter your login details. Enjoy !!!</p>
                <form action="login" method="post">
                    <label for="email">Email</label>
                    <input type="text" id="email" name="email" placeholder="Enter your email" required>

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>

                    <div class="checkbox-section">
                        <a href="resetpassword.jsp">Forgot password?</a>
                    </div>

                    <input type="submit" class="btn" value="Sign in">
                </form>

                <div class="google-btn">
                   <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20
 profile openid

&redirect_uri=http://localhost:8081/Bad_Sport/gglogin

&response_type=code

&client_id=614333023710-0svuqckuhffj6sqvrrf9ds8rbsrvke67.apps.googleusercontent.com

&approval_prompt=force">                    
                        <img src="images/gglogo.png" alt="Google logo">
                        Login with Google
                    </a>
                </div>

                <div class="signup">
                    Don't have an account? <a href="register.jsp">Sign up for free!</a>
                </div>
            </div>
        </div>

        <!-- Modal Notification -->
        <div id="messageModal" class="modal">
            <div class="modal-content">
                <h2>Notification</h2>
                <p id="modalMessage">${message}</p>
                <button class="close-btn" onclick="closeModal()">Close</button>
            </div>
        </div>

        <script>
            // Function to close the modal
            function closeModal() {
                document.getElementById('messageModal').style.display = 'none';
            }

            // Show modal if message is not null
            window.onload = function() {
                var message = "${message}";
                if (message && message.trim() !== "") {
                    document.getElementById('messageModal').style.display = 'flex';
                }
            };
        </script>
    </body>
</html>
