<%@ page import="entities.AppEntities.Networking" %>
<%@ page import="dao.NetworkingDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="dao.User_does_NetworkingDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.AppEntities.User_does_Networking" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String auction_id = String.valueOf(request.getParameter("id"));
    User user = (User) request.getSession().getAttribute("user");

    NetworkingDAO idao = new NetworkingDAO(true);
    User_does_NetworkingDAO bdao = new User_does_NetworkingDAO(true);
    UserDAO udao = new UserDAO(true);

    Networking item = idao.getNetworkingByTitle(auction_id);

    //if not valid, error page
    if(item == null) {
        response.sendRedirect("error_page.jsp");
        return;
    }

    //List<User_does_Networking> bids = bdao.getItemBids(auction_id);
%>


<html>
<head>
    <title><%=item.getName()%> - Linkedin</title>

    <!-- Google Fonts -->
    <link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,200,300,700,600' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway:400,100' rel='stylesheet' type='text/css'>

    <!-- Bootstrap -->
    <%--<link rel="stylesheet" href="css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="css/jquery-ui.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <style>
        #map {
            width: 100%;
            height: 400px;
        }

        .btn-static {
            background-color: lightgrey;
            border: 1px solid grey;
            cursor: default;
        }
        .btn-static:active {
            -moz-box-shadow:    inset 0 0 0px white;
            -webkit-box-shadow: inset 0 0 0px white;
            box-shadow:         inset 0 0 0px white;
        }
    </style>

</head>
<body>

<jsp:include page="header.jsp" />

<div class="single-product-area">
    <%--<div class="zigzag-bottom"></div>--%>

    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <% if (request.getAttribute("wrong_input") == "yes") { %>
                <div class="alert alert-danger">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Προσοχή! </strong>Το πεδίο προσφοράς πρέπει να είναι αριθμός!
                </div>
                <% }%>
                <div class="product-content-right">

                    <div class="row">
                        <div class="col-sm-4">
                            <div class="product-images">
                                <div class="product-main-img">
                                    <%String image = item.getImage();

                                        // If there is an image uploaded for this item
                                        if (image != null) {%>
                                    <img class="img-responsive center-block" src="files/<%=image%>">
                                    <%}
                                    // Else use the default image
                                    else {%>
                                    <img class="img-responsive center-block" src="img/blank.png">
                                    <%}%>
                                </div>

                            </div>
                        </div>

                        <div class="col-sm-8">
                            <div class="product-inner">
                                <h2 class="product-name"><%=item.getName()%></h2>
                                <hr>

                                <div class="auction-info">
                                    <div class="row">
                                        <div class="col-md-8 gap">
                                            <span style="font-weight: bold;">Περιγραφή: </span> <%=item.getDescription()%>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-8 gap">
                                            <span style="font-weight: bold;">Σχόλιο: </span> $<%=item.getComment()%>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-8 gap">
                                            <span style="font-weight: bold;">Δημιουργός: </span> <%=item.getCreator()%>
                                        </div>
                                    </div>

                                    <div class="row gap">
                                        <%
                                            Date end_t = item.getEnds();
                                            SimpleDateFormat end_format = new SimpleDateFormat("MM/dd/yyyy hh:mm");
                                            String ended = end_format.format(end_t);
                                        %>
                                        <div class="col-md-1">
                                            <span style="font-weight: bold;">Απομένει: </span>
                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-8">
                                            <span style="font-weight: bold;">Πωλητής: </span> <a href="userprofile.jsp?id=<%=udao.getUserbyName(item.getCreator()).getUsername()%>"> <%=item.getCreator()%></a>
                                        </div>
                                    </div>


                                </div>

                                <br>
                                <br>

                                <br>
                                <br>




                                <%--Export XML Button--%>
                                <%if (user != null && user.getRole() == 0){%>
                                <div class="row">
                                    <form action="ExportXML" method="POST" id="export-xml">
                                        <div class="col-md-8">
                                            <br>
                                            <button id="export" name="export" value="<%=request.getParameter("id")%>" class="btn btn-warning">Export XML</button>
                                        </div>
                                    </form>
                                </div>
                                <%}%>

                                <br>

                                <div role="tabpanel">
                                    <ul class="product-tab" role="tablist">
                                        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Περιγραφή</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div role="tabpanel" class="tab-pane fade in active" id="home">
                                            <p style="text-align: justify;"><%=item.getDescription()%></p>
                                        </div>

                                        <div role="tabpanel" class="tab-pane fade" id="offers">

                                            <table id="offers-table" class="table table-striped hover display compact" cellspacing="0" width="100%">
                                                <thead>
                                                <tr>
                                                    <th>Όνομα Χρήστη</th>
                                                    <th>Προσφορά</th>
                                                    <th>Ημερομηνία/Ώρα</th>
                                                    <th>Χώρα</th>
                                                </tr>
                                                </thead>

                                                <tbody>


                                                </tbody>
                                            </table>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>



<jsp:include page="footer.jsp" />

</body>

<script src="javascript/jquery-1.10.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/form.js"></script>
<%--<script src="javascript/bootstrap.min.js"></script>--%>


<!-- jQuery sticky menu -->
<script src="javascript/owl.carousel.min.js"></script>
<script src="javascript/jquery.sticky.js"></script>

<!-- jQuery easing -->
<script src="javascript/jquery.easing.1.3.min.js"></script>

<!-- Main Script -->
<script src="javascript/main.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>

<%-- GOOGLE MAPS --%>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBn22YCesLQ6cAqQavGhd1lmwCIVUCZalo&callback=initialize">
</script>


<script>
    $(document).ready(function() {
        $('#offers-table').DataTable();
    });
</script>

</html>
