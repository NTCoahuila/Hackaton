<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

try {
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection con=DriverManager.getConnection(dburl,dbusername,dbpassword);
	PreparedStatement pstmt=null;
	pstmt=con.prepareStatement("SELECT * FROM ntcoahulia_hospital");            
	ResultSet rs=pstmt.executeQuery();
		
        out.print("{\"records\":[");
        String firstline=""; 
	while (rs.next()) {
	out.print(firstline); 
%>
{	
"hid" : "<%= rs.getInt("hid") %>",
"hname" : "<%= rs.getString("hname") %>" ,
"hcity" : "<%= rs.getString("hcity") %>",
"hstreet1" : "<%= rs.getString("hstreet1") %>",
"hstreet2" : "<%= rs.getString("hstreet2") %>" ,
"hnumber" : "<%= rs.getString("hnumber") %>",
"hpostalcode" : "<%= rs.getString("hpostalcode") %>",
"hmaintelephone" : "<%= rs.getString("hmaintelephone") %>" ,
"hCOVIDflg" : "<%= rs.getString("hCOVIDflg") %>",
"hlatitude" : "<%= rs.getString("hlatitude") %>",
"hlongitude" : "<%= rs.getString("hlongitude") %>" ,
"havaliablebeds" : "<%= rs.getInt("havaliablebeds") %>",
"hoccupiedbeds" : "<%= rs.getInt("hoccupiedbeds") %>"
}
<%
	firstline=",";
	}
        out.print("]}"); 
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 

%>
