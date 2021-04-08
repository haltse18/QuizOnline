<%-- 
    Document   : review
    Created on : Mar 6, 2021, 11:34:00 AM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review Page</title>
        <link rel="shortcut icon" href="img/usericon.png" type="image/jpg">
        <!--Nav-bar script-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!--my css-->
        <link rel="stylesheet" href="css/home.css">
        <!--quiz card script-->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!--question card script-->
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script> 
    </head>
    <body>
        <c:set var="user" value="${sessionScope.USERINFO}"/>
        <c:if test="${not empty user}">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
                        <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                            <li class="nav-item active">
                                <a class="nav-link" href="HomePage.jsp">
                                    <i class="fa fa-home"></i>
                                    Home <span class="sr-only">(current)</span></a>
                            </li>
                        </ul>
                        <ul class="navbar-nav ">
                            <c:if test="${user.role eq 'Admin'}">
                                <form action="search" method="POST" class="form-inline my-2 my-lg-0">
                                    <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" name="txtSearchValue" value="${param.txtSearchValue}">
                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>

                                    <select name="cbSubject" class="btn bg-light">
                                        <option value="">--Select Subject--</option>
                                        <option value="PRJ311">Java Desktop</option>
                                        <option value="PRJ321">Java Web</option>
                                    </select>
                                    <select name="cbStatus" class="btn bg-light">
                                        <option value="">--Select Status--</option>
                                        <option value="Active">Active</option>
                                        <option value="Deactive">Deactive</option>
                                    </select>
                                </form>
                            </c:if>
                            <br>
                            <!-- PROFILE DROPDOWN - scrolling off the page to the right -->
                            <li class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" id="navDropDownLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-user-circle"></i>
                                    ${user.name}
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navDropDownLink">
                                    <c:if test="${user.role eq 'Student'}">
                                        <a class="dropdown-item" href="#">History</a>
                                        <div class="dropdown-divider"></div>
                                    </c:if>

                                    <a class="dropdown-item" href="logout">Logout</a>
                                </div>
                            </li>
                        </ul>

                    </div>
                </div>

            </nav>
            <hr>

            <div class="container-fluid bg-gradient p-5">
                <!--Quiz cards------------------------------------------>
                <c:if test="${user.role eq 'Student'}">


                </c:if>
                <!--Quiz cards------------------------------------------>



                <c:set var="q_list" value="${requestScope.QUESTION_LIST}"/>
                <c:if test="${not empty q_list}">
                    <c:forEach var="question" items="${q_list}">


                        <div class="row bg-gradient input-group">

                            <div class="panel panel-primary ">
                                <div class="panel-heading ">                  
                                    <pre>${question.content} </pre>
                                </div><!--.panel-heading-->

                                <div class = "panel-body">
                                    <ul class = "list-group">
                                        <c:set var="ans_list" value="${requestScope.QUESTION_MAP.get(question.id)}"/>
                                        <c:if test="${not empty ans_list}">
                                            <c:forEach var="answer" items="${ans_list}">

                                                <c:if test="${answer.check}">
                                                    <li class = "list-group-item">
                                                        <div class="funkyradio-primary">
                                                            <input type="radio" name="radio" id="radio" checked="checked" disabled="true"/>
                                                            <label for="radio">${answer.content}</label>
                                                        </div>
                                                    </li>
                                                </c:if>
                                                <c:if test="${!answer.check}">
                                                    <li class = "list-group-item">
                                                        <div class="funkyradio-default">
                                                            <input type="radio" name="radio" id="radio" disabled="true"/>
                                                            <label for="radio" style="font-weight: normal;">${answer.content}</label>
                                                        </div>
                                                    </li>
                                                </c:if>
                                                <c:if test="${answer.correct}">
                                                    <li class = "list-group-item">
                                                        <div class="funkyradio-default">

                                                            <label style="font-weight: normal;">${answer.content}</label>
                                                        </div>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                            <br>



                                        </c:if>
                                    </ul>
                                </div>        
                            </div>
                        </div>



                    </c:forEach>
                </c:if>





            </c:if>
        </div>


        <c:if test="${empty user}">
            <c:redirect url="login.html"/>
        </c:if>
    </body>
</html>
