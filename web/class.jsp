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
    String msg;
    try
       {
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
Statement st=con.createStatement();
ResultSet rs;
    %>
<!DOCTYPE html>
<jsp:include page="aside.jsp"/>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Class registration</h1>
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
              <h5 class="card-title">Class identification</h5>

              <!-- General Form Elements -->
              <form action="cla.jsp" method="POST">
                
                  <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Name</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="classname">
                  </div>
                </div>
                 
                      <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">Option</label>
                  <div class="col-sm-10">
                      
                      <%
rs=st.executeQuery("select * from optionstb order by optionname asc"); 
if(rs.first())
{
    rs.beforeFirst();
    while(rs.next())
    {
%>
<div class="form-check"><input type="checkbox" class="form-check-input" value="<%= rs.getString("optionid") %>" name="classopt"/>
    <label class="form-check-label"><%= rs.getString("optionname") %></label></div>
<%
    }
}
}
catch(Exception e)
       {
session.setAttribute("info","Connection failed");
       }
                       %>
                  
                  </div>
                      </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Save class</button>
                  </div>
                </div>

              </form><!-- End General Form Elements -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <jsp:include page="footer.jsp"/>