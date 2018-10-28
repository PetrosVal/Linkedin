<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.MessageDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page import="entities.AppEntities.Message" %>

<%
    // Make sure user is logged in
    User sessionUser;
    if (request.getSession().getAttribute("user")==null) {
        request.setAttribute("nologgedin","no");
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
        return;
    }
    else {
        sessionUser = (User) request.getSession().getAttribute("user");
    }

    // Get the message id passed
   String message_id = request.getParameter("id");
    String msg_type = request.getParameter("type");

    // Get full message using the id
    MessageDAO dao = new MessageDAO(true);
    Message message = dao.getMessageByTitle(message_id);

    // Check1: No message with this id
    // Check2: Illegal type
    if (message == null || (!msg_type.equals("send") && !msg_type.equals("rec"))){
        response.sendRedirect("error_page.jsp");
        return;
    }
%>
<html>
<head>
    <title>Απάντηση</title>

    <!-- Google Fonts -->
    <link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,200,300,700,600' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway:400,100' rel='stylesheet' type='text/css'>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="css/jquery-ui.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<jsp:include page="header.jsp" />

<div class="maincontent-area">
    <div class="zigzag-bottom"></div>
    <div class="container">
        <div class="row">
            <div class="col-md-12 ">
                <form method="get" action="SendMessage">
                    <div class="form-group ">
                        <input class="form-control" id="type" name="type" type="hidden" value="<%=msg_type%>"/>
                    </div>
                    <div class="form-group ">
                        <br>
                        <label class="control-label " for="title">Τίτλος</label>
                        <input class="form-control" id="title" name="title" type="text" placeholder="Τίτλος Μηνύματος" value="Reply<%=message.getTitle()%>"/>
                    </div>
                    <div class="form-group ">
                        <label class="control-label " for="message">Μήνυμα</label>
                        <textarea class="form-control" cols="40" id="message" name="message" rows="10"></textarea>
                    </div>
                    <div class="form-group">
                        <button id="submit" name="submit" class="btn btn-primary">Αποστολή Μηνύματος</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="javascript/jquery-1.10.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/bootstrap.min.js"></script>


<!-- jQuery sticky menu -->
<script src="javascript/owl.carousel.min.js"></script>
<script src="javascript/jquery.sticky.js"></script>

<!-- jQuery easing -->
<script src="javascript/jquery.easing.1.3.min.js"></script>

<!-- Main Script -->
<script src="javascript/main.js"></script>
</body>
</html>
