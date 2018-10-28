<%@ page import="dao.NetworkingDAO" %>
<%@ page import="entities.AppEntities.Networking" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page import="entities.AppEntities.Personal_Information" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="dao.DAOUtil" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.Personal_InformationDAO" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>

</script>
<html>
<head>
    <title>Αποτελέσματα Αναζήτησης Χρηστών</title>

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

        <% UserDAO dao = new UserDAO(true);
            Personal_InformationDAO pdao = new Personal_InformationDAO(true);
            String page_str = request.getParameter("page");
            Integer pageid;
            if (page_str != null)
                pageid = DAOUtil.IntConvert(page_str);
            else
                pageid = 1;
            List<User> users = dao.getSearchResults(request.getParameter("text"), request.getParameter("location"), pageid);%>

        <br><h3>Βρέθηκαν <%=dao.getNumOfResults()%> αποτελέσματα</h3>

        <%--PAGING--%>
        <div class="alignright">
            <form class="form-horizontal" action="searchResults.jsp" method="get" >
                <% if (pageid > 1){%>
                <a class="btn btn-default" style="display:inline-block" href="searchResults.jsp?text=<%=request.getParameter("text")%>&location=<%=request.getParameter("location")%>&page=<%=pageid-1%>">
                    <strong><</strong>
                </a>
                <%}%>
                <input type="hidden" name="text" value="<%=request.getParameter("text")%>" />
                <input type="hidden" name="location" value="<%=request.getParameter("location")%>" />
                <input type="text" style="width: 40px; height: 33px; display:inline-block" name="page" value="<%=pageid%>" />
                από <%=dao.getNumOfPages()%>
                <% if (pageid < dao.getNumOfPages()){%>
                <a class="btn btn-default" style="display:inline-block" href="searchResults.jsp?text=<%=request.getParameter("text")%>&location=<%=request.getParameter("location")%>&page=<%=pageid+1%>">
                    <strong>></strong>
                </a>
                <%}%>
            </form>
        </div>
        <%--END OF PAGING--%>

        <br><br><hr style="border-top: 1px solid #34525a">

        <% for (int i = 0; i < users.size(); i++) {

            Personal_Information personal_info = pdao.getPersonalInformationbyName(users.get(i).getUsername());%>

        <div class="row" >
            <div class="col-sm-9 col-xs-9 col-md-9">

                <table style="table-layout:fixed; word-wrap: break-word;" id="userlist-table" class="table table-hover table-striped table-condensed ">
                    <tbody>
                    <tr>
                        <th>Όνομα</th>
                        <td><%=users.get(i).getUsername()%></td>
                    </tr>
                    <tr>
                        <th>Χώρα</th>
                        <td><%=users.get(i).getCountry()%></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%=users.get(i).getEmail()%></td>
                    </tr>
                    <tr>
                        <th>Στείλε μήνυμα στον : </th>

                        <td><a href="PrivateMessage?id=<%=users.get(i).getUsername()%>"><%=users.get(i).getUsername()%></a></td>
                    </tr>
                    <tr>
                        <th>Στείλε Αίτημα φιλίας στον : </th>

                        <td><a href="FriendRequest?id=<%=users.get(i).getUsername()%>"><%=users.get(i).getUsername()%></a></td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>

        <hr style="border-top: 1px solid #34525a">
        <%}%>

        <%--PAGING--%>
        <div class="alignright">
            <form class="form-horizontal" action="searchResults.jsp" method="get" >
                <% if (pageid > 1){%>
                <a class="btn btn-default" style="display:inline-block" href="searchResults.jsp?text=<%=request.getParameter("text")%>&location=<%=request.getParameter("location")%>&page=<%=pageid-1%>">
                    <strong><</strong>
                </a>
                <%}%>
                <input type="hidden" name="text" value="<%=request.getParameter("text")%>" />
                <input type="hidden" name="location" value="<%=request.getParameter("location")%>" />
                <input type="text" style="width: 40px; height: 33px; display:inline-block" name="page" value="<%=pageid%>" />
                από <%=dao.getNumOfPages()%>
                <% if (pageid < dao.getNumOfPages()){%>
                <a class="btn btn-default" style="display:inline-block" href="searchResults.jsp?text=<%=request.getParameter("text")%>&location=<%=request.getParameter("location")%>&page=<%=pageid+1%>">
                    <strong>></strong>
                </a>
                <%}%>
            </form>
        </div>
        <%--END OF PAGING--%>


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
</html>
