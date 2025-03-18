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
if(!request.getParameter("teacher").equals("Choose teacher"))
{
                        try
                        {
                            ResultSet rrs=rst.executeQuery("select * from userstb where userid='"+request.getParameter("teacher")+"'");
                             rrs.last();
                          if(rrs.getRow()==1)
                          {
                              rrs.first();
                               Statement stcourse=con.createStatement();
                               ResultSet rscourse=stcourse.executeQuery("select * from diariestb where registrar='"+rrs.getString("userid")+"' order by regdate desc");
                               if(rscourse.first())
                               {
               answer="<div class='row'><div class='col-lg-12'><div class='card'><div class='card-body'>"
               + "<h5 class='card-title'><u>LIST OF CLASS DIARIES</u></h5>"
               + "<h5 class='card-title'>NAMES:"+rrs.getString("name")+" "+rrs.getString("surname")+"</h5>"
               + "<!-- Table with stripped rows -->"+
              "<table class='table datatable'><thead><tr><th scope='col'>#</th><th scope='col'>Date</th><th scope='col'>Option</th><th scope='col'>classes</th>"
                       + "<th scope='col'>Courses</th><th scope='col'>Status</th><th scope='col'>Score</th><th scope='col'>Observation</th>"+
              "<th scope='col'></th></tr></thead><tbody>";
                                   rscourse.beforeFirst();
                                   String theids="";
                                   while(rscourse.next())
                                   {
                                       if(theids.contains(rscourse.getString("diaryid")))
                                       {
                                           break;
                                       }
                                       theids+=rscourse.getString("diaryid");
                                      String options="",classes="",courses="",obs="";
                                   n++;
                                   Statement std=con.createStatement();
                                   ResultSet rsd=std.executeQuery("select * from diariestb where diaryid='"+rscourse.getString("diaryid")+"' order by period asc");
                                   if(rsd.first())
                                   {
                                   rsd.beforeFirst();
                                   while(rsd.next())
                                   {
                                   Statement stclass=con.createStatement();
                                   Statement stopt=con.createStatement();
                                   Statement stsub=con.createStatement();
                                   ResultSet rsclass=stclass.executeQuery("select * from optionstb where optionid like'%"+rsd.getString("optionid")+"%'");
                                   String [] clas=rsd.getString("classid").split("_");
                                   ResultSet rsopt=stopt.executeQuery("select * from classestb where classid='"+clas[0]+"'");
                                   ResultSet rssub=stsub.executeQuery("select * from coursestb where coursecode='"+rsd.getString("courseid")+"'");
                                  rsclass.first();
                                  rsopt.first(); 
                                   rssub.first();
                                    options+=rsd.getString("period")+"."+rsclass.getString("optionname")+"<br/>";
                                   classes+=rsd.getString("period")+"."+rsopt.getString("classname")+"<br/>";
                                    courses+=rsd.getString("period")+"."+rssub.getString("coursename")+"<br/>";
                                    obs+=rsd.getString("observation")+"<br/>";
                                    }
                                       
                      answer+="<tr>"+
                    "<th scope='row'>"+ n +"</th>"+
                    " <td>"+rscourse.getString("regdate")+"</td>"+
                   " <td>"+options+"</td>"+
                    "<td>"+classes+ "</td>"+
                    "<td>"+courses +"</td>"
                              + "<td>"+rscourse.getString("status")+"</td>"
                              + "<td>"+rscourse.getString("score")+"</td>"
                              +"<td>"+obs+"</td>"
                              +"<td><form action='reportclassdiary.jsp' method='POST'><input type='hidden' name='thisdiary' value='"+rscourse.getString("diaryid")+"'/>"+
                              "<input type='submit' class='btn btn-primary' value='View'></form><form action='generatediariespdf.jsp' method='POST'>"
                              + "<input type='hidden' name='thisdiary' value='"+rscourse.getString("diaryid")+"'/>"
                              + "<input type='submit' class='btn btn-primary' value='Generate PDF'></fomr></td>";
                                    }
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
out.println(answer);
return;
}
%>
