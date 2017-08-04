
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
    
    <SCRIPT LANGUAGE="JavaScript">
        function linkClicked(s)
        {
            // refreshes the page with a link selected
            var form = "form"+s;
            var circle = "circle"+s;
            if(confirm("Are you sure you want to delete this ad?"))
            {
                document.getElementById(circle).value = "yes";
                document.getElementById(form).submit();
            }
        }
        
        // enable tooltips
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();   
        });
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
                        <a href="CustomerRepAds.jsp"><i class="fa fa-fw fa-newspaper-o"></i> Advertisements</a>
                    </li>
                    <li>
                        <a href="RepTransactions.jsp"><i class="fa fa-fw fa-usd"></i> Transactions</a>
                    </li>
                    <li>
                        <a href="RepCustomerList.jsp"><i class="fa fa-fw fa-smile-o"></i> Customers</a>
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
                            Delete an Ad
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
  
                <div class="row">
                    <div class="col-lg-6">
                        <h2>Click to select</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                <%
                                String empID = session.getAttribute("login").toString();
                                String Query = 
                                    "SELECT	*" +
                                    " FROM      Advertisement " +
                                    " WHERE	EmployeeID = '" + empID + "';"
                                ;
                                java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                                if(rs.isBeforeFirst())
                                {
                                %>
                                    <tr>
                                        <th>Type</th>
                                        <th>Date</th>
                                        <th>Company</th>
                                        <th>Item Name</th>
                                        <th>Content</th>
                                        <th>Unit Price</th>
                                        <th>Available Units</th>
                                    </tr>
                                    <%
                                } else {
                                    %>
                                    <tr>
                                        <th> You aren't responsible for any ads! </th>
                                    </tr>
                                    <%
                                }
                                    %>
                                </thead>
                                <tbody>
                                <%
                                while(rs.next())
                                {
                                %>
                                    <form id="<% out.print("form" + rs.getString(1));%>" method="POST">
                                        <input  type="HIDDEN"
                                                name="<% out.print("circle" + rs.getString(1));%>"
                                                id="<% out.print("circle" + rs.getString(1));%>">
                                        <tr data-toggle="tooltip" data-placement="right" title="Click to delete this ad!" 
                                            ONCLICK="linkClicked(<% out.print(rs.getString(1));%>)">
                                            <td ><% out.print(rs.getString(3)); %></td>
                                            <td > <% out.print(rs.getString(4)); %> </td>
                                            <td > <% out.print(rs.getString(5)); %> </td>
                                            <td > <% out.print(rs.getString(6)); %> </td>
                                            <td > <% out.print(rs.getString(7)); %> </td>
                                            <td > <% out.print(rs.getString(8)); %> </td>
                                            <td > <% out.print(rs.getString(9)); %> </td>
                                        </tr>
                                    </form>
                                    <%

                                        // check that none of these links have been clicked
                                        // if any have been, then delete the associated ad
                                        if (request.getParameter("circle" + rs.getString(1))!=null)
                                        {
                                            // delete all sale records that refer to this ad
                                            Query =  "delete from sale"+
                                                            " where advertisementid='"
                                                    + rs.getString(1)+"';"
                                            ;
                                            int success = DBConnection.ExecUpdateQuery(Query);

                                            // delete the ad
                                            Query =  "delete from advertisement"+
                                                            " where advertisementid='"
                                                    + rs.getString(1)+"';"
                                            ;
                                            success = DBConnection.ExecUpdateQuery(Query);

                                            // refresh the page
                                            response.sendRedirect("DeleteAd.jsp");
                                            return;
                                        }
                                }
                                    %>

                                </tbody>
                            </table>



                        </div>
                    </div>
                </div>
                <a class="btn btn-default" href="CustomerRepAds.jsp">Back</a>
                
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
