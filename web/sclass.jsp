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
rs=st.executeQuery("select * from diariestb order by id desc limit 1");
    if(rs.first())
    {
code=(Integer.valueOf(rs.getString("id"))+1)+"-ECD-"+dte.format(dt);
         dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);
    }
    else
    {
code="1-ECD-"+dte.format(dt);
dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);  
    } 
PreparedStatement pt=con.prepareStatement("INSERT INTO `diariestb`(`id`, `diaryid`, `diarydate`, `period`, `optionid`, `classid`, `courseid`, `matter`, "
        + "`topic`, `application`, `homework`,`observation`, `registrar`, `regdate`, `status`, `comment`,`score`, `approvedby`, `decisiondate`) VALUES "
        + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
String [] periods=request.getParameterValues("eperiod");
String [] options=request.getParameterValues("eoption");
String [] classes=request.getParameterValues("eclass");
String [] courses=request.getParameterValues("ecourse");
String [] matters=request.getParameterValues("ematter");
String [] topic=request.getParameterValues("etopic");
String [] apps=request.getParameterValues("eapp");
String [] obs=request.getParameterValues("eobs");

if(periods.length>1)
{
for(int a=0;a<periods.length;a++)
{
pt.setString(1,null);
pt.setString(2, code);
pt.setString(3, request.getParameter("edate").toString());
pt.setString(4,periods[a]);
pt.setString(5,options[a]);
pt.setString(6, classes[a]);
pt.setString(7, courses[a]);
pt.setString(8, matters[a]);
pt.setString(9, topic[a]);
pt.setString(10,apps[a]);
pt.setString(11,request.getParameter("ehome").toString());
pt.setString(12, obs[a]);
pt.setString(13, String.valueOf(session.getAttribute("userCode")));
dte=new SimpleDateFormat("dd-MM-yyyy");
pt.setString(14, dte.format(dt));  
pt.setString(15,"Pending");
pt.setString(16,"");
pt.setString(17,"");
pt.setString(18,"");
pt.setString(19,"");
pt.execute();
}
}
else
{
pt.setString(1,null);
pt.setString(2, code);
pt.setString(3, request.getParameter("edate").toString());
pt.setString(4,request.getParameter("eperiod").toString());
pt.setString(5,request.getParameter("eoption").toString());
pt.setString(6, request.getParameter("eclass").toString());
pt.setString(7, request.getParameter("ecourse").toString());
pt.setString(8, request.getParameter("ematter").toString());
pt.setString(9, request.getParameter("etopic").toString());
pt.setString(10, request.getParameter("eapp").toString());
pt.setString(11,request.getParameter("ehome").toString());
pt.setString(12, request.getParameter("eobs").toString());
pt.setString(13, String.valueOf(session.getAttribute("userCode")));
dte=new SimpleDateFormat("dd-MM-yyyy");
pt.setString(14, dte.format(dt));  
pt.setString(15,"Pending");
pt.setString(16,"");
pt.setString(17,"");
pt.setString(18,"");
pt.setString(19,"");
pt.execute();   
}
msg="<font color='blue'>Class diary registered successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("classdiary.jsp");
return;
}
catch(Exception e)
       {
session.setAttribute("info","Connection failed");
response.sendRedirect("classdiary.jsp");
return;
       }
%>