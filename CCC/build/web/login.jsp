
<%@page import="javax.swing.JOptionPane"%>
<%@page import="DBWorks.DBConnection"%>
<%
	if ((request.getParameter("action") != null) && (request.getParameter("action").trim().equals("logout"))) {
		//session.putValue("login", "");
                session.setAttribute("login", "");
		response.sendRedirect("/");
		return;
	}

	String username = request.getParameter("username");
	String userpasswd = request.getParameter("userpasswd");
        String query=null;
	session.setAttribute("login", "");
	if ((username != null) && (userpasswd != null))
        {
            if (username.trim().equals("") || userpasswd.trim().equals("")) {
		response.sendRedirect("index.htm");
            } 
            else {
                
                query = "SELECT * FROM customer WHERE CustomerId = '" +
                            username + "' AND Password = '" + userpasswd  + "';";
               	java.sql.ResultSet rs = DBConnection.ExecQuery(query);
		if (rs.next()) {
                    // login success
                    // refesh session variables
                    session.setAttribute("login", username);
                    session.setAttribute("whichCircle", null);
                    session.setAttribute("whichPost", null);
                    session.setAttribute("whichAd", null);
                    session.setAttribute("whichCustomer", null);
                    session.setAttribute("inPattern", null);
                    response.sendRedirect("CustomerCircles.jsp");
		} 
                
                else{
                        query = "SELECT * FROM employee WHERE EmployeeID = '" +
                            username + "' AND Password = '" + userpasswd  + "'";
                        rs = DBConnection.ExecQuery(query);
                        if (rs.next()) {
                            // login success
                            // refesh session variables
                            session.setAttribute("login", username);
                            session.setAttribute("whichCircle", null);
                            session.setAttribute("whichPost", null);
                            session.setAttribute("whichAd", null);
                            session.setAttribute("whichCustomer", null);
                            session.setAttribute("inPattern", null);
                            if (rs.getString(13).equals("Manager"))
                                response.sendRedirect("AllAds.jsp");
                            if (rs.getString(13).equals("Customer Representative"))
                                response.sendRedirect("CustomerRepAds.jsp");
                        }
                        else {
				// username or password mistake
                            
                            out.print("Username or Password is not Correct!!!");
                            %>
                            <br/>
                            <a href="index.htm"> Back to login page </a>
                            <%
                        }
                    }
			
            }
	}
    
%>