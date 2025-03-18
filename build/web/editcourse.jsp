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
 <%
if(request.getParameter("btnupdate")!=null && request.getParameter("btnupdate")!="")
      {
PreparedStatement pt=con.prepareStatement("update `coursestb` set `coursename`=?, `coursetopic`=?,`courseid`=?,`optionid`=?,`classid`=? where `coursecode`=?");
pt.setString(1, request.getParameter("coursename").toString());
pt.setString(2, request.getParameter("coursetopic").toString());
pt.setString(3, request.getParameter("coursecode").toString());
pt.setString(4, request.getParameter("courseopt").toString());
pt.setString(5, request.getParameter("courseclass").toString());
pt.setString(6, request.getParameter("ccourse"));
pt.execute();
msg="<font color='green'>Course edited successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editcourse.jsp");
return;
      }
if(request.getParameter("btndelete")!=null && request.getParameter("btndelete")!="")
{
PreparedStatement pt=con.prepareStatement("update `coursestb` set `active`=? where `coursecode`=?");
pt.setString(1,"NO");
pt.setString(2, request.getParameter("meID").toString());  
pt.execute();
msg="<font color='green'>Course deactivated successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editcourse.jsp");
return;
}
if(request.getParameter("btnactive")!=null && request.getParameter("btnactive")!="")
{
PreparedStatement pt=con.prepareStatement("update `coursestb` set `active`=? where `coursecode`=?");
pt.setString(1,"YES");
pt.setString(2, request.getParameter("meID").toString());  
pt.execute();
msg="<font color='green'>Course activated successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editcourse.jsp");
return;
}
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
      <h1>Edit class</h1>
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
              <h5 class="card-title">List of courses</h5>
             <div class="row mb-3">
                  <div class="col mb-3">
                      <a href="course.jsp"><button class="btn btn-primary">Add new course</button></a>
                  </div>
              </div>

              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Course code</th>
                    <th scope="col">Course</th>
                    <th scope="col">Topics</th>
                    <th scope="col">Class</th>
                    <th scope="col">Option</th>
                    <th scope="col">State</th>
                    <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <%
                        try
                        {
                         if(!session.getAttribute("userFunction").equals("teacher"))
                         {
                          ResultSet rrs=rst.executeQuery("select * from coursestb order by coursename asc");
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              int n=1;
                              while(rrs.next())
                              {
                                  Statement gst=con.createStatement();
                                  ResultSet grs=gst.executeQuery("select * from optionstb where optionid='"+rrs.getString("optionid")+"'");
                                  Statement cst=con.createStatement();
                                  ResultSet crs=cst.executeQuery("select * from classestb where classid='"+rrs.getString("classid")+"'");
                                  grs.last();
                                  crs.last();
                                  String topic="";
                                  int num=1;
                                  if(rrs.getString("coursetopic").contains(";"))
                                  {
                                    String [] topics=rrs.getString("coursetopic").split(";");
                                    for(int i=0;i<topics.length;i++)
                                    {
                                        topic+=num+"."+topics[i]+"<br/>";
                                        num++;
                                    }
                                  }
                                  else
                                  {
                                     topic+=num+"."+rrs.getString("coursetopic")+"<br/>";
                                  }
                         %>
                         <tr>
                    <th scope="row"><%= n %></th>
                    <td><%= rrs.getString("courseid") %></td>
                    <td><%= rrs.getString("coursename") %></td>
                    <td><%= topic %></td>
                    <td><%= crs.getString("classname") %></td>
                    <td><%= grs.getString("optionname") %></td>
                    <td><%= rrs.getString("active") %></td>
                    <td><form action="editcourse.jsp" method="POST"><input type="hidden" name="meID" value="<%= rrs.getString("coursecode") %>"/><span class="badge bg-success"><input type="submit" class="btn btn" name="btnedit" value="Edit"/></span><% if(rrs.getString("active").equals("NO"))
                    {
                        %>
                            <span class="badge bg-warning"> <input type="submit" class="btn btn" name="btnactive" value="Activate"/></span>
                        <%
                    }
else
{
%><span class="badge bg-danger"><input type="submit" class="btn btn" name="btndelete" value="Deactivate"/></span><%}%></form></td>
                  </tr>
                         <%
                             n++;
                              }
                          }
                         }
                          }
                        catch(Exception e)
                        {
                           session.setAttribute("info",e.toString());
                        }
                    %>
                  
                  </tbody>
              </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>
      <%if(request.getParameter("btnedit")!=null && request.getParameter("btnedit")!="")
      {
       String medit=request.getParameter("meID").toString();
       Statement est=con.createStatement();
       ResultSet ers=est.executeQuery("select * from coursestb where coursecode='"+medit+"'");
       ers.last();
       if(ers.getRow()==1)
       {
           if(session.getAttribute("userFunction").equals("Administrator") || session.getAttribute("userFunction").equals("School manager") 
                   || session.getAttribute("userFunction").equals("Deputy of studies"))
           {
           %>
           <div class="card">
            <div class="card-body">
                <h5 class="card-title">Course information</h5>
                <form action="editcourse.jsp" method="POST">
                  <input type="hidden"  name="ccourse" value="<%= ers.getString("coursecode") %>"/>
              <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Code</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="coursecode" value="<%= ers.getString("courseid") %>"/>
                  </div>
                </div>
                  <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Name</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="coursename" value="<%= ers.getString("coursename") %>"/>
                  </div>
                </div>
                 <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Topic[Separate topics with ;]</label>
                  <div class="col-sm-10">
                      <textarea class="form-control" name="coursetopic"><%= ers.getString("coursetopic") %></textarea>
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
                    <input type="submit" class="btn btn-primary" name="btnupdate" value="Edit course"/>
                  </div>
                </div></form>
            </div>
           </div>
              <!-- End General Form Elements -->

            </div>
          </div>
           <%
       }
else
{
%>
<div class="card">
            <div class="card-body">
                <h5 class="card-title"><font color="red">You are not eligible to edit this class</font></h5>
            </div>
</div>
<%
}
}
else
{
%>
<div class="card">
            <div class="card-body">
                <h5 class="card-title"><font color="red">Invalid data,contact the administrator</font></h5>
            </div>
</div>
<%
} }%>
        </div>
      </div>
    </section>

  </main><!-- End #main -->
  <jsp:include page="footer.jsp"/>
 