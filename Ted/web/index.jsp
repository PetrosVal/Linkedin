
<%@ page import="dao.NetworkingDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="entities.AppEntities.User" %>
<%@ page import="entities.AppEntities.Networking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
    NetworkingDAO idao = new NetworkingDAO(true);
   // List<String> categories = idao.getCategories();
    User user = (User) request.getSession().getAttribute("user");
%>

<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Linkedin - A networking website! </title>

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

<div class="slider-area">
  <div class="zigzag-bottom"></div>
  <div class="item active">
    <div class="slide-bg slide-one"></div>
    <div class="slide-text-wrapper">
      <div class="slide-text">
        <div class="container">
          <div class="row">
            <div class="splash">
              <div class="heading">
                Αναζήτηση Χρηστών
              </div>
              <div class="subhead">
                Αναζητήστε, Δικτυωθείτε!
              </div>

              <form id="search" action="searchResults.jsp" method="get">
                <div class="search-bar">
                  <div class="input-group input-group-lg">
                    <input name="text" type="text" class="form-control" placeholder="Αναζήτηση..." aria-describedby="sizing-addon1">
                    <span class="input-group-btn">
                                            <button class="btn btn-secondary" id="search-btn" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample" >
                                                <span class="caret" id="search-caret"></span>
                                            </button>
                                            <button class="btn btn-primary" style="margin-left: 14px; border-radius: 3px;">
                                                Αναζήτηση
                                            </button>
                                        </span>
                  </div>
                </div>

                <div class="collapse" id="collapseExample">
                  <div class="card card-block">
                    <div class="form-group">
                      <div class="row">

                        <div class="col-md-4">
                          <label for="location" style="font-weight: 400;">Χώρα:</label>
                          <input name="location" type="text" class="form-control" id="location" placeholder="π.χ Ελλάδα">
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="promo-area">
  <div class="zigzag-bottom"></div>
  <div class="container">
    <div class="row">
      <div class="col-md-3 col-sm-6">
        <div class="single-promo">
          <i class="fa fa-linkedin"></i>
          <p>Linkedin</p>
        </div>
      </div>
      <div class="col-md-3 col-sm-6">
        <div class="single-promo">
          <i class="fa fa-user"></i>
          <p>Διασυνδέσεις</p>
        </div>
      </div>
      <div class="col-md-3 col-sm-6">
        <div class="single-promo">
          <i class="fa fa-lock"></i>
          <p>Ασφαλείς Συνομιλίες</p>
        </div>
      </div>
      <div class="col-md-3 col-sm-6">
        <div class="single-promo">
          <i class="fa fa-comments"></i>
          <p>Comments</p>
        </div>
      </div>
    </div>
  </div>
</div> <!-- End promo area -->



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
