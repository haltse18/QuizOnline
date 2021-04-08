<%-- 
    Document   : createQuestion
    Created on : Feb 22, 2021, 2:47:59 PM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Page</title>
        <link rel="shortcut icon" href="img/usericon.png" type="image/jpg">
        <!--Nav-bar script-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!--my css-->
        <link rel="stylesheet" href="css/home.css">

        <!---->
        <!--<link rel="stylesheet" href="css/create.css">-->
        <!--<script src="js/create.js"></script>-->
        <!--quiz card script-->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!--my script-->
        <script type="text/javascript">
            function alertErr(err){
                alert(err);
            }
            function genarateTextBox()
            {
                var max = document.getElementById("textCombo").value;

                var s = "<input type='text' name='answer_content' class='form-control' id='search' placeholder='Option " + 1 + "'/> </br>";
                for (var i = 2; i <= max; i++) {
                    s = s + "<input type='text' name='answer_content' class='form-control' id='search' placeholder='Option " + i + "'/> </br> ";
                }

                document.getElementById("answer_content").innerHTML = s;
                //document.createElement("<input type='text' name='test' placeholder='" + value + "'/>");

            }
        </script>
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
                <c:if test="${user.role eq 'Admin'}">
                    <button class="btn" href="createQuestion.jsp">Create New Question</button><br>
                    <h4 class="text-center">QUESTION DETAILS</h4>
                    <hr>
<!--                    ----------FORM------------->
                    <div class="container">
                        <form action="createQuestion" accept-charset="UTF-8" method="post">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="input-group">
                                        <input type="text" name="txtQ_Content" id="search" value="${param.txtQ_Content}" placeholder="Question Content" class="form-control" required="required">
                                        <br>
                                    </div>
                                    
                                    <br>
                                    <select name="cbSubject" class="form-control" required="required">
                                        <option value="-1">--Select Subject--</option>
                                        <option value="PRJ311">Java Desktop</option>
                                        <option value="PRJ321">Java Web</option>
                                    </select>
                                    <br>
                                    <select name="textCombo" class="form-control" id="textCombo" onchange="genarateTextBox()" >
                                        <option value="-1">--Select Option--</option>
                                        <c:forEach begin="2" end="7" varStatus="counter">
                                            <option value="${counter.count}"> ${counter.count} options</option>
                                        </c:forEach>
                                    </select>
                                    <br>
                                    <!--<div class="input-group">-->
                                    <div id="answer_content">
                                    </div>
                                    <!--</div>-->
                                    
                                    
                                    <!--<input type="checkbox" name="correctId" value="ON" checked=""/>-->
                                    <div class="input-group">
                                        <input type="text" name="txtCorrect_answer" id="search" value="${param.txtCorrect_answer}" placeholder="Correct answer" class="form-control" required="required">
                                        <br>
                                    </div>
                                        <br>
                                        <button type="submit" class="btn text-center">Create New Question</button><br>
                                        
                                        <c:if test="${not empty requestScope.CREATE_ERROR}">
                                            <script>
                                                alertErr('${requestScope.CREATE_ERROR}');
                                            </script>
                                        </c:if>
                                </div>
                            </div>
                        </form>
                    </div>
                </c:if>
            </div>

        </c:if>
        <c:if test="${empty user}">
            <c:redirect url="login.html"/>
        </c:if>
    </body>
</html>
