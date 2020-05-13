­<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String SQLQuery="";
String userid = "-1" ;
try {
	userid = session.getAttribute("userid").toString() ;
} catch (Exception e) {
	userid = "nouser";
}

try {

String Hname = request.getParameter("hospital_name");
String Hstate = "";
String Hcity = request.getParameter("hcity");
String Hstreet1 = request.getParameter("hstreet1");
String Hstreet2 = request.getParameter("hstreet1");
String Hnumber = "";
String Hpostalcode = "";
String Htelephone = request.getParameter("htelephone");
String HCOVIDflg = "";
String Hlatitude = request.getParameter("xlat");
String Hlongitude = request.getParameter("ylng");
String Habeds = request.getParameter("habeds");
String Hoccupiedbeds = request.getParameter("hobeds");

SQLQuery="insert into ntcoahulia_hospital (hospital_name, hstate, hcity, hstreet1, hstreet2, hnumber, hpostalcode, htelephone, hCOVIDflg, hlatitude, hlongitude, habeds, hoccupiedbeds,user_no) values ('"+Hname+"', '"+Hstate +"', '"+Hcity +"', '"+Hstreet1 +"' , '"+Hstreet2 +"' ,'"+ Hnumber  +"' ,'"+ Hpostalcode+"', '"+ Htelephone +"' ,'"+ HCOVIDflg +"' ,'"+ Hlatitude +"' ,'"+ Hlongitude +"' ,'"+ Habeds +"' ,'"+ Hoccupiedbeds +"','"+ userid +"')"; 

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

response.sendRedirect("https://ntcoahuila.azurewebsites.net/myhospital.jsp");
%>