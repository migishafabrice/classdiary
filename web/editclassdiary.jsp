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
Statement st=null;
ResultSet rs=null;
String msg;
%>
<%
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
if(request.getParameter("seditdiary")!=null && request.getParameter("seditdiary")!="")
{
try
{
 PreparedStatement pt=con.prepareStatement("update `diariestb` set  `diarydate`=?, `optionid`=?, `classid`=?, `courseid`=?, `matter`=?, "
        + "`topic`=?, `application`=?, `homework`=?,`observation`=?,`status`=? where diaryid=? and period=?");
String [] periods=request.getParameterValues("dperiod");
String [] options=request.getParameterValues("doption");
String [] classes=request.getParameterValues("dclass");
String [] rooms=request.getParameterValues("droom");
String [] courses=request.getParameterValues("dcourse");
String [] matters=request.getParameterValues("dmatter");
String [] topic=request.getParameterValues("dtopic");
String [] apps=request.getParameterValues("dapp");
String [] obs=request.getParameterValues("dobs");

if(periods.length>1)
{
for(int a=0;a<periods.length;a++)
{
pt.setString(1,request.getParameter("ddate"));
pt.setString(2,options[a]);
pt.setString(3, classes[a]+"_"+rooms[a]);
pt.setString(4, courses[a]);
pt.setString(5, matters[a]);
pt.setString(6, topic[a]);
pt.setString(7,apps[a]);
pt.setString(8,request.getParameter("dhome").toString());
pt.setString(9, obs[a]); 
pt.setString(10,request.getParameter("dstatus"));
pt.setString(11,request.getParameter("dthisdiary").toString());
pt.setString(12,periods[a]);
pt.execute();
}
}
msg="<font color='green'>Class diary edited successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("editclassdiary.jsp");   
return;
}
catch(Exception e)
{
  session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
  response.sendRedirect("editclassdiary.jsp");
  return;
}
}
    %>
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
      <h1>Manage class diaries</h1>
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
              <h5 class="card-title">List of class diaries</h5>
              <div class="col-lg-12">
                  <div class="col mb-3">
                      <a href="classdiary.jsp"><button class="btn btn-primary">Add new class diary</button></a>
                  </div>
              </div>
              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Surname</th>
                    <th scope="col">Class diary date</th>
                    <th scope="col">Submitted on</th>
                    <th scope="col">Status</th>
                    <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
<%
    try
    {
st=con.createStatement();
rs=st.executeQuery("select  distinct diaryid,diarydate,registrar,regdate,status from diariestb where registrar='"+session.getAttribute("userCode")+"'order by diarydate asc"); 
int n=1;
if(rs.first())
{
Statement gst=con.createStatement();
rs.beforeFirst();
ResultSet grs=null;
    while(rs.next())
    {
        grs=gst.executeQuery("select * from userstb where userid='"+rs.getString("registrar")+"'");
       grs.last();      
%>
<tr><td><%= n %></td><td><% out.println(grs.getString("name")); %></td><td><% out.println(grs.getString("surname")); %></td>
    <td><% out.println(rs.getString("diarydate")); %></td><td><% out.println(rs.getString("regdate")); %></td><td><% out.println(rs.getString("status")); %></td>
    <td><form action="editclassdiary.jsp" method="POST"><input type="hidden" name="thisdiary" value="<%= rs.getString("diaryid") %>"/>
            <span class="badge bg-success"> <input type="submit" name="editdiary" class="btn btn" value="Edit"/></span>
            <!--<span class="badge bg-danger"><input type="submit" name="dropdiary" class="btn btn" value="Drop"/></span>-->
        </form></td></tr>
<%
   // grs.close();
    }
n++;  
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
              <%
                        
                  try
                  {
                   if(request.getParameter("editdiary")!=null && request.getParameter("editdiary")!="" )  
                   {
                     String diary=request.getParameter("thisdiary").toString(); 
                  %>
                   <%
                      Statement dst=con.createStatement();
                      ResultSet drs=dst.executeQuery("select * from diariestb where diaryid='"+diary+"' order by period asc");
                      if(drs.first())
                      {
                       %>
                  <form action="editclassdiary.jsp" method="POST">
                      <input type="hidden" name="dthisdiary" value="<%= diary %>"/>
                      
                  
                  <h5 class="card-title">Edit class diary schedule</h5>
               <div class="row mb-4">
                  <label for="inputText" class="col-sm-1 col-form-label">Date</label>
                  <div class="col-sm-4">
                      <input type="date" class="form-control" name="ddate" value="<%= drs.getString("diarydate")%>" <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                          readonly=""
                              <%}%> />
                      
                  
                </div>
               </div>
                      <div class="row mb-4">
                  <label for="inputText" class="col-sm-1 col-form-label">Status</label>
                  <div class="col-sm-4">
                      <input type="text" class="form-control" size="1" value="<%= drs.getString("status")%>" readonly="" name="dstatus"/>
                       </div>
               </div>
                <table class="table table-striped">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Option</th>
                    <th scope="col">Class</th>
                    <th scope="col">Course</th>
                    <th scope="col">Matter</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Application</th>
                    <th scope="col">Observation</th>
                    
                  </tr>
                </thead>
                <tbody>
                    <%
                        drs.beforeFirst();
                          while(drs.next())
                          {   
                               String opt="";                             
                              String [] cl=drs.getString("classid").split("_");
                        %>
                   <tr>
                       <td><input type="text" class="form-control" size="1" value="<%= drs.getString("period")%>" readonly="" id="dperiod" name="dperiod"/></td>
                       <td><select class="form-select" onchange="changeClass(this.value);" id="doption" name="doption"><option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> >-----Choose option-----</option>
                             <%
    try{
st=con.createStatement();
rs=st.executeQuery("select * from optionstb order by optionname asc"); 
if(rs.first())
{
    rs.beforeFirst();
    while(rs.next())
    {
        if(rs.getString("optionid").equals(drs.getString("optionid")))
        {
            opt=drs.getString("optionid");
         %>
         <option value='<%= rs.getString("optionid") %>' selected=""><%= rs.getString("optionname") %></option>
         <%   
        }
else
{
 %>
         <option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> value='<%= rs.getString("optionid") %>'><%= rs.getString("optionname") %></option>
<%   
}
}

    }
}
catch(Exception e)
       {
session.setAttribute("info","Connection failed");
       }
                       %></select></td>
                       <td><select class="col-md-6" id="dclass" onchange="changeCourse(this.value);" name="dclass"> 
<option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> >-----Choose class-----</option>
                               <%
    try{
Statement cst=con.createStatement();
ResultSet crs=cst.executeQuery("select * from classestb order by classname asc"); 
if(crs.first())
{
    crs.beforeFirst();
    while(crs.next())
    {
        if(crs.getString("classid").equals(cl[0]))
        {
         %>
         <option value='<%= crs.getString("classid") %>' selected=""><%=crs.getString("classname") %></option>
<%   
        }
else
{
 %>
         <option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> value='<%= crs.getString("classid") %>'><%= crs.getString("classname") %></option>
<%   
}
}

    }
}
catch(Exception e)
       {
session.setAttribute("info","Connection failed");
       }
                       %></select><select class="col-md-6" id="droom" name="droom">
                           <option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> >-----Choose room-----</option>
                           <% 
                               if("None".equals(cl[1]))
                           {%>
                           <option value="None" selected="">None</option>   
                                   <% }
else
{
%>
<option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> value="None">None</option>
<%
}
for(char a='A';a<='F';a++)
{
                                   %>
                           
                                   <option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> value="<%=a%>"><%=a%></option>
                           <%}%>
                       </select></td>
                                   <td><select class="form-select" id="dcourse" name="dcourse">
                                           <option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> >-----Choose course-----</option>
                                           <%
try
{
 Statement mst=con.createStatement();
 ResultSet mrs=mst.executeQuery("select * from coursestb where optionid like'%"+opt+"%' and classid='"+cl[0]+"'");
 if(mrs.first())
 {
     mrs.beforeFirst();;
     while(mrs.next())
     {
         if(mrs.getString("coursecode").equals(drs.getString(("courseid"))))
         {
          %>
          <option selected="" value="<%= mrs.getString("coursecode") %>"> <%= mrs.getString("coursename") %></option>
          <%
         }
else
{
     %>
     <option  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           disabled=""
                              <%}%> value="<%= mrs.getString("coursecode") %>"> <%= mrs.getString("coursename") %></option>
     <%
 }
}
}        
}
catch(Exception e)
{
    session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
    response.sendRedirect("dashboard.jsp");
}
                                           %>
                               </select></td>
                       <td><textarea class="form-control"  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           readonly=""
                              <%}%>  id="dmatter" name="dmatter" ><%= drs.getString("matter") %></textarea></td>
                       <td><textarea class="form-control"   <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           readonly=""
                              <%}%> id="dtopic" name="dtopic"><%= drs.getString("topic") %></textarea></td>
                    <td><textarea class="form-control"  <% if(drs.getString("status").equals("Approved"))
                       {
                          %>                    
                           readonly=""
                              <%}%> id="dapp" name="dapp"><%= drs.getString("application") %></textarea></td>
                    <td><textarea class="form-control" id="dobs" name="dobs"><%= drs.getString("observation") %></textarea></td>
                    
                  </tr>
                  <%;}
drs.last();
%>

       </tbody>
                  </table>
<div class='row mb-3'><label class='col-sm-2 col-form-label'><b>Homework</b></label><textarea name='dhome' class='form-control' id='ehome'><%= drs.getString("homework") %></textarea></div>
<input type="submit" name="seditdiary" class="btn btn-primary"  value="Save changes"/>
                  </form>
                   <%
                       }
                   }
                  }
                  catch(Exception e)
                  {
                      session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                  }
                  %>
            </div>
          </div>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

   <jsp:include page="footer.jsp"/>