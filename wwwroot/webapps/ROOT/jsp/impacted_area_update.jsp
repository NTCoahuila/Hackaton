­<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String Area_no = "";
String Xlat = "";
String Ylng = "";
String SQLQuery="";

try {

Area_no = request.getParameter("areano");
Xlat = request.getParameter("xlat");
Ylng = request.getParameter("ylng");
SQLQuery="update ntcoahulia_impacted_area set xlat = '" + Xlat + "', ylng ='"+ Ylng +"' , create_ts = now() where area_no = " + Area_no; 

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
//       out.print("success" + SQLQuery); 

response.sendRedirect("https://ntcoahuila.azurewebsites.net/myimpactedarea.jsp");
%>