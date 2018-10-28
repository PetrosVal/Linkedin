<%@ page import="entities.AppEntities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%  User sessionUser = (User) request.getSession().getAttribute("user");
    if(sessionUser==null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<html>
<head>
    <title>Αλλαγή Ρυθμίσεων Χρήστη</title>

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

            <form class="form-horizontal" action="Settings" method="post">

                </br><h3>Αλλαγή Ρυθμίσεων Χρήστη</h3>

                <fieldset>

                    <!-- Password input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="new_password">Αλλαγή Κωδικού χρήστη</label>
                        <div class="col-md-4">
                            <input id="new_password" name="new_password" placeholder="Κωδικός" class="form-control input-md" required="" type="password">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="new_email">Αλλαγή email Χρήστη</label>
                        <div class="col-md-4">
                            <input id="new_email" name="new_email" placeholder="Email" class="form-control input-md" onblur="emailAvailability()" required="" type="text">
                            <div id="ajaxGetUserServletResponse" style="color: red"></div>

                        </div>
                    </div>

                    <br>

                    <!-- Button -->
                    <div class="col-md-8">
                        <span class="pull-right">
                            <button id="settings" name="settings" class="btn btn-primary">Αλλαγή</button>
                        </span>
                    </div>

                </fieldset>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="javascript/jquery-1.10.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/form.js"></script>
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

</body>
</html>
