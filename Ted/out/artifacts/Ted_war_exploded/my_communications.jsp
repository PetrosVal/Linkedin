<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page import="entities.AppEntities.Networking" %>
<%@ page import="dao.NetworkingDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="entities.AppEntities.Friend_Request" %>
<%@ page import="dao.Friend_RequestDAO" %>

<%  User sessionUser = (User) request.getSession().getAttribute("user");
    if(sessionUser==null ) {
        response.sendRedirect("error_page.jsp");
    }
%>

<html>
<head>
    <title>Οι Αγγελίες </title>

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

        </br><h3>Οι Αγγελίες </h3></br>

        <% if (request.getAttribute("auction-creation-success") == "yes") { %>
        <div class="alert alert-success">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>Eπιτυχία! </strong>Η Αγγελία σας δημιουργήθηκε!
        </div>
        <% } %>
        <% if (request.getAttribute("error-message") != null) { %>
        <div class="alert alert-danger">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>Προσοχή! </strong><%=(String) request.getAttribute("error-message")%>
        </div>
        <% }%>

        <div class="form-group">
            <div class="row">
                <div class="col-md-2 col-sm-2 pull-left">
                    <a href="new_communication.jsp" class="btn btn-primary" role="button">Νέα Αγγελία</a>
                </div>
                <div class="col-md-2 col-sm-2 pull-right">
                    <select id="dropDown" class="form-control">
                        <option value="2">Όλες</option>
                    </select>
                </div>
            </div>
        </div>

        <hr style="border-top: 1px solid #34525a">

        <%
            if (sessionUser != null) {
                String username = sessionUser.getUsername();
                NetworkingDAO dao = new NetworkingDAO(true);
                Friend_RequestDAO fdao = new Friend_RequestDAO(true);

                // Get the networkings that belong to this user
                List<Networking> userNetworkings = dao.getUserNetworkings(username);
                List<Friend_Request> userFriends = fdao.getFriendRequestsAccepted(username);


                for (int i = 0; i < userNetworkings.size(); i++) {%>


            <div class="row" >

                <%--Image Section--%>
                <div class="col-sm-3 col-xs-3 col-md-3">
                    <a href="singleConversation.jsp?id=<%=userNetworkings.get(i).getName()%>" >
                        <%String image = userNetworkings.get(i).getImage();
                            // If there is an image uploaded for this item
                            if (image != null) {%>
                        <img class="img-responsive center-block" src="files/<%=image%>" style="height: 200px; width: 200px">
                        <%}
                        // Else use the default image
                        else {%>
                        <img class="img-responsive center-block" src="img/blank.png" style="height: 200px; width: 200px">
                        <%}%>
                    </a>
                </div>

                <%--Info Section--%>
                <div class="col-sm-7 col-xs-7 col-md-7">

                    <table style="table-layout:fixed; word-wrap: break-word;" id="userlist-table" class="table table-hover table-striped table-condensed ">
                        <tbody>
                        <tr>
                            <th>Τίτλος</th>
                            <td><a href="singleConversation.jsp?id=<%=userNetworkings.get(i).getName()%>" ><%=userNetworkings.get(i).getName()%></a></td>
                        </tr>

                        <tr>
                            <th>Δημιουργός Επικονωνίας</th>
                            <td><%=userNetworkings.get(i).getCreator()%></td>
                        </tr>
                        <tr>
                            <th>Χώρα</th>
                            <td><%=userNetworkings.get(i).getCountry()%></td>
                        </tr>

                        <tr>
                            <th>Σχόλιο</th>
                            <td><%=userNetworkings.get(i).getComment()%></td>
                        </tr>
                        <tr>
                            <th>Ημερομηνία/Ώρα Λήξης</th>
                            <td>
                                <%
                                    Date end_t = userNetworkings.get(i).getEnds();
                                    SimpleDateFormat end_format = new SimpleDateFormat("dd/MM/yyyy hh:mm");
                                    String ended = end_format.format(end_t);
                                %>
                                <%=ended%>
                            </td>
                        </tr>

                        <tr>
                            <th>Περιγραφή</th>
                            <td><%=userNetworkings.get(i).getDescription()%></td>
                        </tr>

                        </tbody>
                    </table>
                </div>
            </div>

            <hr style="border-top: 1px solid #34525a">
        <%}

            for (int i = 0; i < userFriends.size(); i++) {

               List<Networking> Networkings = dao.getUserNetworkings(userFriends.get(i).getRequest_to());
               if(username.equals(userFriends.get(i).getRequest_to())){
                    Networkings = dao.getUserNetworkings(userFriends.get(i).getRequest_from());
                }

                if(Networkings.size()==0){
                    continue;
                }

        %>

        <div class="row" >

            <%--Image Section--%>
            <div class="col-sm-3 col-xs-3 col-md-3">
                <a href="singleConversation.jsp?id=<%=Networkings.get(i).getName()%>" >
                    <%String image = Networkings.get(i).getImage();
                        // If there is an image uploaded for this item
                        if (image != null) {%>
                    <img class="img-responsive center-block" src="files/<%=image%>" style="height: 200px; width: 200px">
                    <%}
                    // Else use the default image
                    else {%>
                    <img class="img-responsive center-block" src="img/blank.png" style="height: 200px; width: 200px">
                    <%}%>
                </a>
            </div>

            <%--Info Section--%>
            <div class="col-sm-7 col-xs-7 col-md-7">

                <table style="table-layout:fixed; word-wrap: break-word;" id="userlist-table_" class="table table-hover table-striped table-condensed ">
                    <tbody>
                    <tr>
                        <th>Τίτλος</th>
                        <td><a href="singleConversation.jsp?id=<%=Networkings.get(i).getName()%>" ><%=Networkings.get(i).getName()%></a></td>
                    </tr>

                    <tr>
                        <th>Δημιουργός Επικονωνίας</th>
                        <td><%=Networkings.get(i).getCreator()%></td>
                    </tr>
                    <tr>
                        <th>Χώρα</th>
                        <td><%=Networkings.get(i).getCountry()%></td>
                    </tr>

                    <tr>
                        <th>Σχόλιο</th>
                        <td><%=Networkings.get(i).getComment()%></td>
                    </tr>
                    <tr>
                        <th>Ημερομηνία/Ώρα Λήξης</th>
                        <td>
                            <%
                                Date end_t = Networkings.get(i).getEnds();
                                SimpleDateFormat end_format = new SimpleDateFormat("dd/MM/yyyy hh:mm");
                                String ended = end_format.format(end_t);
                            %>
                            <%=ended%>
                        </td>
                    </tr>

                    <tr>
                        <th>Περιγραφή</th>
                        <td><%=Networkings.get(i).getDescription()%></td>
                    </tr>

                    </tbody>
                </table>
            </div>

        </div>

        <hr style="border-top: 1px solid #34525a">

        <%}

        }%>

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
