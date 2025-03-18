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
int n;
Statement st=con.createStatement();
ResultSet rs;
String code="";
 SimpleDateFormat dte;

                dte=new SimpleDateFormat("dd");
                Date dt=new Date();
if(request.getParameter("nvpassword").toString().equals(request.getParameter("rvpassword").toString()))
{
 
rs=st.executeQuery("select * from userstb where (username='"+request.getParameter("vusername").toString()+"' or email='"+request.getParameter("vusername").toString()+"'"
        + "or telephone='"+request.getParameter("vusername").toString()+"') and password='"+request.getParameter("vpassword").toString()+"'");
    if(rs.first())
    {
PreparedStatement pt=con.prepareStatement("UPDATE `userstb` SET  password=?,reset=? where (username=? or email=? or telephone=?) and password=?");
pt.setString(1,request.getParameter("nvpassword").toString());
pt.setString(2,"YES");
pt.setString(3,request.getParameter("vusername").toString());
pt.setString(4, request.getParameter("vusername").toString());
pt.setString(5, request.getParameter("vusername").toString());  
pt.setString(6,request.getParameter("vpassword").toString());
pt.execute();
msg="<font color='blue'>Password changed successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("index.jsp");
    }
    else
    {
msg="<font color='red'>Username or password not registered</font>";
session.setAttribute("info", msg);
response.sendRedirect("login.jsp");
    } 
}
else
{
msg="<font color='red'>New password not matching,try again</font>";
session.setAttribute("info", msg);
response.sendRedirect("changepassword.jsp");  
}
}
catch(Exception e)
       {
session.setAttribute("info","Connection failed");
       }
%>
