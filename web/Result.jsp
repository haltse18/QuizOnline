<%-- 
    Document   : Result
    Created on : Mar 5, 2021, 3:03:18 PM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
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
                    <div class="row m-auto text-center w-75">
                        <div class="col-5"></div>

                        <c:set var="subject" value="${requestScope.SUBJECT}"/>
                        <c:set var="result" value="${requestScope.RESULT}"/>
                        <c:if test="${not empty result}">
                        <div class="col-3 princing-item green">
                            <div class="pricing-divider ">
                                <h3 class="text-light">${subject}</h3>
                                <h4 class="my-0 display-2 text-light font-weight-normal mb-3">${result}<span class="h1">/${sessionScope.TOTAL}</span></h4>
                                <svg class='pricing-divider-img' enable-background='new 0 0 300 100' height='100px' id='Layer_1' preserveAspectRatio='none' version='1.1' viewBox='0 0 300 100' width='300px' x='0px' xml:space='preserve' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns='http://www.w3.org/2000/svg' y='0px'>
                                <path class='deco-layer deco-layer--1' d='M30.913,43.944c0,0,42.911-34.464,87.51-14.191c77.31,35.14,113.304-1.952,146.638-4.729
                                      c48.654-4.056,69.94,16.218,69.94,16.218v54.396H30.913V43.944z' fill='#FFFFFF' opacity='0.6'></path>
                                <path class='deco-layer deco-layer--2' d='M-35.667,44.628c0,0,42.91-34.463,87.51-14.191c77.31,35.141,113.304-1.952,146.639-4.729
                                      c48.653-4.055,69.939,16.218,69.939,16.218v54.396H-35.667V44.628z' fill='#FFFFFF' opacity='0.6'></path>
                                <path class='deco-layer deco-layer--3' d='M43.415,98.342c0,0,48.283-68.927,109.133-68.927c65.886,0,97.983,67.914,97.983,67.914v3.716
                                      H42.401L43.415,98.342z' fill='#FFFFFF' opacity='0.7'></path>
                                <path class='deco-layer deco-layer--4' d='M-34.667,62.998c0,0,56-45.667,120.316-27.839C167.484,57.842,197,41.332,232.286,30.428
                                      c53.07-16.399,104.047,36.903,104.047,36.903l1.333,36.667l-372-2.954L-34.667,62.998z' fill='#FFFFFF'></path>
                                </svg>
                            </div>
                            <form action="review">
                                <div class="card-body bg-white mt-0 shadow">
                                    <ul class="list-unstyled mb-5 position-relative">
                                        <li><b>${requestScope.MARK}</b> points</li>
                                        <li><b>${requestScope.TIMEREMAIN}</b> times left</li>
                                    </ul>
                                    <button type="submit" class="btn btn-lg btn-block  btn-custom ">Review now</button>
                                    <input type="hidden" name="quizID" value="${requestScope.QUIZID}" />
                                </div>
                            </form>
                        </div>
                        </c:if>
                        <c:if test="${empty result}">
                            <h6>Opps, something went wrong!!</h6>
                        </c:if>


                        
                    </div>
                </c:if>
                <!--Quiz cards------------------------------------------>
                
        </c:if>
        <c:if test="${empty user}">
            <c:redirect url="login.html"/>
        </c:if>
    </body>
</html>
