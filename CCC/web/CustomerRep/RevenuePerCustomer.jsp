<%-- 
    Document   : AllAds
    Created on : Oct 28, 2014, 11:27:08 PM
    Author     : Kevin
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

    <title>Console Cowboys in CyberSpace Employee</title>

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
                <a class="navbar-brand" href="StudentInformation.jsp">Console Cowboys in CyberSpace Employee</a>
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
                        <a href="TopSeller.jsp"><i class="fa fa-fw fa-fighter-jet"></i> Top Seller</a>
                    </li>
                    <li>
                        <a href="TopPurchaser.jsp"><i class="fa fa-fw fa-street-view"></i> Top Purchaser</a>
                    </li>
                    <li>
                        <a href="MostActive.jsp"><i class="fa fa-fw fa-exchange"></i> Most Active Items</a>
                    </li>
                    <li>
                        <a href="RevenuePerItem.jsp"><i class="fa fa-fw fa-money"></i> Revenue Per Item</a>
                    </li>
                    <li>
                        <a href="RevenuePerCustomer.jsp"><i class="fa fa-fw fa-ticket"></i> Revenue Per Customer</a>
                    </li>
                    <li>
                        <a href="AllAds.jsp"><i class="fa fa-fw fa-bar-chart"></i> Current Ads</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Summary of Revenue Per Customer
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="StudentInformation.jsp">Circles</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-file"></i> 
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                
                <div class="row">
                   
                </div>
                
                 <div class="row">
                    <div class="col-lg-6">
                        <h2>Revenue Per Customer</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th> Last Name </th>
                                        <th> First Name </th>
                                        <th> Customer ID </th>
                                        <th> Total Revenue </th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                String Query = 
                                    "SELECT    LastName AS 'Last Name', " +
                                               "FirstName AS 'First Name', " +
                                               "CustomerID, " +
                                               "SUM(UnitPrice * NumUnits) AS 'Total Revenue' " +
                                    "FROM     Customer NATURAL JOIN Account NATURAL JOIN " +
                                        "Sale NATURAL JOIN Advertisement " +
                                    "GROUP BY    CustomerID";
                                java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                                while(rs.next())
                                {
                               %>
                                  <tr>
                                      <td > <% out.print(rs.getString(1)); %> </td>
                                      <td > <% out.print(rs.getString(2)); %> </td>
                                      <td > <% out.print(rs.getString(3)); %> </td>
                                      <td > <% out.print(rs.getString(4)); %> </td>
                                     </tr>
                                   <%      		
                                 }
                                  %>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                                  
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
