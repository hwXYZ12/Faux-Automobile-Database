
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
        if(request.getParameter("createAd") != null) {
            
                    int adID = 0;
                    // generate a new ID using a query to the database
                    String Query = "select max(advertisementID) from advertisement;"
                    ;
                    java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                    if(rs.next())
                        adID = rs.getInt(1) + 1;
                    else
                        adID = 1;
                    
                    String empID = session.getAttribute("login").toString();
                    String adType = request.getParameter("adType");
                    String adCompany = request.getParameter("adCompany");                    
                    String adItemName = request.getParameter("adItemName");                
                    String adContent = request.getParameter("adContent");
                    double adUnitPrice = Double.parseDouble(request.getParameter("adPrice"));
                    int adUnits = Integer.parseInt(request.getParameter("adUnits"));
                    
                    Query = 
                        "INSERT INTO advertisement("
                            + "AdvertisementID, EmployeeID, Type, Date"
                            + ", Company, ItemName, Content, UnitPrice, AvailableUnits)"
                            + " VALUES ('"+adID+"', '"+empID+"', '"+adType+"', CURDATE(), '"+adCompany+"'"
                            + ", '"+adItemName+"', '"+adContent+"', '"+adUnitPrice+"', '"+adUnits+"');"
                    ;
                    int success = DBConnection.ExecUpdateQuery(Query);
                    
                    // now redirect to the reps ads
                    response.sendRedirect("CustomerRepAds.jsp");
              
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function button1()
        {
            // validate input
            adType = document.getElementById("atype").value;
            adCompany = document.getElementById("acompany").value;
            adName = document.getElementById("aitemname").value;
            adContent = document.getElementById("acontent").value;
            adPrice = document.getElementById("aprice").value;
            adUnits = document.getElementById("aunits").value;
            
            if (adType === "" || adCompany === ""
                    || adName === "" || adContent === ""
                    || adPrice ==="" || adUnits === "")
            {
                text = "Please make sure you've entered input into all of the fields. <br/>"+
                        "Please make sure you've entered only numerical input"
                            +" into the Unit Price and Available Units fields.";
                document.getElementById("invalidInput").innerHTML = text;
            } 
            else
            {
                document.form1.createAd.value = "yes";
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
                            Create a New Advertisement
                        </h1>                        
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-fw fa-newspaper-o"><a href="CustomerRepAds.jsp"></i> Advertisements</a>
                            </li>
                            <li>
                                <i class="fa fa-fw fa-usd"><a href="RepTransactions.jsp"></i> Transactions</a>
                            </li>
                            <li>
                                <i class="fa fa-fw fa-smile-o"><a href="RepCustomerList.jsp"></i> Customers</a>
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                
                <form name="form1" method="POST">

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="atype">Ad Type:</label>
                            <input name="adType" type="text" class="form-control" id="atype">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="acompany">Company:</label>
                            <input name="adCompany" type="text" class="form-control" id="acompany">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="aitemname">Item Name:</label>
                            <input name="adItemName" type="text" class="form-control" id="aitemname">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="acontent">Content:</label>
                            <textarea class="form-control" rows="5" id="acontent" name="adContent"></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="aprice">Unit Price: </label>
                            <input name="adPrice" type="number"
                                   min="0" step="0.01" class="form-control" id="aprice">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="aunits">Available Units: </label>
                            <input name="adUnits" type="number"
                                   min="0" step="1" class="form-control" id="aunits">
                        </div>
                    </div>

                    <div>
                        <p id="invalidInput"></p>

                        <input type="HIDDEN" name="createAd">
                        <input TYPE="BUTTON" class="btn btn-default" value="Create Ad" ONCLICK="button1()">
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
