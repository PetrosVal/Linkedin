<%@ page import="entities.AppEntities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%  User sessionUser = (User) request.getSession().getAttribute("user");
    if(sessionUser!=null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<html>
<head>
    <title>Εγγραφή Νέου Χρήστη</title>

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

            <form class="form-horizontal" action="Register" method="post">

                </br><h3>Εγγραφή Χρήστη</h3>

                <%
                    Integer value = (Integer)request.getAttribute("register-error");
                    // email already exists error
                    if (value != null && value == -2) {%>
                <div class="alert alert-danger">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Προσοχή! </strong>Το email χρήστη υπάρχει ήδη. Προσπαθήστε ξανά με διαφορετικό.
        </div>
                <%}
                // Other error
                else if (value != null && value == -1){%>
                <div class="alert alert-danger">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Προσοχή! </strong>Υπήρξε ένα πρόβλημα κατά την εγγραφή. Προσπαθήστε ξανά.
                </div><%
            }
            // Pwd does not match
            else if (value != null && value == -3){%>
                <div class="alert alert-danger">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Προσοχή! </strong>Η επιβεβαίωση κωδικού δεν είναι ίδια. Προσπαθήστε ξανά.
                </div><%
                }%>


                <fieldset>
                    <!-- Text input-->

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="username">Όνομα Χρήστη</label>
                        <div class="col-md-4">
                            <input id="username" name="username" placeholder="Όνομα Χρήστη" class="form-control input-md"  required="" type="text">
                        </div>
                    </div>

                    <!-- Password input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="password">Κωδικός</label>
                        <div class="col-md-4">
                            <input id="password" name="password" placeholder="Κωδικός" class="form-control input-md" required="" type="password">

                        </div>
                    </div>

                    <!-- Password input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="password_repeat">Επαλήθευση Κωδικού</label>
                        <div class="col-md-4">
                            <input id="password_repeat" name="password_repeat" placeholder="Επαλήθευση Κωδικού" class="form-control input-md" required="" type="password">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="email">Email</label>
                        <div class="col-md-4">
                            <input id="email" name="email" placeholder="Email" class="form-control input-md" onblur="emailAvailability()" required="" type="text">
                            <div id="ajaxGetUserServletResponse" style="color: red"></div>

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="phone">Τηλέφωνο</label>
                        <div class="col-md-4">
                            <input id="phone" name="phone" placeholder="Τηλέφωνο" class="form-control input-md" required="" type="text">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="country">Χώρα Κατοικίας</label>
                        <div class="col-md-4">
                            <input id="country" name="country" placeholder="Χώρα Κατοικίας" class="form-control input-md" required="" type="text">
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="address">Διεύθυνση</label>
                        <div class="col-md-4">
                            <input id="address" name="address" placeholder="Διεύθυνση" class="form-control input-md" required="" type="text">
                        </div>
                    </div>

                    <!-- Select Basic -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="UserRole">Τύπος Χρήστη</label>
                        <div class="col-md-4">
                            <select id="UserRole" name="UserRole" class="form-control">
                                <option value="1">Επαγγελματίας</option>
                            </select>
                        </div>
                    </div>

                    <br>

                    <!-- Button -->
                    <div class="col-md-8">
                        <span class="pull-right">
                            <button id="register" name="register" class="btn btn-primary">Εγγραφή</button>
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
