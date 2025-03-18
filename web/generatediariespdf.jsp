<%@page import="com.lowagie.text.Font"%>
<%@page import="com.lowagie.text.pdf.PdfDictionary.*"%>
<%@page import="java.awt.Color"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*,com.lowagie.text.*"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@ page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
    %> 
<%!
     public static PdfPCell getNormalCell(String string, String language, float size)
            throws DocumentException, IOException {
        if(string != null && "".equals(string)){
            return new PdfPCell();
        }
        Font f  = getFontForThisLanguage(language);
        if(size < 0) {
            f.setColor(Color.RED);
            size = -size;
        }
        f.setSize(size);
        PdfPCell cell = new PdfPCell(new Phrase(string, f));
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        return cell;
    }
 public static Font getFontForThisLanguage(String language) {
        if ("czech".equals(language)) {
            return FontFactory.getFont(language, "Cp1250", true);
        }
        if ("greek".equals(language)) {
            return FontFactory.getFont(language, "Cp1253", true);
        }
        return FontFactory.getFont(language, null, true);
    }
    %>
<%
Properties properties = new Properties();
Statement st;
ResultSet rs;
String msg;
int n=0;
int teacher=0;
int dos=0;
int head=0;
int male=0;
int female=0;
int active=0;
int nonActive=0;
%>
<%
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/e-classdiarydb",properties);

                        try
                        {
                               Statement stcourse=con.createStatement();
                               ResultSet rscourse=stcourse.executeQuery("select * from diariestb where diaryid='"+request.getParameter("thisdiary")+"' order by period asc");
                               if(rscourse.first())
                               {
                                   
try{
response.setContentType("application/pdf");
Document document = new Document();
document.setPageSize(PageSize.A4.rotate());
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter.getInstance(document, buffer); 
document.open();
Font subfont = new Font(Font.TIMES_ROMAN, 11,Font.BOLD|Font.UNDERLINE);
document.addTitle("Class diaries report");
document.add(new Paragraph("E_CLASSDIARY SYSTEM",new Font(Font.TIMES_ROMAN,12,Font.BOLD|Font.UNDERLINE)));
SimpleDateFormat dte=new SimpleDateFormat("dd-MM-YYYY");
Date dt=new Date();
document.add(new Paragraph("CLASS DIARY INFORMATION",new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
document.add(new Paragraph("Date generated on:"+dte.format(dt),new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
document.add(new Paragraph("Date registered on:"+rscourse.getString("regdate"),new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
document.add(new Paragraph("Date scheduled on:"+rscourse.getString("diarydate"),new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
Statement rst=con.createStatement();
ResultSet rrs=rst.executeQuery("select * from userstb where userid='"+rscourse.getString("registrar")+"'");
                             rrs.last();
                          if(rrs.getRow()==1)
                          {
                              rrs.first();
document.add(new Paragraph("Names:"+rrs.getString("name")+" "+rrs.getString("surname"),new Font(Font.TIMES_ROMAN, 11,Font.BOLD)));
                          }
//document.add(new Paragraph("\n"));
document.add(new Paragraph("\n"));
PdfPTable table = new PdfPTable(10);
table.setWidthPercentage(100);
table.addCell(getNormalCell("#","czech",11));
table.addCell(getNormalCell("Option","czech",11));
table.addCell(getNormalCell("Class","czech",11));
table.addCell(getNormalCell("Course","czech",11));
table.addCell(getNormalCell("Topic","czech",11));
table.addCell(getNormalCell("Sub-Topic","czech",11));
table.addCell(getNormalCell("Application","czech",11));
table.addCell(getNormalCell("Status","czech",11));
table.addCell(getNormalCell("Score","czech",11));
table.addCell(getNormalCell("Observation","czech",10));
                                   rscourse.beforeFirst();
                                   while(rscourse.next())
                                   {
                                 n++;
                                   
                                   Statement stclass=con.createStatement();
                                   Statement stopt=con.createStatement();
                                   Statement stsub=con.createStatement();
                                   ResultSet rsclass=stclass.executeQuery("select * from optionstb where optionid like'%"+rscourse.getString("optionid")+"%'");
                                   String [] clas=rscourse.getString("classid").split("_");
                                   ResultSet rsopt=stopt.executeQuery("select * from classestb where classid='"+clas[0]+"'");
                                   ResultSet rssub=stsub.executeQuery("select * from coursestb where coursecode='"+rscourse.getString("courseid")+"'");
                                  rsclass.first();
                                  rsopt.first(); 
                                   rssub.first();
table.addCell(getNormalCell(rscourse.getString("period"),"greek",10));
table.addCell(getNormalCell(rsclass.getString("optionname"),"greek",10));
table.addCell(getNormalCell(rsopt.getString("classname"),"greek",10));
table.addCell(getNormalCell(rssub.getString("coursename"),"greek",10));
table.addCell(getNormalCell(rscourse.getString("matter"),"greek",10));
table.addCell(getNormalCell(rscourse.getString("topic"),"greek",10));
table.addCell(getNormalCell(rscourse.getString("application"),"greek",10));
table.addCell(getNormalCell(rscourse.getString("status"),"greek",10));
table.addCell(getNormalCell(rscourse.getString("score"),"greek",10));
table.addCell(getNormalCell(rscourse.getString("observation"),"greek",10));
                            }
document.add(table);    
rscourse.last();
document.add(new Paragraph("Homework:",new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
document.add(new Paragraph(rscourse.getString("homework"),new Font(Font.TIMES_ROMAN,11,Font.COURIER)));
document.add(new Paragraph("\n"));
document.add(new Paragraph("\n"));
rrs.close();
rrs=rst.executeQuery("select * from userstb where userid='"+rscourse.getString("approvedby")+"'");
document.add(new Paragraph("Checked by:",new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
rrs.last();
                          if(rrs.getRow()==1)
                          {
                              rrs.first();

document.add(new Paragraph(rrs.getString("name")+" "+rrs.getString("surname"),new Font(Font.TIMES_ROMAN,11,Font.COURIER)));;
document.add(new Paragraph(rrs.getString("function"),new Font(Font.TIMES_ROMAN,11,Font.COURIER)));;
                          }
document.add(new Paragraph("\n"));
document.add(new Paragraph("Comment:",new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
document.add(new Paragraph(rscourse.getString("comment"),new Font(Font.TIMES_ROMAN,11,Font.COURIER)));
document.add(new Paragraph("\n"));
document.add(new Paragraph("Date:",new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
document.add(new Paragraph(rscourse.getString("decisiondate"),new Font(Font.TIMES_ROMAN,11,Font.COURIER)));
document.close(); 
DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int i = 0; i < bytes.length; i++)
{
dataOutput.writeByte(bytes[i]);
}
response.getOutputStream().flush();
response.getOutputStream().close();
}
catch(DocumentException e)
{
e.printStackTrace();
}
                               }
                              
                              
                          }
                           catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("reportdiaries.jsp");
                        return;
                        }
%>
