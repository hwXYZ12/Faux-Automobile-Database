<%-- 
    Document   : logout
    Created on : Oct 23, 2014, 9:34:24 PM
    Author     : Ahmad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.setAttribute("login", "");
    response.sendRedirect("index.htm");
%>