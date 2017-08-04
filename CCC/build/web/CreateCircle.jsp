
<%-- 
    Document   : CourseDelete
    Created on : Oct 28, 2014, 11:27:08 PM
    Author     : William
--%>

<%@page import="DBWorks.DBConnection"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Console Cowboys in CyberSpace</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
</head>

<body>
    
    <% 
        if(request.getParameter("createACircle") != null) {
                if(request.getParameter("circleName")!=null && request.getParameter("circleName")!=null)
                {
                    int circleID = 0;
                    // generate a new ID using a query to the database
                    String Query = "select max(circleID) from circle;"
                    ;
                    java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                    if(rs.next())
                        circleID = rs.getInt(1) + 1;
                    else
                        circleID = 1;
                    
                    String customerID = session.getAttribute("login").toString();
                    String circleName = request.getParameter("circleName");
                    String circleType = request.getParameter("circleType");
                    
                    Query = 
                        "INSERT INTO Circle(CircleID, CircleName, Type, Owner)"+
                        " VALUES ('"+circleID+"', '"+circleName+"', '"+circleType+"', '"+customerID+"');"
                    ;
                    int success = DBConnection.ExecUpdateQuery(Query);
                    
                    // once a user has created a circle, it would seem logical
                    // that said user is also a member of the circle
                    
                    Query = 
                        "INSERT INTO CircleMembership(CustomerID, CircleID)"+
                        " VALUES ('"+customerID+"', '"+circleID+"');"
                    ;
                    int success2 = DBConnection.ExecUpdateQuery(Query);
                    
                    // each time a circle is created, an associated page is also generated
                    // query to obtain a new pageID
                    int pageID = 0;
                    Query = "select max(pageID) from page;"
                    ;
                    rs =DBConnection.ExecQuery(Query);
                    if(rs.next())
                        pageID = rs.getInt(1) + 1;
                    else
                        pageID = 1;
                    
                    Query = 
                        "INSERT INTO Page(PageID, PostCount, AssociatedCircle)"+
                        " VALUES ('"+pageID+"', '0','"+circleID+"');"
                    ;
                    int success3 = DBConnection.ExecUpdateQuery(Query);
                    
                    // now redirect to the users circles page
                    response.sendRedirect("CustomerCircles.jsp");
                }
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function button1()
        {
            // validate input
            circleName = document.getElementById("cname").value;
            circleType = document.getElementById("ctype").value;
            
            if (circleName === "" || circleType === "")
            {
                text = "Please enter a name and a type for your Circle.";
                document.getElementById("invalidInput").innerHTML = text;
            } 
            else
            {
                document.form1.createACircle.value = "yes";
                form1.submit();
            }
            
        }
    </SCRIPT>
    

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="CustomerCircles.jsp">Console Cowboys In CyberSpace </a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%out.print(session.getAttribute("login")); %> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
                        </li>
                        <li>
                           <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="logout.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
             
             <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li>
                        <a href="CustomerCircles.jsp"><i class="fa fa-fw fa-street-view"></i> Circles</a>
                    </li>
                    <li>
                        <a href="ReceivedMessages.jsp"><i class="fa fa-fw fa-envelope-o"></i> Messages</a>
                    </li>
                    <li>
                        <a href="CustomerAccountHistory.jsp"><i class="fa fa-fw fa-leanpub"></i> Account History</a>
                    </li>
                    <li>
                        <a href="BestSellerItems.jsp"><i class="fa fa-fw fa-star"></i> Best Sellers</a>
                    </li>
                    <li>
                        <a href="SuggestedItems.jsp"><i class="fa fa-fw fa-cart-plus"></i> Suggested Items</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>

    <div id="page-wrapper">

            

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Create a New Circle
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="CustomerCircles.jsp"> Circles</a>
                            </li>
                            <li>
                                <i class="fa fa-envelope-o"></i>  <a href="ReceivedMessages.jsp"> Messages</a>
                            </li>
                            <li>
                                <i class="fa fa-leanpub"></i><a href="CustomerAccountHistory.jsp"> Account History</a>
                            </li>
                            <li>
                                <i class="fa fa-star"></i><a href="BestSellerItems.jsp"> Best Sellers</a>
                            </li>
                            <li>
                                <i class="fa fa-cart-plus"></i><a href="SuggestedItems.jsp"> Suggested Items</a>
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                
                <form name="form1" method="POST">
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cname">Circle Name:</label>
                            <input name="circleName" type="text" class="form-control" id="cname">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="ctype">Circle Type:</label>
                            <input name="circleType" type="text" class="form-control" id="ctype">
                        </div>
                    </div>
                    <div>
                        <p id="invalidInput"></p>

                        <input type="HIDDEN" name="createACircle">
                        <input TYPE="BUTTON" class="btn btn-default" value="Create Circle" ONCLICK="button1()">
                        <a class="btn btn-default" href="CustomerCircles.jsp">Back</a>
                    </div>
                </form>
</form>
          
            <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
