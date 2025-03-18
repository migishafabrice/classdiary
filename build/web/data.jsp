<%
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
    %>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>    
<% 
    if(!StringUtils.isNullOrEmpty(request.getParameter("q")))
    {
       String name = ""; 
       String q = request.getParameter("q"); 
       Properties properties = new Properties();
       try { 
            properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
            Statement smt = con.createStatement(); //Create Statement to interact 
            ResultSet r = smt.executeQuery("select * from classestb where(optionid like'%" + q + "%');"); 
            if(r.first())
            {
                r.beforeFirst();
                name="<option>Choose class</option>";
            while (r.next()) { 
              name +="<option value='"+r.getString("classid") +"'>"+r.getString("classname")+"</option>";
            }
            }
            
       } catch (Exception e) { 
            e.printStackTrace(); 
       } %>
       <%out.print(name);%> 
   <%  }
if(!StringUtils.isNullOrEmpty(request.getParameter("o")) && !StringUtils.isNullOrEmpty(request.getParameter("c")))
{
String name = ""; 
       String o = request.getParameter("o"); 
String c = request.getParameter("c"); 
       Properties properties = new Properties();
       try { 
            properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
            Statement smt = con.createStatement(); //Create Statement to interact 
            ResultSet r = smt.executeQuery("select * from coursestb where optionid='" + o + "' and classid='"+c+"';"); 
            if(r.first())
            {
                r.beforeFirst();
                name="<option>Choose course</option>";
            while (r.next()) { 
              name +="<option value='"+r.getString("coursecode") +"'>"+r.getString("coursename")+"</option>";
            } }
            
       } catch (Exception e) { 
            e.printStackTrace(); 
       } %>
      <%out.print(name);%> 
<% 
}
    %> 
    <%
        if(!StringUtils.isNullOrEmpty(request.getParameter("m")))
{
String name = ""; 
       String o = request.getParameter("m"); 
//String c = request.getParameter("c"); 
       Properties properties = new Properties();
       try { 
            properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
            Statement smt = con.createStatement(); //Create Statement to interact 
            ResultSet r = smt.executeQuery("select * from coursestb where coursecode='" +o+ "'"); 
            if(r.first())
            {
                name="<option>Choose topic</option>";
                 String topic="";
                                  
                                  if(r.getString("coursetopic").contains(";"))
                                  {
                                    String [] topics=r.getString("coursetopic").split(";");
                                    for(int i=0;i<topics.length;i++)
                                    {
                                        topic+="<option value='"+topics[i]+"'>"+topics[i]+"</option>";
                                        
                                    }
                                  }
                                  else
                                  {
                                     topic+="<option value='"+r.getString("coursetopic")+"'>"+r.getString("coursetopic")+"</option>";
                                  }
                name+=topic;
             }
            
       } catch (Exception e) { 
            e.printStackTrace(); 
       } %>
      <%out.print(name);%> 
<% 
}
    %> 
      