<%
    
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
    return;
}
    %>
<%-- 
    Document   : dashboard
    Created on : Mar 6, 2022, 12:26:23 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
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
Statement ust=con.createStatement();
ResultSet urs=null;
ResultSet rs=null;
int active=0;
int notActive=0;
  %>    
<!DOCTYPE html>
<jsp:include page="aside.jsp"/>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Dashboard</h1>
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

    <section class="section dashboard">
      <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">

            <!-- Sales Card -->
            
                  <%
                      if(!session.getAttribute("userFunction").toString().equals("Teacher"))
                      {
                          rs=st.executeQuery("select * from userstb where function<>'Administrator'");
                          if(rs.first())
                          {
                          rs.beforeFirst();
                          while(rs.next())
                          {
                              if(rs.getString("active").equals("YES"))
                              {
                                  active++;
                              }
                              else
                              {
                                  notActive++;
                              }
                          }
                          }
                         
                         
                          %>
                          
                          <div class="col-xxl-3 col-md-6">
              <div class="card info-card ">
                   <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#" onclick="">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Users <span>| All</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-people"></i>
                    </div>
                    <div class="ps-3">
                        <label>Activated:<%= active %></label></br>
                      <label>Deactivated:<%= notActive %></label>
                      

                    </div>
                  </div>
                </div>

              </div>
            </div><!-- End Sales Card -->
                          <%
                              rs.close();
                           }
                         active=0;
                         notActive=0;
                         rs=st.executeQuery("select * from optionstb");
                         if(rs.first())
                         {
                             rs.beforeFirst();
                             while(rs.next())
                             {
                             if(rs.getString("active").equals("YES"))
                              {
                                  active++;
                              }
                              else
                              {
                                  notActive++;
                              }
                             }
                         }
                  %>
                  <!-- Revenue Card -->
            <div class="col-xxl-3 col-md-6">
              <div class="card info-card ">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Options <span>| All</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="ri-book-mark-fill"></i>
                    </div>
                    <div class="ps-3">
                      <label>Activated:<%= active %></label>
                      <%
                    if(!session.getAttribute("userFunction").toString().equals("Teacher"))
                      {
                          %></br>
                      <label>Deactivated:<%= notActive %></label>
                      <%}%>
                      </div>
                  </div>
                </div>

              </div>
            </div><!-- End Revenue Card -->
            <%
                 active=0;
                         notActive=0;
                         rs=st.executeQuery("select * from classestb");
                         if(rs.first())
                         {
                             rs.beforeFirst();
                             while(rs.next())
                             {
                             if(rs.getString("active").equals("YES"))
                              {
                                  active++;
                              }
                              else
                              {
                                  notActive++;
                              }
                             }
                         }
                %>
                
            <!-- Customers Card -->
            <div class="col-xxl-3 col-xl-12">

              <div class="card info-card ">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Classes <span>| All</span></h5>
                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="ri-building-4-fill"></i>
                    </div>
                    <div class="ps-3">
                      <label>Activated:<%= active %></label>
                       <%
                    if(!session.getAttribute("userFunction").toString().equals("Teacher"))
                      {
                          %></br>
                      <label>Deactivated:<%= notActive %></label>
                      <%}%>
                      </div>
                  </div>

                </div>
              </div>

            </div><!-- End Customers Card -->
             <%
                 active=0;
                         notActive=0;
                      if(!session.getAttribute("userFunction").toString().equals("Teacher"))
                      {
                         rs=st.executeQuery("select distinct diaryid,status from diariestb");
                         
                      }
                      else
                      {
                         rs=st.executeQuery("select distinct diaryid,status from diariestb where registrar='"+session.getAttribute("userCode")+"'"); 
                      }
                         if(rs.first())
                         {
                             rs.beforeFirst();
                             while(rs.next())
                             {
                             if(rs.getString("status").equals("Approved"))
                              {
                                  active++;
                              }
                              else
                              {
                                  notActive++;
                              }
                             }
                         }
                         rs.close();
                %>
                <div class="col-xxl-3 col-xl-12">
              <div class="card info-card ">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Class diaries <span>| All</span></h5>
                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="ri-briefcase-4-fill"></i>
                    </div>
                    <div class="ps-3">
                      <label>Approved:<%= active %></label></br>
                      <label>Pending:<%= notActive %></label>
                      
                      </div>
                  </div>
                </div>
              </div>
            </div><!-- End Customers Card -->
            <!-- Reports -->
           <!-- End Reports -->
            <!-- Recent Sales -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">
                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Administration activities <span>| All</span></h5>
                  <table class="table table-borderless datatable">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">Names</th>
                        <th scope="col">Telephone</th>
                        <th scope="col">Approved class diaries</th>
                        <th scope="col">Review class diaries</th>
                        <th scope="col">Rejected class diaries</th>
                        <th scope="col">Total class diaries</th>
                      </tr>
                    </thead>
                    <tbody>
                        <%
                            rs.close();
                            
                            rs=st.executeQuery("select * from userstb where active='YES' and function<>'Administrator' and function<>'Teacher' order by name,surname asc");
                           
                            if(rs.first())
                            {
                            rs.beforeFirst();
                            int n=1;
                            while(rs.next())
                            {
                             int pe=0;
                            int ap=0;
                            int re=0;
                            int rej=0;
                            int tot=0;
                            Statement ost=con.createStatement();
                            ResultSet ors;
                            if(!session.getAttribute("userFunction").equals("Teacher"))
                            {
                            ors=ust.executeQuery("select distinct diaryid,status,approvedby from diariestb where approvedby='"+rs.getString("userid")+"'");
                            }
                            else
                            {
                             ors=ust.executeQuery("select distinct diaryid,status,registrar,approvedby from diariestb where approvedby='"+rs.getString("userid")+"'"
                                     + " and registrar='"+session.getAttribute("userCode")+"'");   
                            }
                            if(ors.first())  
                            {
                                ors.beforeFirst();;
                                while(ors.next())
                                {
                            if(ors.getString("status").equals("Approved"))
                             {
                                 ap++;
                             }
                               if(ors.getString("status").equals("Review"))
                             {
                                 re++;
                             }
                                if(ors.getString("status").equals("Rejected"))
                             {
                                 pe++;
                             }
                            }
                                tot=pe+ap+re+rej;
                            }
                         %>
                        <tr>
                        <th scope="row"><a href="#"><%= n%></a></th>
                        <td scope="row"><%= rs.getString("name")+" "+rs.getString("surname")%></td>
                        <td><%= rs.getString("telephone")%></td>
                        <td><%= ap%></td>
                        <td><%= re%></td>
                        <td><%= rej%></td>
                        <td><%= tot%></td>
                      </tr>
                      <% n++;
                     }
                         }%>
                       </tbody>
                  </table>
                 </div>
              </div>
            </div>
            <div class="col-12">
              <div class="card recent-sales overflow-auto">
                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">Teachers activities <span>| All</span></h5>
                  <table class="table table-borderless datatable">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">Names</th>
                        <th scope="col">Telephone</th>
                        <th scope="col">Pending class diaries</th>
                        <th scope="col">Approved class diaries</th>
                        <th scope="col">Review class diaries</th>
                        <th scope="col">Rejected class diaries</th>
                        <th scope="col">Total class diaries</th>
                      </tr>
                    </thead>
                    <tbody>
                        <%
                            rs.close();
                            if(!session.getAttribute("userFunction").equals("Teacher"))
                            {
                            rs=st.executeQuery("select * from userstb where active='YES' and function<>'Administrator' order by name,surname asc");
                            }
                            else
                            {
                            rs=st.executeQuery("select * from userstb where active='YES' and function<>'Administrator' and userid='"+session.getAttribute("userCode")+"'");  
                            }
                            if(rs.first())
                            {
                            rs.beforeFirst();
                            int n=1;
                            while(rs.next())
                            {
                             
                            int pe=0;
                            int ap=0;
                            int re=0;
                            int rej=0;
                            int tot=0;
                            Statement ost=con.createStatement();
                            ResultSet ors=ust.executeQuery("select distinct diaryid,status,registrar from diariestb where registrar='"+rs.getString("userid")+"'");
                            if(ors.first())  
                            {
                                ors.beforeFirst();;
                                while(ors.next())
                                {
                             if(ors.getString("status").equals("Pending"))
                             {
                                 pe++;
                             }
                              if(ors.getString("status").equals("Approved"))
                             {
                                 ap++;
                             }
                               if(ors.getString("status").equals("Review"))
                             {
                                 re++;
                             }
                                if(ors.getString("status").equals("Rejected"))
                             {
                                 pe++;
                             }
                            }
                                tot=pe+ap+re+rej;
                            }
                         %>
                        <tr>
                        <th scope="row"><a href="#"><%= n%></a></th>
                        <td scope="row"><%= rs.getString("name")+" "+rs.getString("surname")%></td>
                        <td><%= rs.getString("telephone")%></td>
                        <td><%= pe%></td>
                        <td><%= ap%></td>
                        <td><%= re%></td>
                        <td><%= rej%></td>
                        <td><%= tot%></td>
                      </tr>
                      <% n++;}
                         }%>
                       </tbody>
                  </table>
                 </div>
              </div>
            </div>           
                       
                       <!-- End Recent Sales -->
             <!-- Top Selling -->
            <!-- End Top Selling -->

          </div>
        </div><!-- End Left side columns -->

        <!-- Right side columns -->
        

      </div>
    </section>

  </main><!-- End #main -->
 <%}
    catch(Exception e)
    {
        session.setAttribute("info", e.toString());
    }
    %>
  <!-- ======= Footer ======= -->
  <jsp:include page="footer.jsp"/>