<%@page import="javax.swing.JOptionPane"%>
<%
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
    %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
Properties properties = new Properties();
Statement st;
ResultSet rs;
String msg;
%>
<%
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);

    %>
<jsp:include page="aside.jsp"/>
<script language="javascript">
       function changeClass(str)
    {
    if (str == "-----Choose option-----") {
        document.getElementById("dclass").innerHTML = "";
        return;
    } else {
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("dclass").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("POST","data.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("q="+str);
    }
    }
     function changeCourse(str)
    {
    if (str == "-----Choose class-----" || str==="") {
        document.getElementById("dcourse").innerHTML = "";
        return;
    } else {
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("dcourse").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("POST","data.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("c="+str+"&o="+document.getElementById("doption").value);
    }
    }
      function getPeriod()
      {
document.getElementById("sent").innerHTML+="<tr><th scope='row'><input type='text' readonly='' value='"+document.getElementById("dperiod").value+"' name='eperiod' class='form-control' size='1'/></th><td><input type='text' readonly='' value='"+document.getElementById("doption").value+"' name='eoption' class='form-control'size='1'/></td>\n\
<td><input type='text' readonly='' value='"+document.getElementById("dclass").value+"."+document.getElementById("droom").value+"' name='eclass' class='form-control' size='1'/></td><td><input type='text' readonly='' value='"+document.getElementById("dcourse").value+"' name='ecourse' class='form-control' size='1'/></td><td><input type='text' readonly='' value='"+document.getElementById("dmatter").value+"' name='ematter' class='form-control' size='1'/></td>\n\
<td><input type='text' readonly='' value='"+document.getElementById("dtopic").value+"' name='etopic' class='form-control' size='1'/></td><td><input type='text' readonly='' value='"+document.getElementById("dapp").value+"' name='eapp' class='form-control' size='1'/></td><td><input type='text' readonly='' value='"+document.getElementById("dobs").value+"' name='eobs' class='form-control'size='1'/></td></tr>";
document.getElementById("button").innerHTML="<div class='row mb-3'><label class='col-sm-2 col-form-label'>\n\
        </label><div class='col-sm-10'><button type='submit' name='submitted'class='btn btn-primary'>Save class diary</button>\n\
        </div></div>"
        resetFields();
      }
      function resetFields()
      {
     var v=parseInt(document.getElementById("dperiod").value);
     document.getElementById("dperiod").value=v+1;
      }
      </script>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Class diary view</h1>
      <nav>
        <ol class="breadcrumb">
          <!--<li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item">Tables</li>
          <li class="breadcrumb-item active">General</li>-->
        </ol>
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
              <h5 class="card-title">Class diary information</h5>
              <%
    try
    {
Statement ust=con.createStatement();
if(session.getAttribute("thisdiary")==null)
{
session.setAttribute("thisdiary",request.getParameter("thisdiary").toString());
}
ResultSet urs=ust.executeQuery("select  distinct diaryid,diarydate,registrar,regdate from diariestb where status='Pending' and diaryid='"+session.getAttribute("thisdiary")+"' order by diarydate asc"); 
int n=1;
if(urs.first())
{
out.println("<b><label>Date of submission:"+urs.getString("regdate")+"</label></b><br/>");
out.println("<b><label>Date scheduled on:"+urs.getString("diarydate")+"</label></b><br/>");
Statement gst=con.createStatement();
ResultSet grs=null;
grs=gst.executeQuery("select * from userstb where userid='"+urs.getString("registrar")+"'");
grs.last();      
out.println("<b><label>Teacher:"+grs.getString("name")+" "+grs.getString("surname")+"</label></b>");
   // grs.close();    
}
}
catch(Exception e)
       {
session.setAttribute("info",e.toString());
       }
                       %>
              <!-- Table with stripped rows -->
              <form action="generatediariespdf.jsp" method="POST">
              <table class="table table-striped">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Option</th>
                    <th scope="col">Class</th>
                    <th scope="col">Course</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Sub-Topic</th>
                    <th scope="col">Application</th>
                    <th scope="col">Observation</th>
                    </tr>
                </thead>
                <tbody>
                      <%
    try
    {
st=con.createStatement();
rs=st.executeQuery("select * from diariestb where diaryid='"+session.getAttribute("thisdiary")+"' order by period asc"); 
if(rs.first())
{
    %>
    <input type="hidden" name="todiary" value="<%= session.getAttribute("thisdiary") %>"/>
    <%
    
     rs.beforeFirst();
    while(rs.next())
    {
String myclass=rs.getString("classid");
String [] classes=myclass.split("_");
Statement est=con.createStatement();
ResultSet ers=est.executeQuery("select * from optionstb where optionid='"+rs.getString("optionid")+"' ");
ers.first();
Statement ist=con.createStatement();
ResultSet irs=ist.executeQuery("select * from classestb where classid='"+classes[0]+"'");
irs.first();
Statement ost=con.createStatement();
ResultSet ors=ost.executeQuery("select * from coursestb where optionid='"+rs.getString("optionid")+"' and classid='"+classes[0]+"'");
ors.first();
%>
<tr><td><% out.println(rs.getString("period"));%></td><td><% out.println(ers.getString("optionname"));%></td><td><% 
    if(classes[1].equals("None"))
    {
        out.println(irs.getString("classname"));
    }
else
    {
      out.println(irs.getString("classname")+" "+classes[1]);  
    }%></td>
                       <td><% out.println(ors.getString("coursename"));%></td>
                       <td><% out.println(rs.getString("matter"));%></td>
                       <td><% out.println(rs.getString("topic"));%></td>
                       <td><% out.println(rs.getString("application"));%></td>
                       <td><% out.println(rs.getString("observation"));%></td>
                       </tr>
<%
    }
rs.last();
%>
<tr><td><b>Homework:</b></td><td colspan="7"><% out.println(rs.getString("homework"));%></td></tr>
 <tr>
<td colspan="8"><input type="hidden" name="thisdiary" value="<%= rs.getString("diaryid")%>"><button type="submit" class="btn btn-primary" name="submit">Generate PDF</button></td>
                      
                  </tr>
<%
}
}
catch(Exception e)
       {
session.setAttribute("info",e.toString());
       }
                       %>
                       
                       
                 
                    </tbody>
              </table></form>
              <!-- End Table with stripped rows -->

            </div>
          </div>
        </div>
      </div>
    </section>
  </main><!-- End #main -->
   <jsp:include page="footer.jsp"/>