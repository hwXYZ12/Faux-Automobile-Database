
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
                            <%  String Query = "select *"
                                                + " from circle    "
                                                + " where CircleID = " +session.getAttribute("whichCircle")+";"
                                ;
                                java.sql.ResultSet theCircle =DBConnection.ExecQuery(Query);
                                
                                if(theCircle.next())
                                {
                                    out.print(theCircle.getString(2));
                                }
                            %>
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
                        <h2>Type - <% out.print(theCircle.getString(3)); %> </h2>
                        <h2>Owner - <% out.print(theCircle.getString(4)); %> </h2>
                    </div>
                </div>
                <!-- /.row -->
                
                <div class="row">
                    <div class="col-lg-6">
                        <h3>Posts</h3>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th> Post Content </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    // query to retrieve the pageID of this circle
                                    String pageID="";
                                    Query = "select PageID from page"
                                            + " where AssociatedCircle ='"+session.getAttribute("whichCircle")+"';"
                                    ;
                                    java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                                    if(rs.next())
                                        pageID = rs.getString(1);
                                    
                                    Query = 
                                        "SELECT	Content, PostID" +
                                        " FROM      Post " +
                                        " WHERE	PageID = '" + pageID + "';"
                                    ;
                                    rs =DBConnection.ExecQuery(Query);

                                    int someInt=0;
                                    while(rs.next())
                                    {
                                    %>
                                    <form id="<% out.print("form" + someInt);%>" method="POST">
                                        <input  type="HIDDEN"
                                                name="<% out.print("post" + someInt);%>"
                                                id="<% out.print("post" + someInt);%>">
                                        <tr data-toggle="tooltip" data-placement="right" title="Click to see the comments on this post!" 
                                            ONCLICK="linkClicked(<% out.print(someInt);%>)">
                                            <td>
                                                <% out.print(rs.getString(1)); %>
                                            </td>
                                        </tr>
                                    </form>
                                    <%

                                        // check that none of these links have been clicked
                                        // if any have been, then redirect to the comment page using the correct post
                                        if (request.getParameter("post" + someInt)!=null)
                                        {
                                            session.setAttribute("whichPost", rs.getString(2));
                                            response.sendRedirect("ViewCommentList.jsp");
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
                    
                <form name="form1" method="POST">
                <%  // Create a page and view associated pages buttons are only available to members of the circle
                    Query = "select CustomerID, CircleID"
                            + " from CircleMembership"
                            + " where CustomerID ='"+session.getAttribute("login")+"'"
                            + " AND CircleID = '"+session.getAttribute("whichCircle")+"';"
                            ;
                    java.sql.ResultSet z =DBConnection.ExecQuery(Query);
                    if (z.isBeforeFirst())
                    {
                %>
                    <a class="btn btn-default" href="CreatePost.jsp">Create a Post</a>
                    <a class="btn btn-default" href="Circle.jsp">View Members</a>
                <% 
                    }
                %>
                    <a class="btn btn-default" href="CustomerCircles.jsp">Back to Circles</a>
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
