<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page import="entities.AppEntities.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="dao.MessageDAO" %>
<%@ page import="dao.UserDAO" %>


<%--Make sure user is logged in--%>
<%
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
%>

<html>
<head>
    <title>Οι Συζητήσεις Μου</title>

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

    <style>
        /* make sidebar nav vertical */
        @media (min-width: 768px) {
            .sidebar-nav .navbar .navbar-collapse {
                padding: 0;
                max-height: none;
            }
            .sidebar-nav .navbar ul {
                float: none;
            }
            .sidebar-nav .navbar ul:not {
                display: block;
            }
            .sidebar-nav .navbar li {
                float: none;
                display: block;
            }
            .sidebar-nav .navbar li a {
                padding-top: 12px;
                padding-bottom: 12px;
                color: black;
                border: solid 1px #34525A;
            }

            .sidebar-nav .navbar-nav>.active>a, .sidebar-nav .navbar-nav>.active>a:hover, .sidebar-nav .navbar-nav>.active>a:focus {
                color: white;
                background-color: #588b99;
            }

            .hide{
                display: none;
            }

            .sidebar-nav .navbar-nav .dropdown-menu>.active>a, .dropdown-menu>.active>a:focus, .dropdown-menu>.active>a:hover {
                color: white;
                background-color: #2f9a86;
            }

            .table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
                background-color: #c1c1c1;
            }

            tr {
                cursor: pointer;
            }

            .is_read-0 {
                background-color: #c1c1c1;
                color: black;
                font-weight: bold;
            }


        }
    </style>

</head>
<body>

<jsp:include page="header.jsp" />

<div class="maincontent-area">
    <div class="zigzag-bottom"></div>
    <div class="container">

        <% if (request.getAttribute("send-message-success") == "yes") { %>
        <br>
        <div class="alert alert-success">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            Το Μήνυμα σας στάλθηκε επιτυχώς!
        </div>
        <% } %>

        <div class="row">
            <br><h3>Τα Μηνύματα μου</h3><br>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <div class="sidebar-nav">
                    <div class="navbar navbar-default" role="navigation">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-navbar-collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <span class="visible-xs navbar-brand">Μενού</span>
                        </div>
                        <div class="navbar-collapse collapse sidebar-navbar-collapse" style="background-color: white;">
                            <ul class="nav navbar-nav">

                                <%--Received--%>
                                <li class="active"><a href="#received">Εισερχόμενα</a></li>
                                <%--Sent--%>
                                <li><a class="link" href="#sent">Εξερχόμενα</a></li>
                                <%--Deleted--%>
                                <li><a class="link" href="#deleted">Διεγραμμένα &nbsp<span class="badge">10</span></a></li>
                                <%--Others--%>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle link" data-toggle="dropdown">Περισσότερα <b class="caret"></b></a>
                                </li>

                            </ul>
                        </div><!--/.nav-collapse -->
                    </div>
                </div>
            </div>
            <div class="col-sm-9 content-container">
                <div id = "received" class="active">
                    <table class="table table-hover">
                        <tbody>
                        <%
                            MessageDAO dao = new MessageDAO(true);
                            List<Message> received = dao.getMessages(sessionUser.getUsername(), 0);
                            List<Message> sent = dao.getMessages(sessionUser.getUsername(), 1);

                            for (Message msg : received){
                                Date end_t = msg.getDate();
                                SimpleDateFormat end_format = new SimpleDateFormat("dd/MM/yyyy hh:mm");
                                String ended = end_format.format(end_t);
                                User sender = new UserDAO(true).getUserbyName(msg.getSender_id());
                                String sender_username = sender.getUsername();


                        %>
                        <tr class='is_read-<%=msg.getIs_read()%>' >
                            <td class='clickable-row' data-href='message.jsp?id=<%=msg.getTitle()%>&type=rec'><%=sender_username%></td>
                            <td class='clickable-row title' data-href='message.jsp?id=<%=msg.getTitle()%>&type=rec'><%=msg.getTitle()%></td>
                            <td class='clickable-row' data-href='message.jsp?id=<%=msg.getTitle()%>&type=rec'><%=ended%></td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>

                </div>
                <div id = "sent" class="hide">
                    <table class="table table-hover">
                        <tbody>
                        <%

                            for (Message msg : sent){
                                Date end_t = msg.getDate();
                                SimpleDateFormat end_format = new SimpleDateFormat("dd/MM/yyyy hh:mm");
                                String ended = end_format.format(end_t);
                                User receiver = new UserDAO(true).getUserbyName(msg.getReceiver_id());
                                String receiver_username = receiver.getUsername();



                        %>
                        <tr data-href='message.jsp?id=<%=msg.getTitle()%>'>
                            <td class='clickable-row' data-href='message.jsp?id=<%=msg.getTitle()%>&type=send'><%=receiver_username%></td>
                            <td class='clickable-row title' data-href='message.jsp?id=<%=msg.getTitle()%>&type=send'><%=msg.getTitle()%> </td>
                            <td class='clickable-row' data-href='message.jsp?id=<%=msg.getTitle()%>&type=send'><%=ended%></td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                </div>
                <div id="deleted" class="hide">
                    <span style="font-size: 25px; font-weight: bold;">Deleted Messages</span>
                </div>
                <div id="others" class="hide">
                    <span style="font-size: 25px; font-weight: bold;">Other Messages</span>
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

<script>
    $(document).ready(function() {
        $('.sidebar-nav .navbar-nav li a').click(function(event){
            event.preventDefault();//stop browser to take action for clicked anchor

            //get displaying tab content jQuery selector
            var active_tab_selector = $('.sidebar-nav .navbar-nav > li.active > a').attr('href');

            //find actived navigation and remove 'active' css
            var actived_nav = $('.sidebar-nav .navbar-nav > li.active');
            actived_nav.removeClass('active');

            //add 'active' css into clicked navigation
            $(this).parents('li').addClass('active');

            //hide displaying tab content
            $(active_tab_selector).removeClass('active');
            $(active_tab_selector).addClass('hide');

            //show target tab content
            var target_tab_selector = $(this).attr('href');
            $(target_tab_selector).removeClass('hide');
            $(target_tab_selector).addClass('active');
        });
    });
</script>

<script>
    $(document).ready(function($) {
        $(".clickable-row").click(function() {
            window.location = $(this).data("href");
        });
    });
</script>

</body>


</html>
