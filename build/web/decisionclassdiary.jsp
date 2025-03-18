<%@page import="com.mysql.jdbc.StringUtils"%>
<%
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
%>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%   
    Properties properties = new Properties();
    String msg;
    try
       {
           if(!request.getParameter("ddecision").equals("Choose decision"))
           {
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);
int n;
Statement st=con.createStatement();
PreparedStatement pt;
 SimpleDateFormat dte;
 dte=new SimpleDateFormat("dd-MM-yyyy");
Date dt=new Date();
if(request.getParameter("submit")!=null)
{
  ResultSet rs=st.executeQuery("select * from diariestb where diaryid='"+request.getParameter("todiary")+"'");
pt=con.prepareStatement("update diariestb set status=?,comment=?,score=?,"
        + "approvedby=?,decisiondate=? where diaryid=?");
if(rs.last())
{
if(StringUtils.isNullOrEmpty(rs.getString("status")) || rs.getString("status").equals("Pending"))
        {
pt.setString(1,request.getParameter("ddecision").toString());
        }
else
{
  pt.setString(1,rs.getString("status")+";"+request.getParameter("ddecision"));  
}
if(StringUtils.isNullOrEmpty(rs.getString("comment")))
        {
pt.setString(2,request.getParameter("dcomment").toString());
        }
else
{
  pt.setString(2,rs.getString("comment")+";"+request.getParameter("dcomment"));  
}

if(StringUtils.isNullOrEmpty(rs.getString("score")))
        {
if(request.getParameter("ddecision").equals("Approved"))
{
pt.setString(3,"100%");
}
if(request.getParameter("ddecision").equals("Review"))
{
pt.setString(3,"75%");
}
        }
else
{
 pt.setString(3,rs.getString("score"));   
}
pt.setString(4,session.getAttribute("userCode").toString());
pt.setString(5, dte.format(dt));
pt.setString(6, request.getParameter("todiary").toString());  
pt.execute();
rs.close();
rs=st.executeQuery("select * from userstb,diariestb where userstb.userid=diariestb.registrar and diaryid='"+request.getParameter("todiary").toString()+"' order by period asc limit 1");
String res="";
if(rs.first())
{
    String sms="Dear "+ rs.getString("name")+" "+rs.getString("surname")+
        ";<br/> Your class diary was "+request.getParameter("ddecision").toString()+" on e-class diary MIS"
        
        + "<br/>Regards;<br/><br/>E-ClASS DIARY automatic email.";
res=sendMail(rs.getString("email"),"Class diary status changed" ,sms);
}
msg="<font color='blue'>Class diary "+request.getParameter("ddecision").toString()+" successfully<br/>"+res+"</font>";
session.setAttribute("info", msg);
response.sendRedirect("pendingclassdiary.jsp");
return;
}
else
{
 session.setAttribute("info","<font color='red'>Class diary not found</font>");
            response.sendRedirect("pendingclassdiary.jsp");
            return;    
}
}
           }
           else
           {
            session.setAttribute("info","<font color='red'>Choose the decision</font>");
            response.sendRedirect("pendingclassdiary.jsp");
            return;
           }
}
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("pendingclassdiary.jsp");
            return;
       }
%>
<%!
    //Creating a result for getting status that messsage is delivered or not!
public String sendMail(String receiver,String title,String sms)
{
    String result;

    // Get recipient's email-ID, message & subject-line from index.html page

    final String to = receiver;
    final String subject = title;
    final String messg = sms;
   // Sender's email ID and password needs to be mentioned

    final String from = "eclassdiaryweapp@gmail.com";

    final String pass = "pnzlfhssllwoqhpd";
  // Defining the gmail host

    String host = "smtp.gmail.com";
  // Creating Properties object

    Properties props = new Properties();
    // Defining properties

    props.put("mail.smtp.host", host);

    props.put("mail.transport.protocol", "smtp");

    props.put("mail.smtp.auth", "true");

    props.put("mail.smtp.starttls.enable", "true");

    props.put("mail.user", from);

    props.put("mail.password", pass);

    props.put("mail.port", "465");
   // Authorized the Session object.

    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

        @Override

        protected PasswordAuthentication getPasswordAuthentication() {

            return new PasswordAuthentication(from, pass);

        }
    });
    try {

        // Create a default MimeMessage object.

        MimeMessage message = new MimeMessage(mailSession);

        // Set From: header field of the header.

        message.setFrom(new InternetAddress(from));

        // Set To: header field of the header.

        message.addRecipient(Message.RecipientType.TO,

                new InternetAddress(to));

        // Set Subject: header field

        message.setSubject(subject);

        // Now set the actual message

        message.setContent(messg,"text/html");

        // Send message

        Transport.send(message);

        result = "Email sent successfully";

    } catch (MessagingException mex) {

        mex.printStackTrace();

        result = "Email not sent";

    }
return result;
}
%>