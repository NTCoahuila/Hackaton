­<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String Area_no = "";
String Xlat = "";
String Ylng = "";
String SQLQuery="";

try {

String Hno = request.getParameter("hospital_no");
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


SQLQuery="update ntcoahulia_hospital set hospital_name = '"+ Hname +"', hstate ='"+ Hstate +"' , hcity = '"+ Hcity+"', hstreet1 = '"+ Hstreet1 +"', hstreet2 = '"+ Hstreet2 +"', hnumber ='"+ Hnumber +"', hpostalcode ='"+ Hpostalcode +"' , htelephone ='"+ Htelephone +"', hCOVIDflg ='"+ HCOVIDflg +"', hlatitude ='"+  Hlatitude +"', hlongitude ='"+ Hlongitude +"', habeds ='"+ Habeds +"', hoccupiedbeds='"+ Hoccupiedbeds +"' , create_ts = now() where hid = " + Hno; 

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

response.sendRedirect("https://ntcoahuila.azurewebsites.net/myhospital.jsp");
%>