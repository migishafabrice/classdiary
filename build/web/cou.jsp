<%
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
    %>
<%-- 
    Document   : vlogin
    Created on : Mar 6, 2022, 11:40:45 AM
    Author     : User
--%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%   
    Properties properties = new Properties();
    String msg;
    try
       {
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
Statement st=con.createStatement();
ResultSet rs;
String code="";
 SimpleDateFormat dte;

                dte=new SimpleDateFormat("dd");
                Date dt=new Date();
rs=st.executeQuery("select * from coursestb order by id desc limit 1");
    if(rs.first())
    {
code=(Integer.valueOf(rs.getString("id"))+1)+"-CRS-"+dte.format(dt);
         dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);
    }
    else
    {
code="1-CRS-"+dte.format(dt);
dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);  
    } 
PreparedStatement pt=con.prepareStatement("INSERT INTO `coursestb`(`id`,`coursecode`, `courseid`, `coursename`, `coursetopic`,`optionid`,`classid`, `active`, `registrar`, `regdate`) VALUES "
        + "(?,?,?,?,?,?,?,?,?,?)");
pt.setString(1,null);
pt.setString(2, code);
pt.setString(3, request.getParameter("coursecode"));
pt.setString(4, request.getParameter("coursename"));
pt.setString(5, request.getParameter("coursetopic"));
pt.setString(6,request.getParameter("courseopt") );
pt.setString(7,request.getParameter("courseclass"));
pt.setString(8, "YES");
pt.setString(9, String.valueOf(session.getAttribute("userCode")));
dte=new SimpleDateFormat("dd-MM-yyyy");
pt.setString(10, dte.format(dt));   
pt.execute();
msg="<font color='blue'>New course registered successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editcourse.jsp");
}
catch(Exception e)
       {
session.setAttribute("info","Connection failed");
       }
%>
