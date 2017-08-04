
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
    
    <% 
        if(request.getParameter("addCustomer") != null && request.getParameter("addCustomer").equals("yes")) {
            
            String CustomerID = session.getAttribute("whichCustomer").toString();
            String Password = request.getParameter("customerPassword");
            String FirstName = request.getParameter("customerFirstName");
            String LastName = request.getParameter("customerLastName");
            String Sex = request.getParameter("customerSex");
            String EmailAddress = request.getParameter("customerEmailAddress");
            String DateOfBirth = request.getParameter("customerDateOfBirth");
            String Address = request.getParameter("customerAddress");
            String City = request.getParameter("customerCity");
            String State = request.getParameter("customerState");
            int ZipCode=0;
            if (!request.getParameter("customerZipCode").equals(""))
                ZipCode = Integer.parseInt(request.getParameter("customerZipCode"));
            String Telephone = request.getParameter("customerPhone");
            int Rating=0;
            if (!request.getParameter("customerRating").equals(""))
                Rating = Integer.parseInt(request.getParameter("customerRating"));

            // update our customers info
            String Query = 
                "Update Customer"
                    + " set Password='"+Password+"',"
                    + "FirstName='"+FirstName+"',"
                    + "LastName='"+LastName+"',"
                    + "Sex='"+Sex+"',"
                    + "EmailAddress='"+EmailAddress+"',"
                    + "DateOfBirth ='"+DateOfBirth+"',"
                    + "Address ='"+Address+"',"
                    + "City ='"+City+"',"
                    + "State ='"+State+"',"
                    + "ZipCode ='"+ZipCode+"',"
                    + "Telephone ='"+Telephone+"',"
                    + "Rating ='"+Rating+"'"
                    + " where customerid='"+CustomerID+"';"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now redirect to the customers page
            response.sendRedirect("RepCustomerList.jsp");
            return;
        }
        
        if(request.getParameter("deleteCustomer") != null && request.getParameter("deleteCustomer").equals("yes")) {
            
            String Query;
            int success;
            
            Query = "delete from commentlikes where customerid='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from postlikes where customerid='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from circleinvite where customerid='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from circlerequest where customerid='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);        
            
            Query = "delete from circlemembership where customerid='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from commentlikes where commentid IN"
                    + " (select commentid from comment where author='"+session.getAttribute("whichCustomer")+"');"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // delete associated comment likes
            Query = "delete from comment where author='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from customerpreferences where customerid='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from sale where accountnumber IN "
                    + "(select accountnumber from account where customerid='"+session.getAttribute("whichCustomer")+"');"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // we must now delete all accounts that reference the customer and all sales that reference
            // those accounts
            Query = "delete from account where customerid='"+session.getAttribute("whichCustomer")+"';"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from commentlikes where commentid IN "
                    + "(select commentid from comment where postid IN "
                    + "(select postid from post where PostAuthor='"+session.getAttribute("whichCustomer")+"'));"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from postlikes where postid IN "
                    + "(select postid from post where PostAuthor='"+session.getAttribute("whichCustomer")+"');"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from comment where postid IN "
                    + "(select postid from post where PostAuthor='"+session.getAttribute("whichCustomer")+"');"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // delete all the posts that this user has authored and respectively
            // all of the comments on those posts, the likes on those comments,
            // and the likes on those posts
            Query = "delete from post where PostAuthor='"+session.getAttribute("whichCustomer")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // having nothing to do with circles, we also need to delete any
            // messages that reference the customer
            Query = "delete from message where Sender='"+session.getAttribute("whichCustomer")+"'"
                    + " OR Receiver='"+session.getAttribute("whichCustomer")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // delete all the items that refer to the circles that the user owns
            // delete all likes that reference any comments that reference the posts
            Query =  "delete from commentlikes"+
                            " where commentID IN "
                    + "(select commentID from comment"+
                            " where postID IN"
                    + "(select postID from post"+
                            " where pageID IN "
                    + "(select pageID from page"
                    + " where AssociatedCircle IN "
                    + "(select circleid from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"'))));"
            ;
            success = DBConnection.ExecUpdateQuery(Query);

            // delete all likes that reference the posts
            Query = "delete from postlikes"+
                            " where postID IN"
                    + "(select postID from post"+
                            " where pageID IN "
                    + "(select pageID from page"
                    + " where AssociatedCircle IN "
                    + "(select circleid from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"')));"
            ;
            success = DBConnection.ExecUpdateQuery(Query);

            // delete all comments that reference the posts
            Query =  "delete from comment"+
                            " where postID IN"
                    + "(select postID from post"+
                            " where pageID IN "
                    + "(select pageID from page"
                    + " where AssociatedCircle IN "
                    + "(select circleid from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"')));"
            ;
            success = DBConnection.ExecUpdateQuery(Query);

            // remove every post that references the removed page
             Query =  "delete from post"+
                            " where pageID IN "
                    + "(select pageID from page"
                    + " where AssociatedCircle IN "
                    + "(select circleid from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"'));"
            ;
            success = DBConnection.ExecUpdateQuery(Query);

            // delete the page(s) associated with the circles owned by the user and
            // therefore all the posts, comments, likes, etc.
            // associated with the page(s)
            Query = "delete from page"
                    + " where AssociatedCircle IN "
                    + "(select circleid from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"');"
                    ;
            success = DBConnection.ExecUpdateQuery(Query);

            // delete all circlerequests that reference the user
            Query =  "delete from circlerequest"+
                            " where "
                    + " customerID='"+session.getAttribute("whichCustomer")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
                         
            // delete all circleinvites that reference the user
            Query =  "delete from circleinvite"+
                            " where "
                    + " customerID='"+session.getAttribute("whichCustomer")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // delete all circlememberships that reference the user
            Query =  "delete from circlemembership"+
                            " where "
                    + " customerID='"+session.getAttribute("whichCustomer")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // delete all circlerequests that reference the circle(s)
            // that the user owns
            Query =  "delete from circlerequest"+
                            " where circleID IN "
                    + "(select circleID from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"');"
            ;
            success = DBConnection.ExecUpdateQuery(Query);

            // delete all circleinvites that reference the circle(s)
            // that the user owns
            Query =  "delete from circleinvite"+
                            " where circleID IN "
                    + "(select circleID from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"');"
            ;
            success = DBConnection.ExecUpdateQuery(Query);

            // delete all circlememberships that reference the circle(s)
            // that the user owns
            Query =  "delete from circlemembership"+
                            " where circleID IN "
                    + "(select circleID from circle where"
                    + " owner='"+session.getAttribute("whichCustomer")+"');"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            // delete all the circles that this user owns
            Query =  "delete from circle"+
                            " where owner ='"
                            + session.getAttribute("whichCustomer")+"';"
            ;
            success = DBConnection.ExecUpdateQuery(Query);
            
            Query = "delete from customer where customerid='"+session.getAttribute("whichCustomer")+"';";
            success = DBConnection.ExecUpdateQuery(Query);
            response.sendRedirect("RepCustomerList.jsp");
            return;
        }
        
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        
        function editCustomerClicked()
        {
            document.formEdit.editCustomer.value = "yes";
            formEdit.submit();
        }
        
        function deleteCustomerClicked()
        {
            if(confirm("Are you sure you want to delete this customer?"))
            {
                document.formEdit.deleteCustomer.value = "yes";
                formEdit.submit();
            }
        }
        
        function addCustomerClicked()
        {
            document.formUnique.addCustomer.value = "yes";
            formUnique.submit();
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
                            <big>
                            <%  String Query = "select *"
                                                + " from customer    "
                                                + " where customerID = " +session.getAttribute("whichCustomer")+";"
                                ;
                                java.sql.ResultSet theCustomer =DBConnection.ExecQuery(Query);
                                
                                String name="";
                                if(theCustomer.next())
                                {
                                    name = theCustomer.getString(3)+", "+theCustomer.getString(4);
                                    out.print(name);
                                }
                            %>
                            </big>
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
                    </div>
                </div>
                <!-- /.row -->
                
                <div class="row">
                    <div class="col-lg-6">
                        <%
                            if(!(request.getParameter("editCustomer")!=null
                                    && request.getParameter("editCustomer").equals("yes")
                                    && !request.getParameter("editCustomer").equals("no"))){
                        %>
                        <form name="formEdit" method="POST">
                            <div>
                                <input type="HIDDEN" name="editCustomer">
                                <input TYPE="BUTTON" class="btn btn-default" value="Edit" ONCLICK="editCustomerClicked()">
                                <input type="HIDDEN" name="deleteCustomer">
                                <input TYPE="BUTTON" class="btn btn-default" value="Delete this Customer" ONCLICK="deleteCustomerClicked()">                                
                                <a class="btn btn-default" href="RepSuggestedItems.jsp">Suggested Items</a>
                                <a class="btn btn-default" href="RepCustomerList.jsp">Back</a>
                            </div>
                        </form>
                        <%
                            } else {  
                        %>   
                        <form name="formUnique" method="POST">
                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="cpassword">Password:</label>
                                    <input name="customerPassword" type="password" 
                                           class="form-control" id="cpassword"
                                           value="<% out.print(theCustomer.getString(2)); %>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="cfname">First Name:</label>
                                    <input name="customerFirstName" type="text" class="form-control" id="cfname"
                                           value="<% out.print(theCustomer.getString(3)); %>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="clname">Last Name:</label>
                                    <input name="customerLastName" type="text" class="form-control" id="clname"
                                           value="<% out.print(theCustomer.getString(4)); %>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="csex">Sex: </label>
                                    <select id="csex" name="customerSex">
                                        <option value="M"
                                                <% if(theCustomer.getString(5).equals("M"))
                                                {
                                                    out.print("selected=\"selected\"");
                                                }
                                                %>>M</option>
                                        <option value="F"
                                                <% if(theCustomer.getString(5).equals("F"))
                                                {
                                                    out.print("selected=\"selected\"");
                                                }
                                                %>>F</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="ceaddress">Email Address: </label>
                                    <input name="customerEmailAddress" type="text" class="form-control" id="ceaddress"
                                           value="<% out.print(theCustomer.getString(6)); %>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="cdob">Date of Birth: </label>
                                    <input name="customerDateOfBirth" type="date" class="form-control" id="cdob"
                                           value="<% out.print(theCustomer.getString(7)); %>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="caddress">Address: </label>
                                    <input name="customerAddress" type="text" class="form-control" id="caddress"
                                           value="<% out.print(theCustomer.getString(8)); %>">
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="ccity">City: </label>
                                    <input name="customerCity" type="text" class="form-control" id="ccity"
                                           value="<% out.print(theCustomer.getString(9)); %>">
                                </div>
                            </div>                    

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="cstate">State: </label>
                                    <input name="customerState" type="text" class="form-control" id="cstate"
                                           value="<% out.print(theCustomer.getString(10)); %>">
                                </div>
                            </div>                 

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="czip">ZipCode: </label>
                                    <input name="customerZipCode" type="number" min="0" class="form-control" id="czip"
                                           value="<% out.print(theCustomer.getString(11)); %>">
                                </div>
                            </div>         

                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="cphone">Telephone: </label>
                                    <input name="customerPhone" type="text" class="form-control" id="cphone"
                                           value="<% out.print(theCustomer.getString(12)); %>">
                                </div>
                            </div>
                                
                            <div class="row">
                                <div class="form-group col-xs-5 col-lg-5">
                                    <label for="crating">Rating: </label>
                                    <input name="customerRating" type="number" min="0" class="form-control" id="crating"
                                           value="<% out.print(theCustomer.getString(13)); %>">
                                </div>
                            </div>  

                            <div>
                                <p id="invalidInput"></p>

                                <input type="HIDDEN" name="addCustomer">
                                <input TYPE="BUTTON" class="btn btn-default" value="Submit" ONCLICK="addCustomerClicked()">
                                <a class="btn btn-default" href="RepCustomerList.jsp">Back</a>
                            </div>
                        </form>
                        <%
                                }
                        %>
                            
                        
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
