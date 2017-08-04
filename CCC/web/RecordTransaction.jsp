
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
        if( request.getParameter("makeSale") != null)
        {
            if  (request.getParameter("saleAccount") != null
                 && request.getParameter("saleUnits") !=null
                 && request.getParameter("saleAdID") !=null)
                {
                    int saleID = 0;
                    // generate a new ID using a query to the database
                    String Query = "select max(transactionID) from sale;"
                    ;
                    java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                    if(rs.next())
                        saleID = rs.getInt(1) + 1;
                    else
                        saleID = 1;

                    // get the ad of interest
                    Query = "select * from advertisement where"
                            + " advertisementid = '"+request.getParameter("saleAdID")+"';"
                    ;
                    java.sql.ResultSet theAd =DBConnection.ExecQuery(Query);
                    if(theAd.next())
                    {

                        String adID=theAd.getString(1);
                        int units = Integer.parseInt(request.getParameter("saleUnits"));
                        String account = request.getParameter("saleAccount");
                        if(units < 0)
                        {
                            %>
                            <SCRIPT LANGUAGE="JavaScript">
                                    alert("You cannot purchase a negative number of items!");
                            </SCRIPT>
                            <%
                        } else if (units > Integer.parseInt(theAd.getString(9)))
                        {
                            %>
                            <SCRIPT LANGUAGE="JavaScript">
                                    alert("You cannot purchase more than the number of items available!");
                            </SCRIPT>
                            <%
                        }
                        else
                        {
                            // create the sale and record it in the database
                            Query = 
                                "INSERT INTO Sale(TransactionID, DateOfSale, AdvertisementID, NumUnits, AccountNumber)"+
                                " VALUES ('"+saleID+"', CURDATE(), '"+adID+"','"+units+"', '"+account+"');"
                            ;
                            int success = DBConnection.ExecUpdateQuery(Query);

                            // let the user know that the sale was recorded successfully
                            if(success > 0)
                            {
                                %>
                                <SCRIPT LANGUAGE="JavaScript">
                                        alert("Purchase recorded!");
                                </SCRIPT>
                                <%

                                // we also need to decrement the number of available units in the ad
                                Query = 
                                        "Update advertisement "
                                        +"set availableunits=(availableunits - "+units+")"
                                        +" where advertisementid='"+adID+"';"
                                        ;
                                success = DBConnection.ExecUpdateQuery(Query);

                                // and update our ad variable to reflect the change
                                Query = "select * from advertisement"
                                        + " where advertisementid='"+session.getAttribute("whichAd")+"';"
                                        ;
                                theAd = DBConnection.ExecQuery(Query);
                                theAd.next();

                            } else {
                                %>
                                <SCRIPT LANGUAGE="JavaScript">
                                        alert("Your purchase couldn't be completed!"+
                                                " The account number provided is invalid.");
                                </SCRIPT>
                                <%
                            }
                        }

                    } else {
                        %>
                        <SCRIPT LANGUAGE="JavaScript">
                                alert("Your sale couldn't be processed! The advertisement ID that you chose"
                                        + " doesn't exist.");
                        </SCRIPT>
                        <%
                    }
                } else {
                        %>
                        <SCRIPT LANGUAGE="JavaScript">
                                alert("Your purchase couldn't processed! This may be because you"
                                        +" didn't fill all of the fields.");
                        </SCRIPT>
                        <%
                
            }
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function makeSaleClicked()
        {
            document.formUnique.makeSale.value = "yes";
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
                        <a href="CustomerRepAds.jsp"><i class="fa fa-fw fa-newspaper-o"></i> Advertisements</a>
                    </li>
                    <li>
                        <a href="RepTransactions.jsp"><i class="fa fa-fw fa-usd"></i> Transactions</a>
                    </li>
                    <li>
                        <a href="RepCustomerList.jsp"><i class="fa fa-fw fa-smile-o"></i> Customers</a>
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
                    Record a Transaction
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

        <form name="formUnique" method="POST">

            <div class="row">
                <div class="form-group col-xs-5 col-lg-5">
                    <label for="sadID">Advertisement ID: </label>
                    <input name="saleAdID" type="text" class="form-control" id="sadID">
                </div>
            </div>
            
            <div class="row">
                <div class="form-group col-xs-5 col-lg-5">
                    <label for="saccount">Account Number: </label>
                    <input name="saleAccount" type="text" class="form-control" id="saccount">
                </div>
            </div>

            <div class="row">
                <div class="form-group col-xs-5 col-lg-5">
                    <label for="sunits">Amount Purchased: </label>
                    <input name="saleUnits" type="number" min="0" class="form-control" id="sunits">
                </div>
            </div>

            <div>
                <p id="invalidInput"></p>

                <input type="HIDDEN" name="makeSale">
                <input TYPE="BUTTON" class="btn btn-default" value="Submit" ONCLICK="makeSaleClicked()">
                <a class="btn btn-default" href="RepTransactions.jsp">Back to Transactions</a>
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
