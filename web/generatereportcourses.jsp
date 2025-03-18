<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Properties"%>
<%
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
    %> 
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<%
Properties properties = new Properties();
Statement st;
ResultSet rs;
String msg;
int n=0;
int teacher=0;
int dos=0;
int head=0;
int male=0;
int female=0;
int active=0;
int nonActive=0;
String answer="No results found.";
%>
<%
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
Statement rst=con.createStatement();
if(!request.getParameter("option").equals("Choose option") && request.getParameter("class").equals("Choose class") && request.getParameter("active").equals("Active"))
{
                        try
                        {
                            ResultSet rrs=rst.executeQuery("select * from optionstb where optionid='"+request.getParameter("option")+"'");
                             rrs.last();
                          if(rrs.getRow()==1)
                          {
                              rrs.first();
                               Statement stcourse=con.createStatement();
                               ResultSet rscourse=stcourse.executeQuery("select * from coursestb where optionid='"+rrs.getString("optionid")+"' order by coursename,classid asc");
                               if(rscourse.first())
                               {
                                   
                                   answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'><u> List of courses in '"+rrs.getString("optionname")+"'</u></h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Code</th><th scope='col'>Name</th>"+
              "<th scope='col'>Option</th><th scope='col'>Class</th></tr></thead><tbody>";
                                   rscourse.beforeFirst();
                                   while(rscourse.next())
                                   {
                                       n++;
                                   Statement stclass=con.createStatement();
                                   ResultSet rsclass=stclass.executeQuery("select * from classestb where optionid like '%"+rscourse.getString("optionid")+"%'");
                                   
                                   if(rsclass.first())
                                   {
                                                                   
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                    " <td>"+rscourse.getString("courseid")+"</td>"+
                   " <td>"+rscourse.getString("coursename")+"</td>"+
                    "<td>"+rrs.getString("optionname")+ "</td>"+
                    "<td>"+rsclass.getString("classname") +"</td>";
                       }
                                   }
answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                               }}
                              
                          }
                           catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
out.println(answer);
    return;
}
%>
<%
if(!request.getParameter("option").equals("Choose option") && !request.getParameter("class").equals("Choose class") && !request.getParameter("active").equals("Active"))
{
                        try
                        {
                            ResultSet rrs=rst.executeQuery("select * from optionstb where optionid='"+request.getParameter("option")+"'");
                             rrs.last();
                          if(rrs.getRow()==1)
                          {
                              rrs.first();
                               Statement stcourse=con.createStatement();
                               ResultSet rscourse=stcourse.executeQuery("select * from coursestb where optionid='"+rrs.getString("optionid")+"' and classid='"+request.getParameter("class")+"' and active='"+request.getParameter("active")+"'order by coursename,classid asc");
                               if(rscourse.first())
                               {
                                   
                                   
                                   rscourse.beforeFirst();
                                   while(rscourse.next())
                                   {
                                       n++;
                                   Statement stclass=con.createStatement();
                                   ResultSet rsclass=stclass.executeQuery("select * from classestb where optionid like '%"+rscourse.getString("optionid")+"%'");
                                  
                                   if(rsclass.first())
                                   {
                                     if(n==1)
                                  {
                                   answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'><u> List of courses<br/> Option:"+rrs.getString("optionname")+"<br/>Class:"+rsclass.getString("classname")+"<br/>"
                                           + "Active:"+request.getParameter("active")+"</u></h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Code</th><th scope='col'>Name</th>"+
              "<th scope='col'>Option</th><th scope='col'>Class</th></tr></thead><tbody>";
                                  }                              
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                    " <td>"+rscourse.getString("courseid")+"</td>"+
                   " <td>"+rscourse.getString("coursename")+"</td>"+
                    "<td>"+rrs.getString("optionname")+ "</td>"+
                    "<td>"+rsclass.getString("classname") +"</td>";
                       }
                                   }
answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                               }}
                              
                          }
                         catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
out.println(answer);
    return;
}
%>
<%
if(!request.getParameter("option").equals("Choose option") && !request.getParameter("class").equals("Choose class") && request.getParameter("active").equals("Active"))
{
                        try
                        {
                            ResultSet rrs=rst.executeQuery("select * from optionstb where optionid='"+request.getParameter("option")+"'");
                             rrs.last();
                          if(rrs.getRow()==1)
                          {
                              rrs.first();
                               Statement stcourse=con.createStatement();
                               ResultSet rscourse=stcourse.executeQuery("select * from coursestb where optionid='"+rrs.getString("optionid")+"' and classid='"+request.getParameter("class")+"' order by coursename,classid asc");
                               if(rscourse.first())
                               {
                                   
                                   
                                   rscourse.beforeFirst();
                                   while(rscourse.next())
                                   {
                                       n++;
                                   Statement stclass=con.createStatement();
                                   ResultSet rsclass=stclass.executeQuery("select * from classestb where optionid like '%"+rscourse.getString("optionid")+"%'");
                                  
                                   if(rsclass.first())
                                   {
                                     if(n==1)
                                  {
                                   answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'><u> List of courses<br/> Option:"+rrs.getString("optionname")+"<br/>Class:"+rsclass.getString("classname")+""
                                           + "</u></h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Code</th><th scope='col'>Name</th>"+
              "<th scope='col'>Option</th><th scope='col'>Class</th></tr></thead><tbody>";
                                  }                              
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                    " <td>"+rscourse.getString("courseid")+"</td>"+
                   " <td>"+rscourse.getString("coursename")+"</td>"+
                    "<td>"+rrs.getString("optionname")+ "</td>"+
                    "<td>"+rsclass.getString("classname") +"</td>";
                       }
                                   }
answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                               }}
                              
                          }
                         catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
out.println(answer);
    return;
}
%>
<%
if(!request.getParameter("option").equals("Choose option") && request.getParameter("class").equals("Choose class") && !request.getParameter("active").equals("Active"))
{
                        try
                        {
                            ResultSet rrs=rst.executeQuery("select * from optionstb where optionid='"+request.getParameter("option")+"'");
                             rrs.last();
                          if(rrs.getRow()==1)
                          {
                              rrs.first();
                               Statement stcourse=con.createStatement();
                               ResultSet rscourse=stcourse.executeQuery("select * from coursestb where optionid='"+rrs.getString("optionid")+"' and active='"+request.getParameter("active")+"'order by coursename,classid asc");
                               if(rscourse.first())
                               {
                                   
                                   
                                   rscourse.beforeFirst();
                                   while(rscourse.next())
                                   {
                                       n++;
                                   Statement stclass=con.createStatement();
                                   ResultSet rsclass=stclass.executeQuery("select * from classestb where optionid like '%"+rscourse.getString("optionid")+"%'");
                                  
                                   if(rsclass.first())
                                   {
                                     if(n==1)
                                  {
                                   answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'><u> List of courses<br/> Option:"+rrs.getString("optionname")+"<br/>"
                                           + "Active:"+request.getParameter("active")+"</u></h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Code</th><th scope='col'>Name</th>"+
              "<th scope='col'>Option</th><th scope='col'>Class</th></tr></thead><tbody>";
                                  }                              
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                    " <td>"+rscourse.getString("courseid")+"</td>"+
                   " <td>"+rscourse.getString("coursename")+"</td>"+
                    "<td>"+rrs.getString("optionname")+ "</td>"+
                    "<td>"+rsclass.getString("classname") +"</td>";
                       }
                                   }
answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                               }}
                              
                          }
                         catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
out.println(answer);
    return;
}
%>