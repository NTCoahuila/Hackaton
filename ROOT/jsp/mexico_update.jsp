­<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String Area_no = "";
String Xlat = "";
String Ylng = "";
String SQLQuery="";

try {

String Sno = request.getParameter("sname");
String Scolor = request.getParameter("scolor");
String Sconfirm = request.getParameter("sconfirm");
String Sactive = request.getParameter("sactive");
String Srecovered = request.getParameter("srecovered");
String Sdeceased = request.getParameter("sdeceased");
String Stest = request.getParameter("stest");


SQLQuery="update ntcoahuila_mexico set state_color = '"+ Scolor +"', state_confirmed_case ='"+ Sconfirm +"' , state_active_case = '"+ Sactive +"', state_recovered_case = '"+ Srecovered +"', state_deceased_case = '"+ Sdeceased +"', state_test_count ='"+ Stest +"' where sno = " + Sno; 

	Class.forName("com.mysql.jdbc.Driver"); 
	Connection con=DriverManager.getConnection(dburl,dbusername,dbpassword);
	PreparedStatement pstmt=null;
	pstmt=con.prepareStatement(SQLQuery);            
	pstmt.executeUpdate();	
        con.close(); 
        out.print("success"); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
       //out.print("success" + SQLQuery); 

response.sendRedirect("https://ntcoahuila.azurewebsites.net/mexico.jsp");
%>