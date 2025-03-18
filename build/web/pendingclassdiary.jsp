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
<!DOCTYPE html>
<jsp:include page="aside.jsp"/>
<script lang="javascript">
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
      <h1>List of class diaries</h1>
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

 <form action="sclass.jsp" method="POST">  
<section class="section">
      <div class="row">
        <div class="col-lg-12">
       </div>
      </div>
    </section></form>
     <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Class diaries</h5>
              
              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Surname</th>
                    <th scope="col">Date</th>
                    <th scope="col">Status</th>
                    <th scope="col">Score</th>
                    <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
<%
    try
    {
st=con.createStatement();
rs=st.executeQuery("select  * from diariestb order by diaryid desc,diarydate desc"); 
int n=1;
if(rs.first())
{
Statement gst=con.createStatement();
rs.beforeFirst();
ResultSet grs=null;
String idex="";
    while(rs.next())
    {
     if(!rs.getString("diaryid").equals(idex))
     {
         idex=rs.getString("diaryid");
     }
     else
     {
         continue;
     }
        grs=gst.executeQuery("select * from userstb where userid='"+rs.getString("registrar")+"'");
       grs.last();      
%>
<tr><td><%= n %></td><td><% out.println(grs.getString("name")); %></td><td><% out.println(grs.getString("surname")); %></td>
    <td><% out.println(rs.getString("diarydate")); %></td><td><% out.println(rs.getString("status")); %></td>
    <td><% out.println(rs.getString("score")); %></td><td><form action="viewclassdiary.jsp" method="POST"><input type="hidden" name="thisdiary" value="<%= rs.getString("diaryid") %>"/><button type="submit" class="btn btn-primary">View</button></form></td></tr>
<%
   // grs.close();
    }
n++;
    
}
}
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("pendingclassdiary.jsp");
            return;
       }
                       %>
                </tbody>
                  </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

   <jsp:include page="footer.jsp"/>