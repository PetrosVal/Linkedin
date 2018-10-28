
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
    <title>Προσωπικές Πληροφορίες</title>

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

            <form class="form-horizontal" action="Info" method="post">

                </br><h3>Προσωπικά Στοιχεία Χρήστη</h3>


                <fieldset>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="workexperience">Επαγγελματική Εμπειρία</label>
                        <div class="col-md-4">
                            <input id="workexperience" name="workexperience" placeholder="Επαγγελματική εμπειρία" class="form-control input-md"  required="" type="text">
                        </div>
                    </div>

                    <!-- Password input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="school">Σχολείο</label>
                        <div class="col-md-4">
                            <input id="school" name="school" placeholder="Σχολείο" class="form-control input-md" required="" type="text">

                        </div>
                    </div>

                    <!-- Password input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="university">Πανεπιστήμιο</label>
                        <div class="col-md-4">
                            <input id="university" name="university" placeholder="Πανεπιστήμιο" class="form-control input-md" required="" type="text">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="skills">Skills</label>
                        <div class="col-md-4">
                            <input id="skills" name="skills" placeholder="Skills" class="form-control input-md"  required="" type="text">

                        </div>
                    </div>


                    <!-- Text inphut-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="IsWorkExperiencePrivate">Private Επαγγελματική Εμπειρία</label>
                        <div class="col-md-4">
                            <input id="IsWorkExperiencePrivate" name="IsWorkExperiencePrivate"  class="radio"  type="radio">
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="IsSkillsPrivate">Private Skills</label>
                        <div class="col-md-4">
                            <input id="IsSkillsPrivate" name="IsSkillsPrivate"  class="radio"  type="radio">
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="IsUniversityPrivate">Private Πανεπιστήμιο</label>
                        <div class="col-md-4">
                            <input id="IsUniversityPrivate" name="IsUniversityPrivate"  class="radio"  type="radio">
                        </div>
                    </div>

                    <br>

                    <!-- Button -->
                    <div class="col-md-8">
                        <span class="pull-right">
                            <button id="info" name="info" class="btn btn-primary">Συμπλήρωση</button>
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
