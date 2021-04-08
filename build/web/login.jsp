<%-- 
    Document   : login
    Created on : Feb 18, 2021, 11:22:21 AM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="css/loginForm.css">
        <link rel="shortcut icon" href="img/usericon.png" type="image/jpg">
        <script>
            function alertError(msg){
                alert(msg);
            }
            
        </script>
    </head>
    <body>
        <div class="wrapper fadeInDown">
            <div id="formContent">
                <!-- Tabs Titles -->
               
                <!-- Icon -->
                <div class="fadeIn first">
                    <img src="img/usericon.png" style="width: 128px;" id="icon" alt="User Icon" />
                </div>

                <!-- Login Form -->
                <form action="login" method="POST">
                    <input type="text" id="login" class="fadeIn second" name="txtUsername" placeholder="login" required="required">
                    <input type="text" id="password" class="fadeIn third" name="txtPassword" placeholder="password" required="required">
                    <input type="submit" class="fadeIn fourth" value="Log In">
                </form>

                <!-- Sign up -->
                <div id="formFooter">
                    Don't have an account?
                    <a class="underlineHover" href="SignUp.jsp">Sign Up</a>
                </div>
                
                <c:if test="${not empty requestScope.LOGINERROR}">
                    <script>
                        alertError('${requestScope.LOGINERROR}');
                    </script>
                </c:if>

            </div>
        </div>
    </body>
</html>
