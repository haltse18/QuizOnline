<%-- 
    Document   : History
    Created on : Mar 6, 2021, 1:23:38 PM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Page</title>
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
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
                                        <form action="searchHistory" method="POST">
                                            <button class="dropdown-item" type="submit">History</button>
                                        </form>
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

                    <c:set var="q_list" value="${requestScope.QUIZLIST}"/>
                    <c:if test="${not empty q_list}">




                        <div class="row bg-gradient input-group">

                            <div class="container">
                                <div class="row col-md-12 custyle">
                                    <table class="table table-striped custab">
                                        <thead>

                                            <tr>

                                                <th>Subject</th>
                                                <th>Marks</th>                                             
                                                <th>Time</th>
                                                <th class="text-center"></th>
                                                




                                            </tr>
                                        </thead>
                                        <c:forEach var="quiz" items="${q_list}">
                                            <form action="review">
                                            <tr>
                                                <td>${quiz.subjectID}</td> 
                                                <td>${quiz.mark}</td>                                             
                                                <td>${quiz.time}</td>
                                                <td class="text-center">
                                                    <button class="btn" type="submit">Review Quiz</button>
                                                    <input type="hidden" name="quizID" value="${quiz.id}" />
                                                </td>
                                            </tr>
                                            </form>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>




                    </c:if>
                    <c:if test="${empty q_list}">
                        <h6>No history yet.</h6>
                    </c:if>
                </c:if>
                <!--Quiz cards------------------------------------------>








            </c:if>
        </div>


        <c:if test="${empty user}">
            <c:redirect url="login.html"/>
        </c:if>
    </body>
</html>
