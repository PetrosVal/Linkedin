<%@ page import="entities.AppEntities.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.DAOUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%  String UserName = request.getParameter("id");
    //in case id parameter is missing or invalid
    if(UserName == null ) {
        response.sendRedirect("error_page.jsp");
    }
    User user = new UserDAO(true).getUserbyName(UserName);
    //if user doesnt exist
    if(user==null) {
        response.sendRedirect("error_page.jsp");
        return;
    }

    User sessionUser = (User) request.getSession().getAttribute("user");
    int sessionUserRole = -1;
    if (sessionUser != null)
        sessionUserRole = sessionUser.getRole();
%>
<html>
<head>
    <title>Προφίλ Χρήστη - <%=user.getUsername()%></title>

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

<div class="container">
    <div class="row">
        </br><h3>Προφίλ Χρήστη: <%=user.getUsername()%></h3><br>
        <div class="col-md-5  toppad  pull-right col-md-offset-3 ">
        </div>
        <div>
            <div class="panel panel-info">
                <div class="panel-heading" style="background-color:rgb(107, 154, 167); color:black; border-bottom: black;">
                    <h3 class="panel-title"><%=user.getUsername()%></h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="img/default-user.png" class="img-circle img-responsive"> </div>

                        <span class=" col-md-9 col-lg-9 ">
                            <table class="table table-user-information">
                                <tbody>
                                <tr>
                                    <td>Όνομα Χρήστη:</td>
                                    <td><%=user.getUsername()%></td>
                                </tr>
                                <tr>
                                    <td>Ρόλος:</td>
                                    <% int role = user.getRole();
                                        String roletext;
                                        if (role==0) {
                                            roletext = "Διαχειριστής";
                                        }
                                        else  {
                                            roletext = "Επαγγελματίας";
                                        }
                                        %>
                                    <td><%=roletext%></td>
                                </tr>
                                <tr>
                                    <td>Χώρα:</td>
                                    <td><%=user.getCountry()%></td>
                                </tr>
                                <tr>
                                    <td>Διεύθυνση:</td>
                                    <td><%=user.getAddress()%></td>
                                </tr>
                                <tr>
                                    <td>Email:</td>
                                    <td><%=user.getEmail()%></td>
                                </tr>
                                <tr>
                                    <td>Τηλέφωνο:</td>
                                    <td><%=user.getPhone()%></td>
                                </tr>
                                </tbody>
                            </table>
                            </span>
                    </div>

                    <%--Export XML Button--%>
                    <%if (user != null && user.getRole() != 0){%>
                    <div class="row">
                        <form action="ExportXML" method="POST" id="export-xml">
                            <div class="col-md-8">
                                <br>
                                <button id="export" name="export" value="<%=user.getUsername()%>" class="btn btn-warning">Export XML</button>
                            </div>
                        </form>
                    </div>
                    <%}%>
                </div>
            </div>
            <div class="panel-footer">
            </div>

        </div>
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
