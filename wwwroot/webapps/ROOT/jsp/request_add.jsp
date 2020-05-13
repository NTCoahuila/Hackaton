­<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String Area_no = "";
String Xlat = "";
String Ylng = "";
String SQLQuery="";
String userid = "-1" ;
try {
	userid = session.getAttribute("userid").toString() ;
} catch (Exception e) {
	userid = "nouser";
}

try {

Area_no = request.getParameter("areano");
Xlat = request.getParameter("xlat");
Ylng = request.getParameter("ylng");
SQLQuery="insert into ntcoahulia_impacted_area  (xlat, ylng,user_no) values ('" + Xlat + "', '"+ Ylng +"','"+ userid +"')"; 

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