
<%-- 
    Document   : CourseDelete
    Created on : Oct 28, 2014, 11:27:08 PM
    Author     : William
--%>

<%@page import="DBWorks.DBConnection"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page buffer="200kb" autoFlush="false" %>

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
            var post = "post"+s;
            document.getElementById(post).value = "yes";
            document.getElementById(form).submit();
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
                        <a href="AddEmployee.jsp"><i class="fa fa-fw fa-user-plus"></i> Employee Tasks</a>
                    </li>
                    <li>
                        <a href="SalesReport.jsp"><i class="fa fa-fw fa-print"></i> Reports</a>
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
                            Customers
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
                        <h2>Click to select</h2>
                    </div>
                </div>
                <!-- /.row -->
                
                <div class="row">
                    <div class="col-lg-6">
                        <h3>Customers</h3>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <%
                                    
                                    String Query = 
                                        "SELECT	*" +
                                        " FROM      Customer;"
                                    ;
                                    java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                                    if(rs.isBeforeFirst())
                                    {
                                    %>
                                    <tr>
                                        <th> Customer ID </th>                                        
                                        <th> First Name </th>
                                        <th> Last Name </th>
                                    </tr>
                                    <% } else { %>
                                        <th> There are no customers! </th>
                                    <% } %>
                                </thead>
                                <tbody>
                                    <%
                                    int someInt=0;
                                    while(rs.next())
                                    {
                                    %>
                                    <form id="<% out.print("form" + someInt);%>" method="POST">
                                        <input  type="HIDDEN"
                                                name="<% out.print("post" + someInt);%>"
                                                id="<% out.print("post" + someInt);%>">
                                        <tr data-toggle="tooltip" data-placement="right" title="Click to view this customer!" 
                                            ONCLICK="linkClicked(<% out.print(someInt);%>)">
                                            <td><% out.print(rs.getString(1)); %></td>
                                            <td><% out.print(rs.getString(3)); %></td>
                                            <td><% out.print(rs.getString(4)); %></td>
                                        </tr>
                                    </form>
                                    <%

                                        // check that none of these links have been clicked
                                        // if any have been, then redirect to the edit customer page using the correct customerid
                                        if (request.getParameter("post" + someInt)!=null)
                                        {
                                            session.setAttribute("whichCustomer", rs.getString(1));
                                            response.sendRedirect("ManagerEditCustomer.jsp");
                                            return;
                                        }
                                        ++someInt;
                                    }
                                    %>
                                </tbody>
                            </table>



                        </div>
                    </div>
                </div>
                    
                <a class="btn btn-default" href="AddCustomer.jsp">Add a Customer</a>

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
