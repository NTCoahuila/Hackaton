­<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String SQLQuery="";

try {

String Reqno = request.getParameter("request_no");



	Class.forName("com.mysql.jdbc.Driver"); 
	Connection con=DriverManager.getConnection(dburl,dbusername,dbpassword);
	PreparedStatement pstmt=null;

SQLQuery="delete from ntcoahulia_request where request_no = " + Reqno; 
	pstmt=con.prepareStatement(SQLQuery);            
	pstmt.executeUpdate();	
        con.close(); 
        out.print("success"); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
      // out.print("success" + SQLQuery); 

response.sendRedirect("https://ntcoahuila.azurewebsites.net/myrequest.jsp");
%>