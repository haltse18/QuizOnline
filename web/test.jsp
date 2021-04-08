<%-- 
    Document   : test
    Created on : Feb 22, 2021, 4:41:09 PM
    Author     : Luong Thanh Ha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC “-//W3C//DTD HTML 4.01 Transitional//EN”
    “http://www.w3.org/TR/html4/loose.dtd”>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test Page</title>
        <script type="text/javascript">
            function genarateTextBox()
            {
                var max = document.getElementById("textCombo").value;

                var s = "<input type='text' name='textbox' placeholder='Option " + 1 + "'/> </br>";
                for (var i = 2; i <= max; i++) {
                    s = s + "<input type='text' name='textbox' placeholder='Option " + i + "'/> </br> ";
                }
                document.getElementById("testdiv").innerHTML = s;
                //document.createElement("<input type='text' name='test' placeholder='" + value + "'/>");

            }
        </script>
    </head>
    <body>
        <h1>genarate textbox</h1>
        <select name="textCombo" id="textCombo" onchange="genarateTextBox()">
            <option value="-1">Select Option</option>
            <c:forEach begin="1" end="5" varStatus="counter">
                <option value="${counter.count}"> ${counter.count} options</option>
            </c:forEach>
        </select>
        
        <div id="testdiv">
        </div>
    </body>
</html>
