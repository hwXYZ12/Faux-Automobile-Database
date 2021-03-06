
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

    <title>Console Cowboys in CyberSpace Manager</title>

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
        if( request.getParameter("SubmitButton") != null)
        {
            if  (request.getParameter("EmployeeID") != null )
            {
                String employeeID = request.getParameter("EmployeeID");
                String Query;
                int success;
                
                Query = 
                    "DELETE FROM sale WHERE advertisementid IN "
                        + "(select advertisementid from advertisement where EmployeeID = " + employeeID + ");";
                
                success = DBConnection.ExecUpdateQuery(Query);
                
                // delete ads
                Query = 
                    "DELETE FROM advertisement WHERE EmployeeID = " + employeeID + ";";
                
                success = DBConnection.ExecUpdateQuery(Query);
                
                Query = 
                    "DELETE FROM Employee WHERE EmployeeID = " + employeeID + ";";
                
                // create the message and add it to the database
                
                success = DBConnection.ExecUpdateQuery(Query);
                
                // let the user know that the message was sent successfully
                if(success > 0)
                {
                    %>
                    <SCRIPT LANGUAGE="JavaScript">
                            alert("Employee removed");
                    </SCRIPT>
                    <%
                } else {
                    %>
                    <SCRIPT LANGUAGE="JavaScript">
                            alert("Input could not be processed.");
                    </SCRIPT>
                    <%
                }
            } else {
                %>
                <SCRIPT LANGUAGE="JavaScript">
                        alert("Employee couldn't be removed!");
                </SCRIPT>
                <%
            }
        }
    %>
    
    <SCRIPT LANGUAGE="JavaScript">
        function sendMessageClicked()
        {
            document.formUnique.SubmitButton.value = "yes";
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
                <a class="navbar-brand" href="">Console Cowboys In CyberSpace Manager</a>
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

            

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Remove An Employee
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <a href="AddEmployee.jsp"><i class="fa fa-fw fa-user-plus"></i> Add Employee</a>
                            </li>
                            <li>
                                <a href="EditEmployee.jsp"><i class="fa fa-fw fa-wrench"></i> Edit Employee</a>
                            </li>
                            <li>
                                <a href="RemoveEmployee.jsp"><i class="fa fa-fw fa-ban"></i> Remove Employee</a>
                            </li>
                            <li>
                                <a href="TopSeller.jsp"><i class="fa fa-fw fa-fighter-jet"></i> Top Seller</a>
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                
                <form name="formUnique" method="POST">
                    
                    <div class="row">
                        <div class="form-group col-xs-5 col-lg-5">
                            <label for="EmployeeID">Employee ID: </label>
                            <input name="EmployeeID" type="text" class="form-control" id="EmployeeID">
                        </div>
                    </div>
                    
                    
                    <div>
                        <p id="invalidInput"></p>

                        <input type="HIDDEN" name="SubmitButton">
                        <input TYPE="BUTTON" class="btn btn-default" value="Submit" ONCLICK="sendMessageClicked()">
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
