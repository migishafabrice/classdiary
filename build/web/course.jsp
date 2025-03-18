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
Statement st,rst=null;
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
<script lang="javascript" >
    function changeClass(str)
    {
    if (str == "-----Choose option-----") {
        document.getElementById("courseclass").innerHTML = "";
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
                document.getElementById("courseclass").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("POST","data.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("q="+str);
    }
    }
      </script>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Course registration</h1>
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
        <div class="col-lg-9">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Course identification</h5>

              <!-- General Form Elements -->
              <form action="cou.jsp" method="POST">
                 <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Code</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="coursecode">
                  </div>
                </div>
                  <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Name</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="coursename">
                  </div>
                </div>
                 <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Topics[Separate topics with ;]</label>
                  <div class="col-sm-10">
                      <textarea class="form-control" name="coursetopic" placeholder="Enter topics of the course"></textarea>
                  </div>
                </div>
                      <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">Option</label>
                  <div class="col-sm-10">
                      <select class="form-select"  aria-label="Default select example" name="courseopt" id="courseopt" onchange="changeClass(this.value);">
                      <option selected>-----Choose option-----</option>
                      <%
    try{
st=con.createStatement();
rs=st.executeQuery("select * from optionstb order by optionname asc"); 
if(rs.first())
{
    rs.beforeFirst();
    while(rs.next())
    {
%>
<option value='<%= rs.getString("optionid") %>'><%= rs.getString("optionname") %></option>
<%
    }
}
}
catch(Exception e)
       {
session.setAttribute("info","Connection failed");
       }
                       %>
                       
                      </select>
                  </div>
                      </div>
                        
                       
                       <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">Class</label>
                  <div class="col-sm-10">
                    <select class="form-select" aria-label="Default select example" name="courseclass" id="courseclass">
                      </select>
                  </div>
                      </div>
                      <div class="row mb-3">
                  <label class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Save course</button>
                  </div>
                </div>

              </form><!-- End General Form Elements -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

  <jsp:include page="footer.jsp"/>