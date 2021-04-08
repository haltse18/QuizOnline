<%-- 
    Document   : takeQuiz
    Created on : Mar 4, 2021, 1:13:18 AM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Take Quiz</title>
        <link rel="shortcut icon" href="img/usericon.png" type="image/jpg">
        <!--Nav-bar script-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <!--my css-->
        <link rel="stylesheet" href="css/home.css">
        <!--question card css-->
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="css/quizcard.css">
        <script>
            window.onload = function () {
                var total = document.getElementById("totaltime").value;
                var maintime = document.getElementById("maintime").value;

//                document.getElementById("countdown").innerHTML = "<h6>im here " + total + "</h6>";
                var countDownDate = new Date().getTime() + total * 60000;
                // Update the count down every 1 second
                var x = setInterval(function () {

                    // Get today's date and time
                    var now = new Date().getTime();

                    // Find the distance between now and the count down date
                    var distance = countDownDate - now;

                    // Time calculations for days, hours, minutes and seconds
//                document.getElementById("timeleft").value = distance/60000;
                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    document.getElementById("timeleft").value = distance;
                    document.getElementById("timeremain").value = distance;

                    document.getElementById("bar-value").style = "width:" + distance / (maintime * 60000) * 100 + "%;";
                    // Output the result in an element with id="demo"
                    document.getElementById("countdown").innerHTML = minutes + ":" + seconds;

                    // If the count down is over, write some text 
                    if (distance === 0) {
                        var form = $('<form action="submitQuiz" method="post"> ' +
                                '<input type="text" id="timeremain" name="timeremain" value="' + distance + '"/></form>');
                        $('body').append(form);
                        form.submit();
                    }
                }, 1000);
            }
//            
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

                            <br>
                            <!-- PROFILE DROPDOWN - scrolling off the page to the right -->
                            <li class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" id="navDropDownLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-user-circle"></i>
                                    ${user.name}
                                </a>
                                <!--                                <div class="dropdown-menu" aria-labelledby="navDropDownLink">
                                <c:if test="${user.role eq 'Student'}">
                                    <a class="dropdown-item" href="#">History</a>
                                    <div class="dropdown-divider"></div>
                                </c:if>

                                <a class="dropdown-item" href="logout">Logout</a>
                            </div>-->
                            </li>
                        </ul>

                    </div>
                </div>

            </nav>
            <hr>


            <form action="takequiz" id="quizstart">
                <input type="hidden" name="totaltime" id="totaltime" value="${sessionScope.TIMEQUIZ}" />
                <input type="hidden" id="timeleft" name="timeleft"/>
                <input type="hidden" id="maintime" value="${sessionScope.MAINTIME}" />


                <table class="tboraNum"><div id="countdown"></div></table>							
                <div class="ora">
                    <div class="kohaProgress">
                        <div id="bar-value" class="progress-bar progress-bar-info"
                             role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100"
                             ></div></div></div>                



                <c:set var="map" value="${sessionScope.ANSWERMAP}"/>
                <c:if test="${not empty map}">
                    <c:set var="q_list" value="${sessionScope.QUESTIONLIST}"/>
                    <c:set var="noQ" value="${requestScope.NUMBER}"/>
                    <div class="privew">
                        <div class="questionsBox">
                            <div class="questions">${q_list.get(noQ).content}</div>
                            <ul class="answerList">
                                <c:forEach var="dto" items="${map.get(q_list.get(noQ).getId())}">
                                    <c:if test="${dto.check}">
                                        <li>
                                            <label>
                                                <input type="radio" name="answerGroup" checked value="${dto.id}" id="answerGroup_0">   ${dto.content}</label>
                                        </li> 
                                    </c:if>
                                    <c:if test="${!dto.check}">
                                        <li>
                                            <label>
                                                <input type="radio" name="answerGroup" value="${dto.id}" id="answerGroup_0">   ${dto.content}</label>
                                        </li> 
                                    </c:if>

                                </c:forEach>


                            </ul>

                            <input type="hidden" name="NUMBER" value="${noQ}" /> 
                            <input type="hidden" name="txtQuestionID" value="${q_list.get(noQ).id}" />
                            <c:if test="${noQ ne '0'}">
                                <div class="questionsRow"><button type="submit" name="btAction" value="pre" class="button" id="nextquestions">Previous</button> </div>

<!--                                    <input type="text" name="tempAnswer" value="${param.answerGroup}" />
<input type="hidden" name="txtQuestionID" value="${q_list.get(noQ).id}" />-->
                            </c:if>


                            <c:if test="${(noQ + 1) ne sessionScope.TOTAL}">
                                <div class="questionsRow"><button type="submit" name="btAction" value="next" class="button" id="nextquestions">Next</button> </div>
                                <!--<input type="hidden" name="NUMBER" value="${noQ + 1}" />-->  
<!--                                        <input type="hidden" name="tempAnswer" value="${param.answerGroup}" />
                                <input type="hidden" name="txtQuestionID" value="${q_list.get(noQ).id}" />-->

                            </c:if>
                            </form>

                            <form action="submitQuiz">
                                <input type="hidden" id="timeremain" name="timeremain"/>
                                <div class="questionsRow"><button type="submit" class="button" id="nextquestions"
                                                                  onclick="return confirm('Do you really want to submit?')">Submit</button> 

                            </form>
                            <span>${noQ + 1} of ${sessionScope.TOTAL}</span></div>
                    </div>
                </div>
            </c:if>




        </c:if>
        <c:if test="${empty user}">
            <c:redirect url="login.html"/>
        </c:if>
</body>
</html>
