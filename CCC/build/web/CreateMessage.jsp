
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
        if( request.getParameter("createAMessage") != null)
        {
            if  (request.getParameter("messageReceiver") != null
                 && request.getParameter("messageContent") !=null)
            {
                int messageID = 0;
                // generate a new ID using a query to the database
                String Query = "select max(messageID) from message;"
                ;
                java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                if(rs.next())
                    messageID = rs.getInt(1) + 1;
                else
                    messageID = 1;
                
                String sender=session.getAttribute("login").toString();
                String content = request.getParameter("messageContent");
                String subject = request.getParameter("messageSubject");
                if (subject==null)
                    subject="";
                String receiver = request.getParameter("messageReceiver");

                // create the message and add it to the database
                Query = 
                    "INSERT INTO Message(MessageID, Date, Subject, Content, Sender, Receiver)"+
                    " VALUES ('"+messageID+"', CURDATE(), '"+subject+"','"+content+"', '"+sender+"', '"+receiver+"');"
                ;
                int success = DBConnection.ExecUpdateQuery(Query);
                
                // let the user know that the message was sent successfully
                if(success > 0)
                {
                    %>
                    <SCRIPT LANGUAGE="JavaScript">
                            alert("Message sent!");
                    </SCRIPT>
                    <%
                } else {
                    %>
                    <SCRIPT LANGUAGE="JavaScript">
                            alert("Your message couldn't be sent!"+
                                    " The desired recipient of the message doesn't exist.");
                    </SCRIPT>
                    <%
                }
            } else {
                %>
                <SCRIPT LANGUAGE="JavaScript">
                        alert("Your message couldn't be sent! This may be because you"
                                +" didn't fill the content or receiver fields.");
                </SCRIPT>
                <%
            }
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function sendMessageClicked()
        {
            document.formUnique.createAMessage.value = "yes";
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
                            Create a New Message
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
                
                <form name="formUnique" method="POST">
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="mreceiver">Receiver: </label>
                            <input name="messageReceiver" type="text" class="form-control" id="mreceiver">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="msubject">Subject: </label>
                            <input name="messageSubject" type="text" class="form-control" id="msubject">
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="mContent">Content: </label>
                            <textarea class="form-control" rows="5" id="mcontent" name="messageContent"></textarea>
                        </div>
                    </div>
                    
                    
                    <div>
                        <p id="invalidInput"></p>

                        <input type="HIDDEN" name="createAMessage">
                        <input TYPE="BUTTON" class="btn btn-default" value="Send Message" ONCLICK="sendMessageClicked()">
                        <a class="btn btn-default" href="ReceivedMessages.jsp">Back to Inbox</a>
                    </div>
                    
                </form>
                
                
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
