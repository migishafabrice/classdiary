<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
if(session.getAttribute("userCode")==null || session.getAttribute("userCode")=="")
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    out.println("<script>location.href='index.jsp';</script>");
    return;
}
    %>
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
Statement stuser=con.createStatement();
ResultSet rsuser=stuser.executeQuery("select * from userstb where userid='"+session.getAttribute("userCode")+"' and active='YES'");
rsuser.last();
%>
<%
    
if(session.getAttribute("userCode")==null || rsuser.getRow()!=1)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    session.setAttribute("path",request.getServletPath());
    out.println("<script>location.href='index.jsp';</script>");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>E-Class Diary</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin - v2.2.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>
<body>
  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
      <a href="index.html" class="logo d-flex align-items-center">
        <img src="assets/img/logo.png" alt="">
        <span class="d-none d-lg-block">E-Class Diary</span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <div class="search-bar">
     
    </div><!-- End Search Bar -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">

        <li class="nav-item d-block d-lg-none">
          <a class="nav-link nav-icon search-bar-toggle " href="#">
            <i class="bi bi-search"></i>
          </a>
        </li><!-- End Search Icon-->
 <%
                  try
                  {
Statement nst=con.createStatement();
ResultSet nrs;
if(session.getAttribute("userFunction").equals("Teacher"))
{
nrs=nst.executeQuery("select distinct diaryid,regdate,status from diariestb where registrar='"+session.getAttribute("userCode").toString()+"'");
}
else
{
 nrs=nst.executeQuery("select distinct diaryid,regdate,status from diariestb");   
}
nrs.last();
if(nrs.getRow()>=1)
{
                  %>
        <li class="nav-item dropdown">

          <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
            <i class="bi bi-bell"></i>
            <span class="badge bg-primary badge-number"><%= nrs.getRow() %></span>
          </a><!-- End Notification Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
             
                  
            <li class="dropdown-header">
               Class diaries: <% out.println(String.valueOf(nrs.getRow()));%> registered into system.
             
            </li>
            
            <li>
              <hr class="dropdown-divider">
            </li>

            <li class="notification-item">
              <i class="bi bi-exclamation-circle text-warning"></i>
              <div>
                <h4>Class diary</h4>
                <p><a href="pendingclassdiary.jsp">The class diary submitted on <%= nrs.getString("regdate")%> is <%=nrs.getString("status")%></a></p>
                </div>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>
            <li class="dropdown-footer">
              <a href="#">Show all notifications</a>
            </li>

          </ul><!-- End Notification Dropdown Items -->

        </li><!-- End Notification Nav -->
        <%}
else
{
%>
<li class="nav-item dropdown">

          <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
            <i class="bi bi-bell"></i>
            <span class="badge bg-primary badge-number">0</span>
          </a><!-- End Notification Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
             
                  
            <li class="dropdown-header">
                You have no new notifications
             
            </li>
                 </ul><!-- End Notification Dropdown Items -->

        </li><!-- End Notification Nav -->
<%
}}
catch(SQLException e)
{
session.setAttribute("info", e.toString());
}
%>
        <li class="nav-item dropdown pe-3">

          
          <%
              try{
                  rsuser.close();
   rsuser=stuser.executeQuery("select * from userstb where userid='"+session.getAttribute("userCode")+"'");
    rsuser.last();
    if(rsuser.getRow()==1)
    {
%>
<a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="<% out.println(rsuser.getString("imgurl")); %>" alt="Profile" class="rounded-circle">
            <span class="d-none d-md-block dropdown-toggle ps-2"><% out.println(rsuser.getString("name")+" "+rsuser.getString("surname")); %></span>
          </a><!-- End Profile Iamge Icon -->
<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
                <h6><% out.println(rsuser.getString("name")+" "+rsuser.getString("surname")); %></h6>
              <span><% out.println(rsuser.getString("function")); %></span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

           
            <li>
              <hr class="dropdown-divider">
            </li>
 <li>
              <a class="dropdown-item d-flex align-items-center" href=logout.jsp>
                <i class="bi bi-box-arrow-right"></i>
                <span>Logout</span>
              </a>
            </li>

          </ul>

          <!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" href="dashboard.jsp">
          <!--<i class="bi bi-grid"></i>-->
          <span>My tasks</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-menu-button-wide"></i><span>Control</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="components-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
            <%
                if(!rsuser.getString("function").equals("Teacher"))
                {
                %>
          <li>
            <a href="edituser.jsp">
              <i class="bi bi-circle"></i><span>Users</span>
            </a>
          </li>
          <li>
            <a href="editoption.jsp">
              <i class="bi bi-circle"></i><span>Options</span>
            </a>
          </li>
          <li>
            <a href="editclass.jsp">
              <i class="bi bi-circle"></i><span>Classes</span>
            </a>
          </li>
          <li>
            <a href="editcourse.jsp">
              <i class="bi bi-circle"></i><span>Course</span>
            </a>
          </li>
          <li>
              <%
                  }
%>
            <a href="editclassdiary.jsp">
              <i class="bi bi-circle"></i><span>Class diary</span>
            </a>
          </li>
          </ul>
      </li><!-- End Components Nav -->

      <!-- End Forms Nav -->
   <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-bar-chart"></i><span>Reports</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="charts-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
            <%
                if(!session.getAttribute("userFunction").equals("Teacher"))
                {
                %>
          <li>
            <a href="reportusers.jsp">
              <i class="bi bi-circle"></i><span>Users</span>
            </a>
          </li>
          <li>
             <a href="reportcourses.jsp">
              <i class="bi bi-circle"></i><span>Courses</span>
            </a>
          </li><%
              }
%>
           
           <li>
             <a href="reportdiaries.jsp">
              <i class="bi bi-circle"></i><span>Class diaries</span>
            </a>
          </li>
        </ul>
      </li><!-- End Charts Nav -->
    </ul>
  </aside><!-- End Sidebar-->
  <%
     
    }
}
catch(Exception e)
{
session.setAttribute("info", e.toString());
}
              %>