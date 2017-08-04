
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
        function search()
        {
            document.form1.initiateSearch.value = "yes";
            form1.submit();
        }
        
        function addUser(s)
        {
            var form = "form"+s;
            var user = "user"+s;
            var r = confirm("Are you sure you want to add this user to the circle?");
            if(r)
            {
                document.getElementById(user).value = "yes";
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

            <!-- /#page-wrapper -->
            <%
                            
                // we'll use a session variable to keep track of the last searched inPattern
                if(request.getParameter("initiateSearch") != null && request.getParameter("inPattern")!=null)
                    session.setAttribute("inPattern", request.getParameter("inPattern"));
            %>

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Search For User(s) To Add
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
                        <%  // get the circle we're working with
                            String Query1 = 
                            "SELECT	*" +
                            " FROM      Circle" +
                            " WHERE	CircleID = '" + session.getAttribute("whichCircle").toString() + "';"
                            ;
                            java.sql.ResultSet theCircle =DBConnection.ExecQuery(Query1);
                            if(theCircle.next())
                        %>
                        <h2> Circle Name - <% out.print(theCircle.getString(2)); %></h2>
                    </div>
                </div>
                <!-- /.row -->
                
                <form name="form1" method="POST">
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="pattern">Contains:</label>
                            <input name="inPattern" type="text" class="form-control" id="pattern"
                                   value="<%if(session.getAttribute("inPattern")!=null)
                                                {
                                                    out.print(session.getAttribute("inPattern").toString());
                                                }else
                                                    out.print("");%>">
                        </div>
                    </div>
                    <div>
                        <input type="HIDDEN" name="initiateSearch">
                        <input TYPE="BUTTON" class="btn btn-default" value="Search" ONCLICK="search()">
                    </div>
                </form>
</form>
          
            <!-- /#page-wrapper -->
            <%
                // we'll use a session variable to keep track of the last searched inPattern
                if(request.getParameter("initiateSearch") != null && request.getParameter("inPattern")!=null)
                    session.setAttribute("inPattern", request.getParameter("inPattern"));
                
                // repopulates the search results each time the page is loaded
                if(session.getAttribute("inPattern")!=null)
                {
                    // get all customers containing the searched phrase
                    // but are NOT in the circle already
                    // and are NOT pending a request for the circle
                    String Query2 = "select CustomerID from customer"
                            + " where CustomerID like '%"+session.getAttribute("inPattern")+"%'"
                            + " AND CustomerID NOT IN "
                            + "(select CustomerID from CircleMembership where "
                            + "CircleID = '"+theCircle.getString(1)+"')"
                            + " AND CustomerID NOT IN "
                            + "(select CustomerID from CircleInvite where "
                            + "CircleID = '"+theCircle.getString(1)+"');"
                    ;
                    // we use two different result sets since one result set will
                    // be used to build the results table while the other set
                    // will be used to check which element has been clicked
                    java.sql.ResultSet rs1 =DBConnection.ExecQuery(Query2);
                    java.sql.ResultSet rs2 =DBConnection.ExecQuery(Query2);
                    
            %>
            <div class="row">
                <div class="col-lg-6">
                    <h3>Results</h3>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <% if (!rs1.isBeforeFirst())
                                        {
                                     %><th> No users match the search criteria </th>
                                     <%
                                        } else
                                        {
                                     %>
                                     <th> Users </th>
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
                                <tr> 
                                    <form id="<% out.print("form" + rs1.getString(1));%>" method="POST">
                                        <input  type="HIDDEN"
                                            name="<% out.print("user" + rs1.getString(1));%>"
                                            id="<% out.print("user" + rs1.getString(1));%>">
                                        <td ONCLICK="addUser(<% out.print(rs1.getString(1));%>)">
                                            <% out.print(rs1.getString(1)); %>
                                        </td>
                                    </form>
                                </tr>
                            <%   
                                } // while
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <%
                    while(rs2.next())
                    {
                        // check that none of these links have been clicked
                        // if any have been, then add the appropriate user to the
                        // circle and refresh the page
                        if (request.getParameter("user" + rs2.getString(1))!=null)
                        {
                            Query2 = "INSERT INTO CircleInvite(CustomerID, CircleID)"+
                                    " VALUES ('"+rs2.getString(1).toString()+
                                    "', '"+session.getAttribute("whichCircle").toString()+"');"
                            ;
                            int success = DBConnection.ExecUpdateQuery(Query2);
                            if(success > 0)
                            {
                                %>
                                <script language="JAVASCRIPT">
                                    alert("The user <% out.print(rs2.getString(1).toString()); %> has"+
                                           " been sent a request to be added to the circle '<% out.print(theCircle.getString(2).toString()); %>' ");
                                    location.reload();
                                </script>
                                <%
                            } else 
                            {
                                %>
                                <script language="JAVASCRIPT">
                                    alert("ERROR - The user <% out.print(rs2.getString(1).toString()); %>"+
                                           " WILL NOT be added to the circle '<% out.print(theCircle.getString(2).toString()); %>' ");
                                    location.reload();
                                </script>
                                <%
                            }
                            return;
                        }
                    }   
                                
                } // if
            %>

    </div>
    <!-- /#wrapper -->

    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
