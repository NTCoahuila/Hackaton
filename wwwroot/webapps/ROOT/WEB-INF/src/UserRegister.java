import="java.sql.*"
import="java.util.*"

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
	firstline=",";
	}
        out.print("]}"); 
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 

