
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
        if(request.getParameter("addCustomer") != null) {
            
            int CustomerID = 0; // generated
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
            int Rating = 0; // initially 0
            
            // generate a new ID using a query to the database
            String Query = "select max(customerID) from customer;"
            ;
            java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
            if(rs.next())
                CustomerID = rs.getInt(1) + 1;
            else
                CustomerID = 1;

            // create our new customer
            Query = 
                "INSERT INTO Customer(CustomerID, Password, FirstName, LastName, Sex,"
                    + " EmailAddress, DateOfBirth, Address, City, State, ZipCode, Telephone, Rating)"+
                " VALUES ('"+CustomerID+"', '"+Password+"', '"+FirstName+"', '"+LastName+"', '"+Sex+"', '"+EmailAddress+"', '"
                    +DateOfBirth+"', '"+Address+"', '"+City+"', '"+State+"', '"+ZipCode+"', '"+Telephone+"', '"+Rating+"');"
            ;
            int success = DBConnection.ExecUpdateQuery(Query);
            
            // now redirect to the customers page
            response.sendRedirect("RepCustomerList.jsp");
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function button1()
        {
            // validate input
            Password = document.getElementById("cpassword").value;
            FirstName = document.getElementById("cfname").value;
            LastName = document.getElementById("clname").value;
            Sex = document.getElementById("csex").value;
            EmailAddress = document.getElementById("ceaddress").value;
            DateOfBirth = document.getElementById("cdob").value;
            Address = document.getElementById("caddress").value;
            City = document.getElementById("ccity").value;
            State = document.getElementById("cstate").value; 
            ZipCode = document.getElementById("czip").value;
            Telephone = document.getElementById("cphone").value;
            
            if (Password ==="" ||
            FirstName ==="" ||
            LastName ==="" ||
            Sex ==="" ||
            DateOfBirth  ==="")
            {
                text = "The following fields are required fields: "
                        + "Password, First Name, Last Name, Sex, Date of Birth.";
                document.getElementById("invalidInput").innerHTML = text;
            } 
            else
            {
                document.form1.addCustomer.value = "yes";
                form1.submit();
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
                            Add a New Customer
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
                
                <form name="form1" method="POST">                    
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cpassword">Password:</label>
                            <input name="customerPassword" type="password" class="form-control" id="cpassword">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cfname">First Name:</label>
                            <input name="customerFirstName" type="text" class="form-control" id="cfname">
                        </div>
                    </div>
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="clname">Last Name:</label>
                            <input name="customerLastName" type="text" class="form-control" id="clname">
                        </div>
                    </div>
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="csex">Sex: </label>
                            <select id="csex" name="customerSex">
                                <option value="M">M</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                    </div>
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="ceaddress">Email Address: </label>
                            <input name="customerEmailAddress" type="text" class="form-control" id="ceaddress">
                        </div>
                    </div>
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cdob">Date of Birth: </label>
                            <input name="customerDateOfBirth" type="date" class="form-control" id="cdob">
                        </div>
                    </div>
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="caddress">Address: </label>
                            <input name="customerAddress" type="text" class="form-control" id="caddress">
                        </div>
                    </div>
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="ccity">City: </label>
                            <input name="customerCity" type="text" class="form-control" id="ccity">
                        </div>
                    </div>                    
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cstate">State: </label>
                            <input name="customerState" type="text" class="form-control" id="cstate">
                        </div>
                    </div>                 
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="czip">ZipCode: </label>
                            <input name="customerZipCode" type="number" min="0" class="form-control" id="czip">
                        </div>
                    </div>         
 
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="cphone">Telephone: </label>
                            <input name="customerPhone" type="text" class="form-control" id="cphone">
                        </div>
                    </div>
 
                    <div>
                        <p id="invalidInput"></p>

                        <input type="HIDDEN" name="addCustomer">
                        <input TYPE="BUTTON" class="btn btn-default" value="Submit" ONCLICK="button1()">
                        <a class="btn btn-default" href="RepCustomerList.jsp">Back</a>
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
