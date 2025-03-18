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
<jsp:include page="aside.jsp"/>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Staff registration</h1>
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
              <h5 class="card-title">Staff identification</h5>

              <!-- General Form Elements -->
              <form action="reg.jsp" method="POST" enctype="multipart/form-data">
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">First name</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="fuser"/>
                  </div>
                </div>
                  <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Last name</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" name="luser">
                  </div>
                </div>
                  <div class="row mb-3">
                  <label class="col-sm-2 col-form-label">Sex</label>
                  <div class="col-sm-10">
                      <select class="form-select" aria-label="Default select example" name="sexuser">
                          <option selected>-----Choose sex-----</option><option >Male</option><option>Female</option>
                      </select></div></div>
                <div class="row mb-3">
                  <label for="inputEmail" class="col-sm-2 col-form-label">Email</label>
                  <div class="col-sm-10">
                    <input type="email" class="form-control" name="muser">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="inputText" class="col-sm-2 col-form-label">Telephone</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="tuser">
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
                  <label for="inputText" class="col-sm-2 col-form-label">Photo</label>
                  <div class="col-sm-10">
                    <input type="file" class="form-control" name="tfile"/>
                  </div>
                </div>      
              

                <div class="row mb-3">
                  <label class="col-sm-2 col-form-label"></label>
                  <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Register staff</button>
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