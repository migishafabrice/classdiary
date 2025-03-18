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
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
Statement rst=con.createStatement();
Statement st=con.createStatement();
ResultSet rs;
String msg;
%>
 <%
if(request.getParameter("btnupdate")!=null && request.getParameter("btnupdate")!="")
      {
if(!request.getParameter("functuser").equals("Teacher"))
    {
    rs=st.executeQuery("select * from userstb where function='"+request.getParameter("functuser")+"' and active='YES'");
    if(rs.first())
    {
        session.setAttribute("info","<font color='red'>Only one "+request.getParameter("functuser")+" can be active, deactivate the existing before proceeding.</font>");
        response.sendRedirect("edituser.jsp");
        return;
    }
    }
          PreparedStatement pt=con.prepareStatement("update `userstb` set `name`=?, `surname`=?, `email`=?, `telephone`=?, `function`=?,"
        + "`username`=? where userid=?");
pt.setString(1,request.getParameter("luser").toString());
pt.setString(2, request.getParameter("fuser").toString());
pt.setString(3, request.getParameter("muser").toString());
pt.setString(4, request.getParameter("tuser").toString());
pt.setString(5,request.getParameter("functuser").toString());
pt.setString(6, request.getParameter("muser").toString());
pt.setString(7, request.getParameter("cuser").toString());
pt.execute();
msg="<font color='green'>Staff edited successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("edituser.jsp");
return;
      }
if(request.getParameter("btndelete")!=null && request.getParameter("btndelete")!="")
{
PreparedStatement pt=con.prepareStatement("update `userstb` set `active`=? where `userid`=?");
pt.setString(1,"NO");
pt.setString(2, request.getParameter("meID").toString());  
pt.execute();
msg="<font color='green'>Staff deactivated successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("edituser.jsp");
return;
}
if(request.getParameter("btnactive")!=null && request.getParameter("btnactive")!="")
{
PreparedStatement pt=con.prepareStatement("update `userstb` set `active`=? where `userid`=?");
pt.setString(1,"YES");
pt.setString(2, request.getParameter("meID").toString());  
pt.execute();
msg="<font color='green'>Staff activated successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("edituser.jsp");
return;
}
      %>
<jsp:include page="aside.jsp"/>
<main id="main" class="main">
    <div class="pagetitle">
      <h1>Manage staff</h1>
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
              <h5 class="card-title">List of staff</h5>
              <div class="col-lg-12">
                  <div class="col mb-3">
                      <a href="register.jsp"><button class="btn btn-primary">Add new employee</button></a>
                  </div>
              </div>
              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Surname</th>
                    <th scope="col">Position</th>
                    <th scope="col">Telephone</th>
                    <th scope="col">Email</th>
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
                          ResultSet rrs=rst.executeQuery("select * from userstb where function <>'Administrator' order by name,surname  asc");
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              int n=1;
                              while(rrs.next())
                              {
                         %>
                         <tr>
                    <th scope="row"><%= n %></th>
                    <td><%= rrs.getString("name") %></td>
                    <td><%= rrs.getString("surname") %></td>
                    <td><%= rrs.getString("function") %></td>
                    <td><%= rrs.getString("telephone") %></td>
                    <td><%= rrs.getString("email") %></td>
                    <td><%= rrs.getString("active") %></td>
                    <td><form action="edituser.jsp" method="POST"><input type="hidden" name="meID" value="<%= rrs.getString("userid") %>"/><span class="badge bg-success"><input type="submit" class="btn btn" name="btnedit" value="Edit"/></span><% if(rrs.getString("active").equals("NO"))
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
       ResultSet ers=est.executeQuery("select * from userstb where userid='"+medit+"'");
       ers.last();
       if(ers.getRow()==1)
       {
           if((session.getAttribute("userFunction").equals("Administrator") &&(ers.getString("function").equals("School manager") || ers.getString("function").equals("Deputy of studies")
                   || ers.getString("function").equals("Teacher")))
                   || (session.getAttribute("userFunction").equals("School manager") &&( ers.getString("function").equals("Deputy of studies")
                   || ers.getString("function").equals("Teacher"))) || (session.getAttribute("userFunction").equals("Deputy of studies") 
                   &&(ers.getString("function").equals("Teacher"))))
           {
           %>
           <div class="card">
            <div class="card-body">
              <h5 class="card-title">Staff identification</h5>
              <!-- General Form Elements -->
              <form action="edituser.jsp" method="POST">
                  <input type="hidden"  name="cuser" value="<%= ers.getString("userid") %>"/>
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">First name</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="fuser" value="<%= ers.getString("name") %>"/>
                  </div>
                </div>
                  <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Last name</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="luser" value="<%= ers.getString("surname") %>">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="inputEmail" class="col-sm-2 col-form-label" >Email</label>
                  <div class="col-sm-10">
                    <input type="email" class="form-control" value="<%= ers.getString("email") %>" name="muser">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Telephone</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" value="<%= ers.getString("telephone") %>" name="tuser">
                  </div>
                </div>
                   <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">Function</label>
                  <div class="col-sm-10">
                    <select class="form-select" aria-label="Default select example" name="functuser">
                      <option selected>-----Choose function-----</option>
                      <%
                          if(String.valueOf(session.getAttribute("userFunction")).equals("Administrator"))
                                  {
                       %>
                       <option value="School manager">School manager</option>
                      <option value="Deputy of studies">Deputy of studies</option>
                      <option value="Teacher">Teacher</option>
                       <%
                           }
if(String.valueOf(session.getAttribute("userFunction")).equals("School manager"))
{
%>
                      <option value="Deputy of studies">Deputy of studies</option>
                      <option value="Teacher">Teacher</option>
<%
                                  }
                          %>
                          <%
if(String.valueOf(session.getAttribute("userFunction")).equals("Deputy of studies"))
{
%>
                      
                      <option value="Teacher">Teacher</option>
<%
                                  }
                          %>
                        </select>
                  </div>
                </div>      
                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-10">
                    <input type="submit" class="btn btn-primary" name="btnupdate" value="Edit staff"/>
                  </div>
                </div>
              </form><!-- End General Form Elements -->

            </div>
          </div>
           <%
       }
else
{
%>
<div class="card">
            <div class="card-body">
                <h5 class="card-title"><font color="red">You are not eligible to edit this user</font></h5>
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
}
      }%>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

  <jsp:include page="footer.jsp"/>
 