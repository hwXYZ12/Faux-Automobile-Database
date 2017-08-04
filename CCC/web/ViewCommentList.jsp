
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
        
        // process deleting this post
        if(request.getParameter("deletePost") != null && request.getParameter("deletePost").equals("yes")) {
            
            // delete all likes that reference any comments that reference the post
            String Query =  "delete from commentlikes"+
                            " where commentID IN "
                            + "(select commentID from comment"+
                            " where postID ='"
                            + session.getAttribute("whichPost")+"');"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // delete all likes that reference the post
            Query =  "delete from postlikes"+
                            " where postID ='"
                            + session.getAttribute("whichPost")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // delete all comments that reference the post
            Query =  "delete from comment"+
                            " where postID ='"
                            + session.getAttribute("whichPost")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // remove the post
            Query =  "delete from post"+
                            " where postID ='"
                            + session.getAttribute("whichPost")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // now send the user back to his/her list of posts
            session.setAttribute("whichPost", null);
            response.sendRedirect("ViewPostList.jsp");
            return;
        } 
            
            
        // process unliking the post
        if(request.getParameter("unLikePost") != null && request.getParameter("unLikePost").equals("yes")) {
                    
            // remove the postlike
            String Query =  "delete from postlikes"+
                            " where postID ='"
                            + session.getAttribute("whichPost")+"'"
                            + " AND customerID ='"
                            + session.getAttribute("login")+"';"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now refresh the page
            response.sendRedirect("ViewCommentList.jsp");
        }  
            
        // process liking the post
        if(request.getParameter("likePost") != null && request.getParameter("likePost").equals("yes")) {
                    
            String Query =  "Insert into postlikes"+
                            " values('"
                            + session.getAttribute("whichPost")+"','"
                            + session.getAttribute("login")+"');"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now refresh the page
            response.sendRedirect("ViewCommentList.jsp");
        }
        
        if( request.getParameter("addComment")!=null
            && request.getParameter("addComment").equals("yes")
            && request.getParameter("newComment") != null)
        {
            // query the database for a new commentID
            int commentID = 0;
            String Query = "select max(commentID) from comment;"
            ;
            java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
            if(rs.next())
                commentID = rs.getInt(1) + 1;
            else
                commentID = 1;
            
            // add the new comment to the database
            String newComment = request.getParameter("newComment");
            Query =  "Insert into Comment "+
                            "values('"+commentID+"',NOW(),'"+newComment+"','"
                            +session.getAttribute("login")+"','"
                            +session.getAttribute("whichPost")+"');"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now refresh the page
            response.sendRedirect("ViewCommentList.jsp");
        }
        
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        
        function deletePostClicked()
        {
            if(confirm("Are you sure you want to delete this post?"))
            {
                document.formUnique.deletePost.value = "yes";
                formUnique.submit();
            }
        }
        
        function unLikePostClicked()
        {
            document.formUnique.unLikePost.value = "yes";
            formUnique.submit();
        }
        
        function likePostClicked()
        {
            document.formUnique.likePost.value = "yes";
            formUnique.submit();
        }
        
        function addCommentClicked()
        {
            document.formUnique.addComment.value = "yes";
            formUnique.submit();
        }
        
        function linkClicked(s)
        {
            // refreshes the page with a link selected
            var form = "form"+s;
            var comment = "comment"+s;
            document.getElementById(comment).value = "yes";
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
                            <big>
                            <%  String Query = "select *"
                                                + " from post    "
                                                + " where postID = " +session.getAttribute("whichPost")+";"
                                ;
                                java.sql.ResultSet thePost =DBConnection.ExecQuery(Query);
                                
                                if(thePost.next())
                                {
                                    out.print(thePost.getString(3));
                                }
                                
                                Query = "select FirstName, LastName from Customer"
                                        + " where CustomerID ='"+thePost.getString(5)+"';"
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
                        <h4><% out.print(thePost.getString(2)); %> </h4>
                    </div>
                </div>
                <!-- /.row -->
                
                <div class="row">
                    <div class="col-lg-6">
                        <h3>Comments</h3>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <%
                                        // query to retrieve the comments on this post
                                        String postID=thePost.getString(1);
                                        Query = "select * from comment"
                                                + " where postID ='"+postID+"'"
                                                + " order by date;"
                                        ;
                                        java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                                        if(rs.isBeforeFirst())
                                        {
                                    %>
                                    <tr>
                                        <th> Content </th>
                                        <th> Author </th>
                                        <th> Date </th>
                                    </tr>
                                    <%
                                        }
                                        else
                                        {
                                    %>
                                    <tr>
                                        <th> There are no comments on this post </th>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </thead>
                                <tbody>
                                    <%
                                        int someInt=0;
                                        while(rs.next())
                                        {
                                            String author="";
                                            Query= "select FirstName, LastName from Customer"
                                                    + " where CustomerID ='"+rs.getString(4)+"';"
                                                    ;
                                            java.sql.ResultSet theAuthor =DBConnection.ExecQuery(Query);
                                            if(theAuthor.next())
                                                author=theAuthor.getString(1)+" "+theAuthor.getString(2);
                                    %>
                                    <form id="<% out.print("form" + someInt);%>" method="POST">
                                        <input  type="HIDDEN"
                                                name="<% out.print("comment" + someInt);%>"
                                                id="<% out.print("comment" + someInt);%>">
                                        <tr data-toggle="tooltip" data-placement="right" title="Click to view this comment!" 
                                            ONCLICK="linkClicked(<% out.print(someInt);%>)">
                                            <td >   <% out.print(rs.getString(3)); %> </td>
                                            <td>    <% out.print(author); %> </td>
                                            <td>    <% out.print(rs.getString(2)); %> </td>
                                        </tr>
                                    </form>
                                    <%

                                        // check that none of these links have been clicked
                                        // if any have been, then redirect to the comment page using the correct post
                                        if (request.getParameter("comment" + someInt)!=null)
                                        {
                                            session.setAttribute("whichComment", rs.getString(1));
                                            response.sendRedirect("ViewComment.jsp");
                                            return;
                                        }
                                        ++someInt;
                                    }
                                    %>
                                </tbody>
                            </table>
                            
                            <form name="formUnique" method="POST">
                            <%  // The user must be in the circle to create a comment or like the post
                                Query = "select * "
                                        + " from CircleMembership"
                                        + " where CustomerID ='"+session.getAttribute("login")+"'"
                                        + " AND CircleID = '"+session.getAttribute("whichCircle")+"';"
                                        ;
                                java.sql.ResultSet z =DBConnection.ExecQuery(Query);
                                if (z.isBeforeFirst())
                                {
                            %>

                                <div class="row">
                                    <div class="form-group col-xs-5 col-lg-5">
                                        <textarea class="form-control" rows="5" name="newComment"></textarea>
                                    </div>
                                </div>
                                <input type="HIDDEN" name="addComment">
                                <input TYPE="BUTTON" class="btn btn-default" value="Add Comment" ONCLICK="addCommentClicked()">
                                <%
                                    // if the user owns the circle this post was created in, then he/she may delete it
                                    // he/she may also modify the post. This applies to the owner of the post as well.
                                    String q=       "select * from circle "
                                                    + " where Owner='"+session.getAttribute("login")+"'"
                                                    + " AND CircleID='"+session.getAttribute("whichCircle")+"';"
                                                    ;
                                    java.sql.ResultSet circleOwner = DBConnection.ExecQuery(q);
                                    
                                    q=       "select * from post "
                                                    + " where postauthor='"+session.getAttribute("login")+"';"
                                                    ;
                                    java.sql.ResultSet postAuthor = DBConnection.ExecQuery(q);
                                    
                                    if(circleOwner.next() || postAuthor.next())
                                    {
                                %>
                                <input type="HIDDEN" name="deletePost">
                                <input TYPE="BUTTON" class="btn btn-default" value="Delete this Post" ONCLICK="deletePostClicked()">
                                <a class="btn btn-default" href="ModifyPost.jsp">Modify this Post</a>
                                <%
                                    }
                                %>
                                <input type="HIDDEN" name="likePost">
                                <input type="HIDDEN" name="unLikePost">
                                <%
                                    // if the user currently likes the page then display an unlike
                                    // button otherwise display a like button
                                    Query = "select * "
                                        + " from PostLikes"
                                        + " where CustomerID ='"+session.getAttribute("login")+"'"
                                        + " AND PostID = '"+session.getAttribute("whichPost")+"';"
                                        ;
                                    java.sql.ResultSet userLikesThis =DBConnection.ExecQuery(Query);
                                    if (userLikesThis.isBeforeFirst())
                                    {
                                %>
                                    <input TYPE="BUTTON" class="btn btn-default" value="Unlike" ONCLICK="unLikePostClicked()">
                                    <%
                                    }
                                    else
                                    {
                                    %>
                                    <input TYPE="BUTTON" class="btn btn-default" value="Like" ONCLICK="likePostClicked()">
                            <% 
                                    }
                                }
                            %>
                                <a class="btn btn-default" href="ViewPostList.jsp">Back</a>
                            <%
                                    // display the number of likes on this page if there are any
                                    Query = "select count(*) from postlikes"
                                            + " where PostID ='"+session.getAttribute("whichPost")+"';"
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
                                                out.print("1 user likes this post");
                                            else
                                                out.print(numLikes+" users like this post");
                                        %>
                                        </font>
                                    <%
                                    }
                            %>
                            </form>
                        </div>
                    </div>
                </div>

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
