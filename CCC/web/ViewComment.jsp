
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
        
        // process unliking the comment
        if(request.getParameter("unLikeComment") != null && request.getParameter("unLikeComment").equals("yes")) {
                    
            // remove the commentlike
            String Query =  "delete from commentlikes"+
                            " where commentID ='"
                            + session.getAttribute("whichComment")+"'"
                            + " AND customerID ='"
                            + session.getAttribute("login")+"';"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now refresh the page
            response.sendRedirect("ViewComment.jsp");
        }  
            
        // process liking the comment
        if(request.getParameter("likeComment") != null && request.getParameter("likeComment").equals("yes")) {
                    
            String Query =  "Insert into commentlikes"+
                            " values('"
                            + session.getAttribute("whichComment")+"','"
                            + session.getAttribute("login")+"');"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now refresh the page
            response.sendRedirect("ViewComment.jsp");
        }
        
        // process deleting the comment
        if(request.getParameter("deleteComment") != null && request.getParameter("deleteComment").equals("yes")) {
            
            String Query =  "DELETE FROM Commentlikes"
                            + " where CommentID ='"+session.getAttribute("whichComment")+"';"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            Query =  "DELETE FROM Comment"
                            + " where CommentID ='"+session.getAttribute("whichComment")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // now send the user back to the view comment page
            response.sendRedirect("ViewCommentList.jsp");
            
            // don't finish processing this page
            return;
        }
        
        // process edit of the comment
        if(request.getParameter("editComment") != null && request.getParameter("editComment").equals("yes")) {
                    
            String newComment = request.getParameter("newComment");
            String Query =  "UPDATE Comment"+
                            " Set Date = CURDATE(),"
                            + " Content='"+newComment+"'"
                            + " where CommentID ='"+session.getAttribute("whichComment")+"';"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now refresh the page
            response.sendRedirect("ViewComment.jsp");
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        
        function unLikeCommentClicked()
        {
            document.formUnique.unLikeComment.value = "yes";
            formUnique.submit();
        }
        
        function likeCommentClicked()
        {
            document.formUnique.likeComment.value = "yes";
            formUnique.submit();
        }
        
        function editCommentClicked()
        {
            if(confirm("Are you sure you want to edit this comment?"))
            {
                document.formUnique.editComment.value = "yes";
                formUnique.submit();
            }
        }
        
        function deleteCommentClicked()
        {
            if(confirm("Are you sure you want to delete this comment?"))
            {
                document.formUnique.deleteComment.value = "yes";
                formUnique.submit();
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

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            <big>
                            <%  String Query = "select *"
                                                + " from comment    "
                                                + " where CommentID = '" +session.getAttribute("whichComment")+"';"
                                ;
                                java.sql.ResultSet theComment =DBConnection.ExecQuery(Query);
                                
                                if(theComment.next())
                                {
                                    out.print(theComment.getString(3));
                                }
                                
                                // get the author name
                                Query = "select FirstName, LastName from Customer"
                                        + " where CustomerID ='"+theComment.getString(4)+"';"
                                        ;
                                java.sql.ResultSet someRS =DBConnection.ExecQuery(Query);
                                String authorName="";
                                if(someRS.next())
                                    authorName = someRS.getString(1) +" "+ someRS.getString(2);
                            %>
                            </big>
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
                        <h2><% out.print(authorName); %> </h2>
                        <h4><% out.print(theComment.getString(2)); %> </h4>
                    </div>
                </div>
                <!-- /.row -->
                
                <form name="formUnique" method="POST">
                <%  // The owner of the comment can edit or delete the comment
                    Query = "select * "
                            + " from Comment"
                            + " where Author ='"+session.getAttribute("login")+"'"
                            + " AND CommentID = '"+theComment.getString(1)+"';"
                            ;
                    java.sql.ResultSet z =DBConnection.ExecQuery(Query);
                    if (z.isBeforeFirst())
                    {
                %>
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <textarea class="form-control" rows="5" name="newComment"> <% out.print(theComment.getString(3)); %></textarea>
                        </div>
                    </div>
                    <input type="HIDDEN" name="editComment">
                    <input TYPE="BUTTON" class="btn btn-default" value="Edit" ONCLICK="editCommentClicked()">
                    <input type="HIDDEN" name="deleteComment">
                    <input TYPE="BUTTON" class="btn btn-default" value="Delete" ONCLICK="deleteCommentClicked()">
                    <%
                    }
                    %>
                    <input type="HIDDEN" name="likeComment">
                    <input type="HIDDEN" name="unLikeComment">
                    <%
                        // if the user currently likes the comment then display an unlike
                        // button otherwise display a like button
                        Query = "select * "
                            + " from CommentLikes"
                            + " where CustomerID ='"+session.getAttribute("login")+"'"
                            + " AND CommentID = '"+session.getAttribute("whichComment")+"';"
                            ;
                        java.sql.ResultSet userLikesThis =DBConnection.ExecQuery(Query);
                        if (userLikesThis.isBeforeFirst())
                        {
                    %>
                        <input TYPE="BUTTON" class="btn btn-default" value="Unlike" ONCLICK="unLikeCommentClicked()">
                        <%
                        }
                        else
                        {
                        %>
                        <input TYPE="BUTTON" class="btn btn-default" value="Like" ONCLICK="likeCommentClicked()">
                <% 
                        }
                %>
                    <a class="btn btn-default" href="ViewCommentList.jsp">Back</a>
                <%
                        // display the number of likes on this comment if there are any
                        Query = "select count(*) from commentlikes"
                                + " where CommentID ='"+session.getAttribute("whichComment")+"';"
                                ;
                        java.sql.ResultSet anotherRS = DBConnection.ExecQuery(Query);
                        int numLikes = 0;
                        if(anotherRS.next())
                            numLikes = anotherRS.getInt(1);
                        if(numLikes > 0)
                        {
                        %>
                            <font size="4" color="ForestGreen">
                            <%  if (numLikes==1)
                                    out.print("1 user likes this comment");
                                else
                                    out.print(numLikes+" users like this comment");
                            %>
                            </font>
                        <%
                        }
                %>
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
