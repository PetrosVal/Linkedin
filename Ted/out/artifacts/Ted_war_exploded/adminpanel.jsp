<%@ page import="dao.UserDAO" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.DAOUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%  User sessionUser = (User) request.getSession().getAttribute("user");
    if(sessionUser == null || sessionUser.getRole() != 0){
        response.sendRedirect("error_page.jsp");
        return;
    }
%>
<html>
<head>
    <title>Πίνακας Διαχειριστή</title>

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
        </br><h3>Πίνακας Διαχείρισης Χρηστών</h3></br>
        <%--<div id="userlist" class="well col-lg-8 col-lg-offset-2 col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1 col-xs-12">--%>
        <div id="userlist" class="well col-md-10 col-md-offset-1 ">
            <table id="userlist-table" class="table table-hover table-striped table-condensed">
                <thead>
                <tr>
                    <th>Όνομα Χρήστη</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Ρόλος</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%  UserDAO dao = new UserDAO(true);
                    String page_str = request.getParameter("page");
                    Integer pageid;
                    if (page_str != null)
                        pageid = DAOUtil.IntConvert(page_str);
                    else
                        pageid = 1;
                    List<User> userlist = dao.getUserList(pageid);
                    for(int i=0; i < userlist.size(); i++){
                %>
                <tr>
                    <td><%=userlist.get(i).getUsername()%></td>
                    <td><%=userlist.get(i).getEmail()%></td>
                    <td><%=userlist.get(i).getAddress()%></td>
                    <% int role = userlist.get(i).getRole();
                        String roletext;
                        if (role==0) {
                            roletext = "Διαχειριστής";
                        }
                        else  {
                            roletext = "Eπαγγελματίας";
                        }

                    %>
                    <td><%=roletext%></td>
                    <td><a class="btn btn-primary" href="userprofile.jsp?id=<%=userlist.get(i).getUsername()%>" role="button">Προφίλ</a></td>

                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <%--PAGING--%>
        <div class="alignright">
            <form class="form-horizontal" action="adminpanel.jsp" method="get" >
                <% if (pageid > 1){%>
                <a class="btn btn-default" style="display:inline-block" href="adminpanel.jsp?page=<%=pageid-1%>">
                    <strong><</strong>
                </a>
                <%}%>
                <input type="text" style="width: 40px; height: 33px; display:inline-block" name="page" value="<%=pageid%>" />
                από <%=dao.getNumOfPages()%>
                <% if (pageid < dao.getNumOfPages()){%>
                <a class="btn btn-default" style="display:inline-block" href="adminpanel.jsp?page=<%=pageid+1%>">
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
</html>
