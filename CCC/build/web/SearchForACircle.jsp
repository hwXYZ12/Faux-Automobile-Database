
<%-- 
    Document   : CourseDelete
    Created on : Oct 28, 2014, 11:27:08 PM
    Author     : Ahmad
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
        java.sql.ResultSet check = (ResultSet) session.getAttribute("lastSearchedCircleSet");
        while(check!=null && check.next())
        {
            // check that none of the links have been clicked
            // if any have been, then redirect the user to the correct circle
            // page
            if (request.getParameter("circle" + check.getString(1))!=null)
            {   
                // clear the lastSearchedCircleSet variable
                session.setAttribute("lastSearchedCircleSet", null);
                session.setAttribute("whichCircle", check.getString(1));
                response.sendRedirect("Circle.jsp");
            }
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function submitButton()
        {
            document.form1.searchForACircle.value = "yes";
            form1.submit();
        }
        
        function goToCircle(s)
        {
            var form = "form"+s;
            var circle = "circle"+s;
            var r = confirm("View this circle?");
            if(r)
            {
                document.getElementById(circle).value = "yes";
                document.getElementById(form).submit();
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
                            Find a Circle
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

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cowner">Owner:</label>
                            <input name="circleOwner" type="text" class="form-control" id="cowner">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cID">Circle ID:</label>
                            <input name="circleID" type="text" class="form-control" id="cID">
                        </div>
                    </div>
                    <div>
                        <p id="invalidInput"></p>

                        <input type="HIDDEN" name="searchForACircle">
                        <input TYPE="BUTTON" class="btn btn-default" value="Search" ONCLICK="submitButton()">                        
                        <a class="btn btn-default" href="CustomerCircles.jsp">Back</a>
                    </div>
                </form>
                
                <!-- /#page-wrapper -->
                <%
                    if(request.getParameter("searchForACircle") != null) {
                            if( request.getParameter("circleName")!=null &&
                                request.getParameter("circleType")!=null &&
                                request.getParameter("circleOwner")!=null &&
                                request.getParameter("circleID")!=null)
                                {
                                    
                                String Query = "select * from Circle"
                                        + " where CircleID like '%"+request.getParameter("circleID")+"%'"
                                        + " AND CircleName like '%"+request.getParameter("circleName")+"%'"
                                        + " AND Type like '%"+request.getParameter("circleType")+"%'"
                                        + " AND Owner like '%"+request.getParameter("circleOwner")+"%'"
                                ;
                                
                                java.sql.ResultSet rs1 =DBConnection.ExecQuery(Query);
                                java.sql.ResultSet rs2 =DBConnection.ExecQuery(Query);
                                session.setAttribute("lastSearchedCircleSet", rs2);
                    
                %>
                <div class="row">
                    <div class="col-lg-6">
                        <h3>Results</h3>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <% if(!rs1.isBeforeFirst())
                                            {
                                         %><th> No circles  match the search criteria </th>
                                         <%
                                            } else
                                            {
                                         %>
                                         <th> Circle Name</th><th> Type </th><th> Owner</th>
                                         <%
                                            }
                                         %>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    while(rs1.next())
                                    {
                                %>
                                    <form id="<% out.print("form" + rs1.getString(1));%>" method="POST">
                                        <input  type="HIDDEN"
                                            name="<% out.print("circle" + rs1.getString(1));%>"
                                            id="<% out.print("circle" + rs1.getString(1));%>">
                                        <tr ONCLICK="goToCircle(<% out.print(rs1.getString(1));%>)">
                                                <td >
                                                    <% out.print(rs1.getString(2)); %>
                                                </td>
                                                <td >
                                                    <% out.print(rs1.getString(3)); %>
                                                </td>
                                                <td >
                                                    <% out.print(rs1.getString(4)); %>
                                                </td>
                                        </tr>
                                    </form>
                                <%
                                    } // while
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                                <%
                                }   // if
                    }   // other if
                                %>
                            

    </div>
    <!-- /#wrapper -->
                
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
