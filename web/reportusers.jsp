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
%>
<%
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
Statement rst=con.createStatement();
%>
<script lang="javascript" >
    function generateReport()
    {
       ;
     var funct=document.getElementById("isfunct").value;
     var sex=document.getElementById("issex").value;
     var active=document.getElementById("isactive").value;
     var reset=document.getElementById("isreset").value;
    if (funct=="Choose function")
    {
        document.getElementById("response").innerHTML = "";
        return;
    } 
    else 
    {
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
        xmlhttp.open("POST","generatereportusers.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("function="+funct+"&sex="+sex+"&active="+active+"&reset="+reset);
    }
    }
      </script>
<jsp:include page="aside.jsp"/>
<main id="main" class="main">
    <div class="pagetitle">
      <h1>Report of staff</h1>
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
              <h5 class="card-title">Generate report</h5>
              <p></p>
              <form action="generateuserspdf.jsp" method="POST" class="row g-3">
              <label>Choose type of report</label>
                <div class="col-md-2">
                    <select class="form-select" id="isfunct" onchange="generateReport();" name="function"><option>Choose function</option>
                    <option value="School manager">School manager</option>
                      <option value="Deputy of studies">Deputy of studies</option>
                      <option value="Teacher">Teacher</option>
                      <option value="All">All</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="issex" onchange="generateReport();" name="sex"><option>Choose sex</option><option value="Male">Male</option><option value="Female">Female</option></select>
                </div>
    <div class="col-md-2">
        <select class="form-select" id="isactive" onchange="generateReport();" name="active"><option>Active</option>
                      <option value="Yes">Yes</option><option value="No">No</option></select>
                </div>
    <div class="col-md-2">
        <select class="form-select" id="isreset" onchange="generateReport();" name="reset"><option>Password reset</option>
                      <option value="Yes">Yes</option><option value="No">No</option></select>
                </div>
    <div class="col-md-2">
                  <input type="submit" class="btn btn-primary" id="ispdf" value="Generate report in PDF"/>
                </div>
</form></div></div></div></div>
        <div id="response">
            
        </div>
    </section>

  </main><!-- End #main -->

  <jsp:include page="footer.jsp"/>
 