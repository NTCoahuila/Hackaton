<%@page import="java.sql.*"%><%@page import="java.util.*"%><%@page import="java.security.MessageDigest"%><%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

String Username = "";
String Password = "";
String SQLQuery = "";

try {

Username = request.getParameter("username");
Password = request.getParameter("password");
} catch(Exception e) {
      out.print(e.toString()); 
} 

MessageDigest alg = MessageDigest.getInstance("MD5");
alg.reset(); 
alg.update(Password.getBytes());
byte[] digest = alg.digest();
StringBuffer hashedpasswd = new StringBuffer();
String hx;
for (int i=0;i<digest.length;i++){
    hx =  Integer.toHexString(0xFF & digest[i]);
    //0x03 is equal to 0x3, but we need 0x03 for our md5sum
    if(hx.length() == 1){hx = "0" + hx;}
    hashedpasswd.append(hx);
}

SQLQuery="Select user_id from ntcoahulia_user where username = '" + Username + "' and password = '" + hashedpasswd.toString() + "'"; 


try {
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection con=DriverManager.getConnection(dburl,dbusername,dbpassword);
	PreparedStatement pstmt=null;
	pstmt=con.prepareStatement(SQLQuery);            
	ResultSet rs=pstmt.executeQuery();
	if (rs.next()) {
	      session.setAttribute("userid",rs.getInt("user_id"));
	      session.setAttribute("username",Username);
	      out.print("success"); 
	} else {
	      out.print("failed"); 
	}
	
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 

%>