<%-- 
    Document   : vlogin
    Created on : Mar 6, 2022, 11:40:45 AM
    Author     : User
--%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%    Properties properties = new Properties();
    String u=request.getParameter("vusername");
    String p=request.getParameter("vpassword");
    String msg;
    try
       {
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
int n;
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select * from userstb where (username='"+u+"' or email='"+u+"' or telephone='"+u+"') and password='"+p+"'");
    rs.last();
    n=rs.getRow();
    if(n==1)
    {
        if(rs.getString("reset").equals("YES"))
        {
        session.setAttribute("userCode", rs.getString("userid"));
        session.setAttribute("userFunction", rs.getString("function"));
        response.sendRedirect("dashboard.jsp"); 
        }
        else
        {
        msg="<font color='red'>Change your default password and login</font>";
        session.setAttribute("info",msg);
        response.sendRedirect("changepassword.jsp");  
        }
    }
    else
    {
        msg="<font color='red'>Username or password invalid</font>";
        session.setAttribute("info",msg);
        response.sendRedirect("index.jsp");
    } 
       }
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("index.jsp");
       }
%>
