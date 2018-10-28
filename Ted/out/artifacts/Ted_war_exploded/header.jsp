<%--
  Created by IntelliJ IDEA.
  User: pe21
  Date: 21/8/2018
  Time: 5:24 μμ
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="entities.AppEntities.User" %>

<div class="header-area">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <div class="user-menu">
                    <ul>
                        <li><a href="myprofile.jsp"><i class="fa fa-user"></i>Το Προφίλ μου</a></li>
                        <% if (request.getSession().getAttribute("user")==null){ %>
                        <li><a href="login.jsp" id="login_button"><i class="fa fa-user"></i>Σύνδεση</a></li>
                        <li><a href="register.jsp" id="register_button"><i class="fa fa-user"></i>Εγγραφή</a></li>
                        <% }
                        else {
                        %>
                        <li><a href="my_messages.jsp" ><i class="fa fa-envelope"></i>Συζητήσεις</a></li>
                        <%if (  ((User) request.getSession().getAttribute("user")).getRole() != 0){%>
                        <li><a href="my_communications.jsp" id="my_auctions"><i class="fa fa-user"></i>Αγγελίες</a></li>
                        <%}%>
                        <%if (  ((User) request.getSession().getAttribute("user")).getRole() != 0){%>
                        <li><a href="my_notifications.jsp" id="my_notifications"><i class="fa fa-user"></i>Ειδοποιήσεις</a></li>
                        <%}%>
                        <%if (  ((User) request.getSession().getAttribute("user")).getRole() != 0){%>
                        <li><a href="network.jsp" id="my_network"><i class="fa fa-user"></i>Δίκτυο</a></li>
                        <%}%>
                        <%if (  ((User) request.getSession().getAttribute("user")).getRole() != 0){%>
                        <li><a href="my_personal_info.jsp" id="my_personal_info"><i class="fa fa-user"></i>Προσωπικά Στοιχεία</a></li>
                        <%}%>
                        <%if (  ((User) request.getSession().getAttribute("user")).getRole() != 0){%>
                        <li><a href="my_settings.jsp" id="my_settings"><i class="fa fa-user"></i>Ρυθμίσεις</a></li>
                        <%}%>
                        <%if ( ((User) request.getSession().getAttribute("user")).getRole()==0){%>
                        <li><a href="adminpanel.jsp" id="admin_panel"><i class="fa fa-user"></i>Διαχείριση Χρηστών</a></li>
                        <%}%>
                        <li><a href="Logout" id="logout_button"><i class="fa fa-user"></i>Αποσύνδεση</a></li>
                        <%}%>
                    </ul>
                </div>
            </div>

            <div class="col-md-5">
                <div class="header-right">

                    <ul class="list-unstyled list-inline">
                        <li>

                            <% if (request.getSession().getAttribute("user")==null){ %>
                            Καλώς ήρθες, επισκέπτη!
                            <% } else {
                                User user = (User) request.getSession().getAttribute("user");
                                String username = user.getUsername();
                            %>
                            Καλώς ήρθες,<a href="myprofile.jsp" style="display: inherit; color: rgb(52, 82, 90); text-decoration: underline;"><%=username%>!</a>
                            <%}%>

                        </li>

                        <li class="dropdown dropdown-small">
                            <a data-toggle="dropdown" data-hover="dropdown" class="dropdown-toggle" href="#"><span class="key">Γλώσσα: </span><span class="value">Ελληνικά </span><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">English</a></li>
                                <li><a href="#">French</a></li>
                                <li><a href="#">German</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div> <!-- End header area -->

<div class="site-branding-area">
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <div class="logo">
                    <h1><a href="index.jsp">e<span>Linkedin</span> <span style = "font-size: 15px; color:rgb(119, 164, 175); font-weight: bold;">BETA</span></a></h1>
                </div>
            </div>

            <div class="col-sm-6">
                <% if (request.getSession().getAttribute("user")!=null){ %>
                <div class="shopping-item">
                    <a href="my_messages.jsp"><span id="msg">Loading...</span><i class="fa fa-envelope"></i><span class="product-count">0</span></a>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div> <!-- End site branding area -->

<div class="mainmenu-area">
    <div class="container">
        <div class="row">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="index.jsp">Αρχικη</a></li>
                    <li><a href="#">Γενικα</a></li>
                    <%--<li><a href="categories.jsp">Δημοπρασιες</a></li>--%>
                    <li><a href="#">Βοηθεια</a></li>
                    <li><a href="#">Επικοινωνια</a></li>
                </ul>
            </div>
        </div>
    </div>
</div> <!-- End mainmenu area -->



<script src="javascript/jquery-1.10.2.js"></script>
<script src="javascript/jquery-ui.js"></script>


<%
    // If user is logged in
    if (request.getSession().getAttribute("user") !=null ) {
        User sessionUser = (User) request.getSession().getAttribute("user");%>
<script>
    (function(){
        var messages = $('.product-count'),

            poll = function() {
                console.log("Hey");
                jQuery.ajax({
                    url: 'checkUserNewMessages',
                    method: "GET",
                    type: 'JSON',
                    data : "&userid ="+ <%=sessionUser.getUsername()%>,// query parameters 1st


                    success : function(response){
                        if (response != null){
                            $('.shopping-item').css('background-color', '#377d70');
                            $('.shopping-item a').css('color', '#222');


                        }
                        $('#msg').text('Μηνύματα');

                        $(messages).text(response);
                    },
                    error : function(){
                        console.log("ERROR at: checkUserNewMessages");
                        clearInterval(pollInterval);
                    }
                });
            },

            pollInterval = setInterval(function() {
                poll();
            }, 60000);

        poll();
    })();
</script>
<%}%>


