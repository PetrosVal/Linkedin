<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page import="entities.AppEntities.Friend_Request" %>
<%@ page import="entities.AppEntities.Personal_Information" %>
<%@ page import="dao.Personal_InformationDAO" %>
<%@ page import="dao.Friend_RequestDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%  User sessionUser = (User) request.getSession().getAttribute("user");
    if(sessionUser==null ) {
        response.sendRedirect("error_page.jsp");
    }
%>

<html>
<head>
    <title>Το Δίκτυο μου</title>

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

        </br><h3>Το Δίκτυο μου</h3></br>

        <%
            if (sessionUser != null) {
                String username = sessionUser.getUsername();
                Friend_RequestDAO dao = new Friend_RequestDAO(true);
                Personal_InformationDAO pdao = new Personal_InformationDAO(true);

                List<Friend_Request> userFriendRequests = dao.getFriendRequestsAccepted(username);

                for (int i = 0; i < userFriendRequests.size(); i++) {

                    Personal_Information personal_info = pdao.getPersonalInformationbyName(userFriendRequests.get(i).getRequest_to());
                    if(personal_info.getUser_info().equals(username)){

                        personal_info = pdao.getPersonalInformationbyName(userFriendRequests.get(i).getRequest_from());

                    }%>


        <div class="row" >


            <%--Info Section--%>
            <div class="col-sm-7 col-xs-7 col-md-7">

                <table style="table-layout:fixed; word-wrap: break-word;" id="userlist-table" class="table table-hover table-striped table-condensed ">
                    <tbody>
                    <tr>
                        <th>Username</th>
                        <td><%=personal_info.getUser_info()%></td>
                    </tr>

                    <tr>
                        <th>School</th>
                        <td><%=personal_info.getSchool()%></td>
                    </tr>
                    <tr>
                        <th>University</th>
                        <td><%=personal_info.getUniversity()%></td>
                    </tr>

                    <tr>
                        <th>Skills</th>
                        <td><%=personal_info.getSkills()%></td>
                    </tr>

                    <tr>
                        <th>Work_Experience</th>
                        <td><%=personal_info.getWork_Experience()%></td>
                    </tr>

                    <tr>
                        <th>Στείλε μήνυμα στον : </th>

                        <td><a href="PrivateMessage?id=<%=personal_info.getUser_info()%>"><%=personal_info.getUser_info()%></a></td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>

        <hr style="border-top: 1px solid #34525a">
        <%}
        }
        %>

    </div>
</div>


<jsp:include page="footer.jsp" />


</body>



<!-- jQuery -->
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

<script type="text/javascript">
    $(document).ready(function() {
        $('#dropDown').change(function () {
            $(this).find("option").each(function () {

                $('.' + this.value).hide();
            });
            $('.' + this.value).show();

            if (this.value == '2')
            {
                $('.' + '0').show();
                $('.' + '1').show();
                $('.' + '-1').show();
            }

        });
    });
</script>


</html>
