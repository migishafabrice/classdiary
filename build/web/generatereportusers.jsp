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
if(!request.getParameter("function").equals("Choose function") && request.getParameter("sex").equals("Choose sex") && request.getParameter("active").equals("Active")
        && request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"'order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'>"+request.getParameter("function")+" staff</h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
    return;
}
%>

<%
if(!request.getParameter("function").equals("Choose function") && !request.getParameter("sex").equals("Choose sex") && !request.getParameter("active").equals("Active")
        && request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' and sex='"+request.getParameter("sex")+"' and "
                                       + "active='"+request.getParameter("active")+"' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"' and sex='"+request.getParameter("sex")+"'"
                                  + "and active='"+request.getParameter("active")+"' order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'>"+request.getParameter("sex")+" "+request.getParameter("function")+" staff<br/> Active:"+request.getParameter("active")+"</h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          }
                        }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
return;
}
%>

<%
if(!request.getParameter("function").equals("Choose function") && !request.getParameter("sex").equals("Choose sex") && request.getParameter("active").equals("Active")
        && request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' and sex='"+request.getParameter("sex")+"' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"' and sex='"+request.getParameter("sex")+"' order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'>"+request.getParameter("sex")+" "+request.getParameter("function")+" staff<br/></h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
    return;
}
%>


<%
if(!request.getParameter("function").equals("Choose function") && !request.getParameter("sex").equals("Choose sex") && !request.getParameter("active").equals("Active")
        && !request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' and sex='"+request.getParameter("sex")+"' and "
                                       + "active='"+request.getParameter("active")+"' and reset='"+request.getParameter("reset")+"' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"' and sex='"+request.getParameter("sex")+"'"
                                  + "and active='"+request.getParameter("active")+"' and reset='"+request.getParameter("reset")+"' order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'>"+request.getParameter("sex")+" "+request.getParameter("function")+" staff<br/> Active:"+request.getParameter("active")+""
                                      + "<br/>Password reset:"+request.getParameter("active")+"</h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
    return;
}
%>

<%
if(!request.getParameter("function").equals("Choose function") && request.getParameter("sex").equals("Choose sex") && request.getParameter("active").equals("Active")
        && !request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' and reset='"+request.getParameter("reset")+"' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"' and reset='"+request.getParameter("reset")+"' order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "<h5 class='card-title'>"+request.getParameter("function")+" staff<br/> Password reset:"+request.getParameter("reset")+""
                                      + "</h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
    return;
}
%>

<%
if(!request.getParameter("function").equals("Choose function") && request.getParameter("sex").equals("Choose sex") && !request.getParameter("active").equals("Active")
        && !request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' and active='"+request.getParameter("active")+"'"
                                       + " and reset='"+request.getParameter("reset")+"' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"' "
                                  + "and active='"+request.getParameter("active")+"' and reset='"+request.getParameter("reset")+"' order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "h5 class='card-title'>"+request.getParameter("function")+" staff<br/> Active:"+request.getParameter("active")+""
                                      + "</br>Password reset:"+request.getParameter("reset")+"</h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
    return;
}
%>

<%
if(!request.getParameter("function").equals("Choose function") && request.getParameter("sex").equals("Choose sex") && !request.getParameter("active").equals("Active")
        && request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' and active='"+request.getParameter("active")+"' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"' and active='"+request.getParameter("active")+"' order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "h5 class='card-title'>"+request.getParameter("function")+" staff<br/> Active:"+request.getParameter("active")+""
                                      + "</h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
    return;
}
%>


<%
if(!request.getParameter("function").equals("Choose function") && !request.getParameter("sex").equals("Choose sex") && request.getParameter("active").equals("Active")
        && !request.getParameter("reset").equals("Password reset"))
{
                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                             if(request.getParameter("function").equals("All"))
                             {
                               rrs=rst.executeQuery("select * from userstb where function<>'Administrator' and sex='"+request.getParameter("sex")+"' and reset='"+request.getParameter("reset")+"' order by name,surname  asc");  
                             }
                             else{
                          rrs=rst.executeQuery("select * from userstb where function='"+request.getParameter("function").toString()+"' and sex='"+request.getParameter("sex")+"' and reset='"+request.getParameter("reset")+"' order by name,surname  asc");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
                                      + "h5 class='card-title'>"+request.getParameter("sex")+" "+request.getParameter("function")+" staff<br/>"
                                      + "Password reset:"+request.getParameter("active")+"</h5><p></p>"
                                      + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Name</th><th scope='col'>Surname</th>"+
              "<th scope='col'>Sex</th><th scope='col'>Position</th><th scope='col'>Telephone</th><th scope='col'>Email</th></tr></thead><tbody>";
                              while(rrs.next())
                              {
                                  n++;
                           answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                   " <td>"+rrs.getString("name")+"</td>"+
                    "<td>"+rrs.getString("surname")+ "</td>"+
                    "<td>"+rrs.getString("sex") +"</td>"+
                    "<td>"+rrs.getString("function") +"</td>"+
                    "<td>"+rrs.getString("telephone") +"</td>"+
                    "<td>"+rrs.getString("email")+"</td></tr>";
                       }
                              answer+="</tbody></table><p><b>Total numbers:</b>"+ n+"</p></div></div></div></div>";
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }
%>
<% out.println(answer); %>
<%
    return;
}
%>