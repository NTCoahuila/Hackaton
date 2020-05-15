­<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String SQLQuery="";

try {

String Reqno = request.getParameter("request_no");
String Reqtype = request.getParameter("request_type");
String Reqdesc = request.getParameter("request_entered");
String Reqname = request.getParameter("requester_name");
String Reqtelphone = request.getParameter("requester_telephone");
String Xlat = request.getParameter("xlat");
String Ylng = request.getParameter("ylng");
SQLQuery="update ntcoahulia_request set request_type ='"+ Reqtype +"', request_desc ='"+ Reqdesc +"' , requester_name ='"+ Reqname +"', requester_telephone ='"+ Reqtelphone +"', xlat = '" + Xlat + "', ylng ='"+ Ylng +"' , create_ts = now() where request_no = " + Reqno; 

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
      // out.print("success" + SQLQuery); 

response.sendRedirect("https://ntcoahuila.azurewebsites.net/myrequest.jsp");
%>