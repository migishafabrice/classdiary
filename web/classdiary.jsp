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
<script lang="javascript">
       function changeClass(str)
    {
    if (str == "Choose option") {
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
    if (str == "Choose class" || str==="") {
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
    function changeTopic(str)
    {
    if (str == "Choose course" || str==="") {
        document.getElementById("dmatter").innerHTML = "";
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
                document.getElementById("dmatter").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("POST","data.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("m="+document.getElementById("dcourse").value);
    }
    }
      function getPeriod()
      {
document.getElementById("sent").innerHTML+="<tr><th scope='row'><input type='text' readonly='' value='"+document.getElementById("dperiod").value+"' name='eperiod' class='form-control' size='1'/></th>\n\
<td><input type='hidden' readonly='' value='"+document.getElementById("doption").value+"' name='eoption' class='form-control'size='1'/>\n\
<input type='text' readonly='' value='"+document.getElementById("doption").options[document.getElementById("doption").selectedIndex ].text+"' class='form-control'size='1'/></td>\n\
<td><input type='hidden' readonly='' value='"+document.getElementById("dclass").value+"_"+document.getElementById("droom").value+"' name='eclass' class='form-control' size='1'/>\n\
<input type='text' readonly='' value='"+document.getElementById("dclass").options[document.getElementById("dclass").selectedIndex ].text+"_"+document.getElementById("droom").options[document.getElementById("droom").selectedIndex ].text+"' class='form-control' size='1'/></td>\n\
<td><input type='hidden' readonly='' value='"+document.getElementById("dcourse").value+"' name='ecourse' class='form-control' size='1'/>\n\
<input type='text' readonly='' value='"+document.getElementById("dcourse").options[document.getElementById("dcourse").selectedIndex ].text+"' class='form-control' size='1'/></td>\n\
<td><input type='hidden' readonly='' value='"+document.getElementById("dmatter").value+"' name='ematter' class='form-control' size='1'/>\n\
<input type='text' readonly='' value='"+document.getElementById("dmatter").options[document.getElementById("dmatter").selectedIndex ].text+"' class='form-control' size='1'/></td>\n\
<td><input type='text' readonly='' value='"+document.getElementById("dtopic").value+"' name='etopic' class='form-control' size='1'/></td>\n\
<td><input type='text' readonly='' value='"+document.getElementById("dapp").value+"' name='eapp' class='form-control' size='1'/></td>\n\
<td><input type='text' readonly='' value='"+document.getElementById("dobs").value+"' name='eobs' class='form-control'size='1'/></td></tr>";
//var v=document.getElementById("ehome").value;
document.getElementById("button").innerHTML="<div class='row mb-3'><label class='col-sm-2 col-form-label'><b>Homework</b></label><textarea name='ehome'class='form-control' id='ehome'></textarea></div><div class='row mb-3'><label class='col-sm-2 col-form-label'>\n\
        </label><div class='col-sm-10'><button type='submit' name='submitted'class='btn btn-primary'>Save class diary</button>\n\
        </div></div>";
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
      <h1>Record class diary </h1>
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

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Class diary schedule</h5>
               <div class="row mb-2">
                  <label for="inputText" class="col-sm-1 col-form-label">Date</label>
                  <div class="col-sm-2">
                      <input type="date" class="form-control" name="edate"/>
                  </div>
                </div>
              
              <!-- Table with stripped rows -->
              <table class="table table-striped">
                <thead>
                  <tr>
                   <th scope="col">#</th>
                    <th scope="col">Option</th>
                    <th scope="col">Class</th>
                    <th scope="col">Course</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Sub Topic</th>
                    <th scope="col">Application</th>
                    <th scope="col">Observation</th>
                  </tr>
                </thead>
                <tbody id="sent">
                </tbody>
              </table><div id="button"></div>
              <!-- End Table with stripped rows -->

            </div>
          </div>

        </div>
      </div>
    </section></form>
     <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Enter information</h5>
              
              <!-- Table with stripped rows -->
              <table class="table table-striped">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Option</th>
                    <th scope="col">Class</th>
                    <th scope="col">Course</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Sub topic</th>
                    <th scope="col">Application</th>
                    <th scope="col">Observation</th>
                  </tr>
                </thead>
                <tbody>
                   <tr>
                       <td><input type="text" class="form-control" size="1" value="1" readonly="" id="dperiod" name="d"/></td>
                       <td><select class="form-select" onchange="changeClass(this.value);" id="doption" name="doption"><option>Choose option</option>
                             <%
    try{
st=con.createStatement();
rs=st.executeQuery("select * from optionstb where active='YES' order by optionname asc"); 
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
                       %></select></td>
                       <td><select class="col-md-6" id="dclass" onchange="changeCourse(this.value);" name="dclass"></select><select class="col-md-6" id="droom" name="droom">
                           <option>None</option>
                           <option>A</option><option>B</option><option>C</option><option>D</option><option>E</option><option>F</option></select></td>
                       <td><select class="form-select" id="dcourse" name="dcourse" onchange="changeTopic(this.value);"></select></td>
                       <td><select class="form-select"  id="dmatter"name="dmatter" ></select></td>
                       <td><textarea class="form-control" id="dtopic"name="dtopic"></textarea></td>
                    <td><textarea class="form-control" id="dapp"name="dapp"></textarea></td>
                    <td><textarea class="form-control" id="dobs"name="dobs"></textarea></td>
                  </tr>
                  <tr><td colspan="8"><button type="submit" class="btn btn-primary" onclick="getPeriod();">Add to class diary</button></td></tr>
                  
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