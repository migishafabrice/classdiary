<%
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
    %>
<%-- 
    Document   : vlogin
    Created on : Mar 6, 2022, 11:40:45 AM
    Author     : User
--%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%!
	public String generateRandomPassword(int len) {
		String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijk"
          +"lmnopqrstuvwxyz!@#$%&";
		Random rnd = new Random();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++)
			sb.append(chars.charAt(rnd.nextInt(chars.length())));
		return sb.toString();
	}

%>
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
int n;
Statement st=con.createStatement();
ResultSet rs;
String code="",fileName="",fieldName="",fuser="",luser="",sexuser="",muser="",tuser="",functuser="",url="";
 SimpleDateFormat dte;

                dte=new SimpleDateFormat("dd");
                Date dt=new Date();
rs=st.executeQuery("select * from userstb order by id desc limit 1");
    if(rs.first())
    {
code=(Integer.valueOf(rs.getString("id"))+1)+"-USR-"+dte.format(dt);
         dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);
    }
    else
    {
code="1-USR-"+dte.format(dt);
dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);  
    }
 File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
String s = request.getRealPath("/");
   String filePath = s+"images\\";
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File(filePath));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
      try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
         while ( i.hasNext () ) 
         {
             
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField ())  {
                             fieldName = fi.getFieldName();
                fileName = fi.getName();
                String ext;
    int lastIndexOf = fileName.lastIndexOf(".");
    if (lastIndexOf == -1) 
    {
     ext=""; // empty extension
    }
    else
    {
    ext=fileName.substring(lastIndexOf);
    }
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                fileName=code+ext;
                file = new File( filePath + fileName) ;
                fi.write( file ) ;
               // out.println("Uploaded Filename: " + filePath + fileName + "<br>");
               url="images\\"+fileName;
               //url=url.replace("\\", "/");
            }
            else
            {
           fieldName = fi.getFieldName();
           
                fileName = fi.getName();
                if(fieldName.equals("fuser"))
                {
                 fuser=fi.getString();
                }
                if(fieldName.equals("luser"))
                {
                 luser=fi.getString();
                }
                if(fieldName.equals("sexuser"))
                {
                 sexuser=fi.getString();
                }
                if(fieldName.equals("muser"))
                {
                 muser=fi.getString();
                }
                if(fieldName.equals("tuser"))
                {
                 tuser=fi.getString();
                }
                if(fieldName.equals("functuser"))
                {
                 functuser=fi.getString();
                }
            }
            
         }
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }

    if(!functuser.equals("Teacher"))
    {
    rs.close();
    rs=st.executeQuery("select * from userstb where function='"+functuser+"' and active='YES'");
    if(rs.first())
    {
        session.setAttribute("info","<font color='red'>Only one "+functuser+" can be active, deactivate the existing before proceeding.</font>");
        response.sendRedirect("edituser.jsp");
        return;
    }
    }
    String pass=generateRandomPassword(8);
PreparedStatement pt=con.prepareStatement("INSERT INTO `userstb`(`id`, `userid`, `name`, `surname`,`sex`,`email`, `telephone`, `function`, "
        + "`username`, `password`, `reset`, `active`, `registrar`,`date`, `imgurl`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
pt.setString(1,null);
pt.setString(2, code);
pt.setString(3, fuser);
pt.setString(4, luser);
pt.setString(5, sexuser);
pt.setString(6, muser);
pt.setString(7, tuser);
pt.setString(8, functuser);
pt.setString(9, muser);
pt.setString(10, pass);
pt.setString(11, "NO");
pt.setString(12, "YES");
pt.setString(13, String.valueOf(session.getAttribute("userCode")));
dte=new SimpleDateFormat("dd-MM-yyyy");
pt.setString(14, dte.format(dt));
pt.setString(15, url);  
pt.execute();
String receiver=muser;
String title="E-Classdiary MIS says congratulations to you "+functuser+" "+ fuser+" "+luser;
String sms="Dear "+ fuser+" "+luser+
        ";<br/> You have been registered to e-class diary MIS as "+functuser+
        ".<br/>Username:"+muser+" or "+tuser+
        "<br/>Password:"+pass+"<br/>Before you start to navigate the system features, you have to change this above default password.<br/>"
        + "<br/>Regards;<br/><br/>E-ClASS DIARY automatic email.";
sendMail(receiver,title,sms);
msg="<font color='blue'>New staff registered successfully</font>";
session.setAttribute("info", msg);
response.sendRedirect("edituser.jsp");
}
catch(Exception e)
       {
session.setAttribute("info",e.toString());
response.sendRedirect("edituser.jsp");
return;
       }
%>
<%
  
%>
<%!
    //Creating a result for getting status that messsage is delivered or not!
public void sendMail(String receiver,String title,String sms)
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
}
%>