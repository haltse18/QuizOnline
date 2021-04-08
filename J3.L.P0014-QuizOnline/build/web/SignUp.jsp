<%-- 
    Document   : SignUp
    Created on : Feb 18, 2021, 4:48:27 PM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="img/usericon.png" type="image/jpg">
        <title>Create Account</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="css/signUpForm.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
        <script>
            function alertError(msg) {
                alert(msg);
            }

        </script>

    </head>
    <body>
        <div class="container">
            <br>
            <hr>
            <div class="card bg-light">
                <article class="card-body mx-auto" style="max-width: 400px;">
                    <h4 class="card-title mt-3 text-center">Create Account</h4>
                    <p class="divider-text">
                        <span class="bg-light"></span>
                    </p>
                    <form action="createuser" method="POST">
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                            </div>
                            <input name="txtFullname" value="${param.txtFullname}" class="form-control" placeholder="Full name" type="text" required="required" 
                                   pattern="[a-zA-Z]+" title="Cannot contains special symbols"/>
                        </div> <!-- form-group// -->
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                            </div>
                            <input name="txtEmail" value="${param.txtEmail}" class="form-control" placeholder="Email address" type="email" required="required" >
                        </div> <!-- form-group// -->
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                            </div>
                            <input id="password" name="txtPassword" value="${param.txtPassword}" class="form-control" placeholder="Create password" type="password" required="required">
                        </div> <!-- form-group// -->
                        <div class="form-group input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                            </div>
                            <input id="rpassword" name="txtPasswordRepeat" value="${param.txtPasswordRepeat}" class="form-control" placeholder="Repeat password" type="password" required="required">
                        </div> <!-- form-group// -->   

                        <c:if test="${param.txtPassword ne param.txtPasswordRepeat}">
                            <style>
                                #rpassword{
                                    border: 3px solid red;
                                }
                            </style>
                            
                        </c:if>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block"> Create Account  </button>
                        </div> <!-- form-group// -->      
                        <p class="text-center">Have an account? <a href="login.html">Log In</a> </p>                                                                 
                    </form>
                </article>
            </div> <!-- card.// -->
        </div>
        <c:if test="${not empty requestScope.CREATE_ERROR}">
            <script>
                alertError('${requestScope.CREATE_ERROR}');
            </script>
        </c:if>

    </body>
</html>
