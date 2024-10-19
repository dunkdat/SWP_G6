<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Page</title>
        <link rel="stylesheet" href="css/registerstyle.css"/>
    </head>
    <body>
        <div class="container">
            <div class="form-section">
                <h1>REGISTER</h1>
                <p>Sign up to create your account.</p>
                <form action="register" method="post">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="${name}" required>

                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="${address}" required>

                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" required>
                        <option value="" disabled selected>Select Gender</option>
                        <option value="1" ${gender == 1 ? 'selected' : ''}>Male</option>
                        <option value="0" ${gender == 0 ? 'selected' : ''}>Female</option>
                    </select>

                    <label for="phone">Phone:</label>
                    <input type="text" id="phone" name="phone" value="${phone}" required>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="${email}" required>

                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="${password}" required>

                    <label for="confirm-password">Confirm Password:</label>
                    <input type="password" id="confirm-password" name="cfpassword" value="${cfpassword}" required>

                    <input type="submit" class="btn" value="Register">
                </form>

                <div class="signup">
                    Already have an account? <a href="login.jsp">Sign in</a>
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
