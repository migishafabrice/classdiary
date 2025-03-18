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

<%
Properties properties = new Properties();

%>
<%
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
Statement st=con.createStatement();
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
%>
<script lang="javascript" >
    function generateReport()
    {
       
     var teacher=document.getElementById("isTeacher").value;  
     
            if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
            document.getElementById("response").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("POST","generatereportdiaries.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("teacher="+teacher);
    
    }
     
      </script>
<jsp:include page="aside.jsp"/>
<main id="main" class="main">
    <div class="pagetitle">
      <h1>Report of class diaries</h1>
      <nav>
                  <p>
              <%
                      String info=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(info))
                      {
                          out.println(info);
                      }
                      session.removeAttribute("info");
              %>
              
          </p>
      </nav>
    </div><!-- End Page Title -->
    <section class="section">
      <div class="row">
        <div class="col-lg-12">
<div class="card">
   
            <div class="card-body">
              <h5 class="card-title">Generate class diaries report</h5>
              <p></p>
              <form action="generatediariespdf.jsp" method="POST" class="row g-3">
                                    <%
                                        try
                                        {
                      rs=st.executeQuery("select * from userstb where function<>'Administrator' order by name,surname asc");
                      %>
              <label>Choose teacher</label>
               <div class="col-md-2">
                   <select class="form-select" id="isTeacher" onclick="generateReport();" name="teacher">
                       <option>Choose teacher</option>
                       <%
                            if(rs.first())
                            {
                                rs.beforeFirst();
                                while(rs.next())
                                {
                                    if(!session.getAttribute("userFunction").equals("Teacher"))
                                    {
                            %>
                            <option value="<%= rs.getString("userid") %>"><%= rs.getString("name")+" "+rs.getString("surname") %></option>
                            <%
                                }
                              else
{
if(session.getAttribute("userCode").equals(rs.getString("userid")))
{
%>
<option value="<%= rs.getString("userid") %>"><%= rs.getString("name")+" "+rs.getString("surname") %></option>
<%
    }
}
                                }
                               }
                            %>
                       
                   </select> 
               </div>
               
<%
                                
}
catch(Exception e)
{
session.setAttribute("info", "<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("dashboard.jsp");
return;
}
                            %>
   
</form></div></div></div></div>
        <div id="response">
            
        </div>
    </section>

  </main><!-- End #main -->

  <jsp:include page="footer.jsp"/>
 