
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
    
    
    <%  String Query = "select *"
                        + " from circle    "
                        + " where CircleID = " +session.getAttribute("whichCircle")+";"
        ;
        java.sql.ResultSet theCircle =DBConnection.ExecQuery(Query);
        theCircle.next();
        String owner = theCircle.getString(4);
        
        // perform a check here that the owner of the circle is the one
        // deleting its users!
        if (!session.getAttribute("login").equals(owner))
            response.sendRedirect("login.jsp");
            
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function linkClicked(s)
        {
            // double check that the user isn't also the owner of the group!
            if(<% out.print(owner); %> === s)
            {
                alert("You can't delete the owner of the circle!");
                return;
            }
            
            // refreshes the page with a link selected
            var form = "form"+s;
            var user = "user"+s;
            if(confirm("Are you sure you want to remove this user?"))
            {
                document.getElementById(user).value = "yes";
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

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Remove a User
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
                        <h2>Click to select </h2>
                    </div>
                </div>
                <!-- /.row -->
                
                <div class="row">
                    <div class="col-lg-6">
                        <h3>Membership</h3>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th> User </th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%

                                String circleID = session.getAttribute("whichCircle").toString();
                                Query = 
                                    "SELECT	CustomerID" +
                                    " FROM      CircleMembership " +
                                    " WHERE	CircleID = '" + circleID + "';"
                                ;
                                java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                                
                                while(rs.next())
                                {
                                %>
                                    <form id="<% out.print("form" + rs.getString(1));%>" method="POST">
                                        <input  type="HIDDEN"
                                                name="<% out.print("user" + rs.getString(1));%>"
                                                id="<% out.print("user" + rs.getString(1));%>">
                                        <tr data-toggle="tooltip" data-placement="right" title="Click to remove this user!" 
                                            ONCLICK="linkClicked(<% out.print(rs.getString(1));%>)">
                                            <td ><% out.print(rs.getString(1)); %></td>
                                        </tr>
                                    </form>
                                    <%

                                        // check that none of these links have been clicked
                                        // if any have been, then remove the user that had been selected
                                        // and refresh the page
                                        if (request.getParameter("user" + rs.getString(1))!=null)
                                        {
                                            Query = "delete from circlemembership"
                                                    + " where CustomerID='"+rs.getString(1)+"'"
                                                    + " AND CircleID='"+session.getAttribute("whichCircle")+"';"
                                                    ;
                                            int success = DBConnection.ExecUpdateQuery(Query);
                                            response.sendRedirect("RemoveFromCircle.jsp");
                                            return;
                                        }
                                }
                                %>
                                </tbody>
                            </table>



                        </div>
                    </div>
                </div>
                    
                <form name="formUnique" method="POST">
                    <a class="btn btn-default" href="Circle.jsp">Back</a>
                </form>   

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
