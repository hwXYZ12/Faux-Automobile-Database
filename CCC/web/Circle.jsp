
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
        // leave the circle
        if(request.getParameter("leaveCircle") != null && request.getParameter("leaveCircle").equals("yes"))
        {
            String q = "delete from circlemembership where"
                    + " circleid ='"+session.getAttribute("whichCircle")+"'"
                    + " and customerid='"+session.getAttribute("login")+"';"
                    ;
            DBConnection.ExecUpdateQuery(q);
            
            // refresh the page
            response.sendRedirect("Circle.jsp");
        }
        
        // accept a circle invite and redirct
        if(request.getParameter("acceptInvite") != null && request.getParameter("acceptInvite").equals("yes")) {
                    
            
            // add the customer to the viewed circle  
            String Query = 
                        "INSERT INTO CircleMembership(CustomerID, CircleID)"+
                        " VALUES ('"+session.getAttribute("login").toString()+"', '"
                        +session.getAttribute("whichCircle").toString()+"');"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            if (success > 0)
            {
                // remove the circle invite from the database
                Query = 
                        "DELETE From CircleInvite"+
                        " WHERE CustomerID = '"+session.getAttribute("login").toString()+"'"
                        +" AND CircleID = '"+session.getAttribute("whichCircle").toString()+"';"
                ;
                success = DBConnection.ExecUpdateQuery(Query);
            }
                    
            // now redirect to the users circles page
            response.sendRedirect("CustomerCircles.jsp");
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        
        function leaveCircleClicked()
        {
            if(confirm("Are you sure you wish to leave this circle?"))
            {    
                document.form1.leaveCircle.value = "yes";
                form1.submit();
            }
        }
        
        function acceptInviteClicked()
        {
            document.form1.acceptInvite.value = "yes";
            form1.submit();
        }
        
        function sendJoinRequestClicked()
        {
            document.form1.sendJoinRequest.value = "yes";
            form1.submit();
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
                                        <tr>
                                                <td> <% out.print(rs.getString(1)); %> </td>
                                        </tr>
                                    <%
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
                    <a class="btn btn-default" href="ViewPostList.jsp">View Posts</a>
                    
                <% 
                        // if you're NOT the owner but you ARE a member, then you have the option
                        // to leave the circle
                        if(!theCircle.getString(4).equals(session.getAttribute("login").toString()) )
                        {
                            %>
                                <input type="HIDDEN" name="leaveCircle">
                                <input TYPE="BUTTON" class="btn btn-default" value="Leave Circle" ONCLICK="leaveCircleClicked()">
                            <%
                        }
                    }
                %>
                
                                
                <%  // 'add a user' button only shows up if you are the owner of the circle
                    // similarly, the remove a user button also only shows up if the viewer is also the owner
                    // and the "rename a circle" button will also show up iff the user is the owner of the circle
                    if (theCircle.getString(4).equals(session.getAttribute("login").toString()) )
                    {
                %>
                    <a class="btn btn-default" href="SearchForAUser.jsp">Add a User</a>
                    <a class="btn btn-default" href="RemoveFromCircle.jsp">Remove a User</a>
                    <a class="btn btn-default" href="RenameCircle.jsp">Rename Circle</a>
                <% 
                    }
                %>
                    
                <%  // 'accept circle invite' only shows up if the person viewing the page has been invited
                    Query = "select *"
                            + " from CircleInvite    "
                            + " where CircleID = '" +session.getAttribute("whichCircle")+"'"
                            + " AND CustomerID = '"+session.getAttribute("login")+"';"
                            ;
                    java.sql.ResultSet invites =DBConnection.ExecQuery(Query);
                    if (invites.isBeforeFirst())
                    {
                %>
                    <input type="HIDDEN" name="acceptInvite">
                    <input TYPE="BUTTON" class="btn btn-default" value="Accept Invite" ONCLICK="acceptInviteClicked()">
                <% 
                    }
                %>
                
                <!--code to send a join request placed here so that the alert pops up when the page is loaded-->
                <%
                if(request.getParameter("sendJoinRequest") != null && request.getParameter("sendJoinRequest").equals("yes")) {

                // send a request to the circle owner to accept the user  
                String Query2 = 
                            "INSERT INTO CircleRequest(CustomerID, CircleID)"+
                            " VALUES ('"+session.getAttribute("login").toString()+"', '"
                            +session.getAttribute("whichCircle").toString()+"');"
                ;
                int success = DBConnection.ExecUpdateQuery(Query2);
                %>
                <SCRIPT LANGUAGE="JavaScript">
                    alert("A request has been sent to the circle owner to join this circle!");
                </script>
                <%
                }
                %>
                
                
                <%  // 'join circle' button only shows up if the person viewing the page has not been invited, is not
                    // a member of the group, and doesn't have a request pending
                    Query = "select CustomerID"
                            + " from Customer    "
                            + " where CustomerID = '"+session.getAttribute("login")+"'"
                            + " AND CustomerID NOT IN "
                            + "(select customerID from CircleMembership where "
                            + "CircleID = '" +session.getAttribute("whichCircle")+"'"
                            + " AND CustomerID = '"+session.getAttribute("login")+"')"
                            + " AND CustomerID NOT IN " 
                            + "(select customerID from CircleRequest where "
                            + "CircleID = '" +session.getAttribute("whichCircle")+"'"
                            + " AND CustomerID = '"+session.getAttribute("login")+"')"
                            + "AND CustomerID NOT IN "
                            + "(select customerID from CircleInvite where "
                            + "CircleID = '" +session.getAttribute("whichCircle")+"'"
                            + " AND CustomerID = '"+session.getAttribute("login")+"')"
                            ;
                    java.sql.ResultSet x =DBConnection.ExecQuery(Query);
                    if (x.isBeforeFirst())
                    {
                %>
                    <input type="HIDDEN" name="sendJoinRequest">
                    <input TYPE="BUTTON" class="btn btn-default" value="Join Circle" ONCLICK="sendJoinRequestClicked()"> 
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
