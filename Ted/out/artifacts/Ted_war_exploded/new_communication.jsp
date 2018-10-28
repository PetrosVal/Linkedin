<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.NetworkingDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.AppEntities.User" %>

<%  User sessionUser = (User) request.getSession().getAttribute("user");
    if(sessionUser==null || sessionUser.getRole() == 2) {
        response.sendRedirect("error_page.jsp");
        return;
    }
%>

<html>
<head>
    <title>Δημιουργία Νέας Αγγελίας</title>

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


    <link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>

</head>
<body>

<jsp:include page="header.jsp" />

<div class="maincontent-area">
    <div class="zigzag-bottom"></div>
    <div class="container">
        <div class="row">

            <form class="form-horizontal" action="Create" method="post" id="createcommunication" encType="multipart/form-data">

                </br><h3>Δημιουργία Νέας Επικοινωνίας</h3></br>
                <%  if (request.getAttribute("item-creation-error") != null) { %>
                <div class="alert alert-danger">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Προσοχή! </strong><%=request.getAttribute("item-creation-error")%>
                </div>
                <br>
                <% } %>

                <fieldset>
                    <!-- Auction Title -->
                    <div class="form-group required">
                        <label class="col-md-4 control-label" for="title">Τίτλος</label>
                        <div class="col-md-4">
                            <input id="title" name="title" placeholder="Τίτλος Επικοινωνίας" class="form-control input-md" required type="text">
                        </div>
                    </div>


                    <!-- Item Buy Price -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="country">Χώρα</label>
                        <div class="col-md-4">
                            <input id="country" name="country" placeholder="Χώρα" class="form-control input-md" type="text">
                        </div>
                    </div>


                    <!-- First Bid -->
                    <div class="form-group required">
                        <label class="col-md-4 control-label" for="creator">Δημιουργός Επικοινωνίας</label>
                        <div class="col-md-4">
                            <input id="creator" name="creator" placeholder="Δημιουργός Επικοινωνίας" class="form-control input-md" required type="text">
                        </div>
                    </div>

                    <!-- Country -->
                    <div class="form-group required">
                        <label class="col-md-4 control-label" for="comment">Σχόλιο</label>
                        <div class="col-md-4">
                            <input id="comment" name="comment" placeholder="Σχόλιο" class="form-control input-md" type="text">
                        </div>
                    </div>


                    <div class="form-group required">
                        <label class="col-md-4 control-label" for="datetimepicker_dark">Ημερομηνία/Ώρα λήξης</label>
                        <div class="col-md-4">
                            <div class="input-group date" >
                                <input name="date" id="datetimepicker_dark" type="text" placeholder="Ημερομηνία/Ώρα λήξης" class="form-control" required/>
                                <span class="input-group-addon">
                                        <i class="fa fa-calendar" aria-hidden="true"></i>
                                    </span>
                            </div>
                        </div>
                    </div>

                    <!-- Item Description -->
                    <div class="form-group required">
                        <label class="col-md-4 control-label" for="desc">Περιγραφή</label>
                        <div class="col-md-4">
                            <textarea class="form-control" rows="8" id="desc" name="desc" placeholder="Δώστε μια περιγραφή για την επικοινωνία." required></textarea>
                        </div>
                    </div>

                    <!-- Item Image browse -->
                    <div class="form-group">
                        <label class="col-md-4  control-label">Επιλογή Φωτογραφίας</label>
                        <div class="col-md-4">
                            <input id="input-1a" name="image" type="file" class="file form-control" data-show-preview="false" style="border:0; box-shadow: none; margin-left:-11px;">
                        </div>
                    </div>


                    <!-- Button -->
                    <div class="col-md-8">
                        <span class="pull-right">
                            <button id="create" name="create" class="btn btn-primary">Δημιουργία Αγγελίας</button>
                        </span>
                    </div>

                </fieldset>
            </form>
        </div>
    </div>
</div>


<jsp:include page="footer.jsp" />

</body>

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

<script src="javascript/jquery.js"></script>
<script src="javascript/jquery.datetimepicker.full.js"></script>

<script>
    $('#datetimepicker_dark').datetimepicker({theme:'dark'});
    //    $('#datetimepicker_dark2').datetimepicker({theme:'dark'});
</script>
</html>
