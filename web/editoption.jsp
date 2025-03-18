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
PreparedStatement pt=con.prepareStatement("update `optionstb` set `optionname`=?, `description`=? where optionid=?");
pt.setString(1,request.getParameter("optname").toString());
pt.setString(2, request.getParameter("optdes").toString());
pt.setString(3, request.getParameter("copt").toString());

pt.execute();
msg="<font color='green'>Option edited successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editoption.jsp");
return;
      }
if(request.getParameter("btndelete")!=null && request.getParameter("btndelete")!="")
{
PreparedStatement pt=con.prepareStatement("update `optionstb` set `active`=? where `optionid`=?");
pt.setString(1,"NO");
pt.setString(2, request.getParameter("meID").toString());  
pt.execute();
msg="<font color='green'>Option deactivated successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editoption.jsp");
return;
}
if(request.getParameter("btnactive")!=null && request.getParameter("btnactive")!="")
{
PreparedStatement pt=con.prepareStatement("update `optionstb` set `active`=? where `optionid`=?");
pt.setString(1,"YES");
pt.setString(2, request.getParameter("meID").toString());  
pt.execute();
msg="<font color='green'>Option activated successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editoption.jsp");
return;
}
      %>
<jsp:include page="aside.jsp"/>
<main id="main" class="main">
    <div class="pagetitle">
      <h1>Manage options</h1>
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
              <h5 class="card-title">List of options</h5>
              <div class="col-lg-12">
                  <div class="col mb-3">
                      <a href="option.jsp"><button class="btn btn-primary">Add new option</button></a>
                  </div>
              </div>

              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Option</th>
                    <th scope="col">Description</th>
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
                          ResultSet rrs=rst.executeQuery("select * from optionstb order by optionname asc");
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              int n=1;
                              while(rrs.next())
                              {
                         %>
                         <tr>
                    <th scope="row"><%= n %></th>
                    <td><%= rrs.getString("optionname") %></td>
                    <td><%= rrs.getString("description") %></td>
                    <td><%= rrs.getString("active") %></td>
                    <td><form action="editoption.jsp" method="POST"><input type="hidden" name="meID" value="<%= rrs.getString("optionid") %>"/><span class="badge bg-success"><input type="submit" class="btn btn" name="btnedit" value="Edit"/></span><% if(rrs.getString("active").equals("NO"))
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
       ResultSet ers=est.executeQuery("select * from optionstb where optionid='"+medit+"'");
       ers.last();
       if(ers.getRow()==1)
       {
           if(session.getAttribute("userFunction").equals("Administrator") || session.getAttribute("userFunction").equals("School manager") 
                   || session.getAttribute("userFunction").equals("Deputy of studies"))
           {
           %>
           <div class="card">
            <div class="card-body">
              <h5 class="card-title">Option information</h5>
              <!-- General Form Elements -->
              <form action="editoption.jsp" method="POST">
                  <input type="hidden"  name="copt" value="<%= ers.getString("optionid") %>"/>
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">First name</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="optname" value="<%= ers.getString("optionname") %>"/>
                  </div>
                </div>
                  <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Description</label>
                  <div class="col-sm-10">
                      <textarea class="form-control" name="optdes"><%= ers.getString("description") %></textarea>
                  </div>
                </div>     
                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-10">
                    <input type="submit" class="btn btn-primary" name="btnupdate" value="Edit option"/>
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
                <h5 class="card-title"><font color="red">You are not eligible to edit this option</font></h5>
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
 