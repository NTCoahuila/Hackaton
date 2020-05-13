<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

int impact_area_count=0;
int hospital_count=0;
int request_count=0;

try {
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection con=DriverManager.getConnection(dburl,dbusername,dbpassword);
	PreparedStatement pstmt1=null;
	PreparedStatement pstmt2=null;
	PreparedStatement pstmt3=null;
	pstmt1=con.prepareStatement("SELECT count(*) as COU FROM ntcoahulia_impacted_area");            
	pstmt2=con.prepareStatement("SELECT count(*) as COU FROM ntcoahulia_hospital");            
	pstmt3=con.prepareStatement("SELECT count(*) as COU FROM ntcoahulia_request");            
	ResultSet rs1=pstmt1.executeQuery();
	ResultSet rs2=pstmt2.executeQuery();
	ResultSet rs3=pstmt3.executeQuery();
		
	if (rs1.next()) {
		impact_area_count=rs1.getInt("COU");
	}

	if (rs2.next()) {
		hospital_count=rs2.getInt("COU");
	}

	if (rs3.next()) {
		request_count=rs3.getInt("COU");
	}
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
%>

<html>
<head>
<title>Covid Rescuer</title>
</head>
<%
String uname = "nouser" ;
try {
	uname = session.getAttribute("username").toString() ;
} catch (Exception e) {
	uname = "nouser";
}
%>

<body>
<table width=100% border = 1>
<tr>
<td>
<jsp:include page="header.jsp" />  
</td></tr>
<tr><td align=center colspan=2>
<br><br>
	<table cellpadding=30>
	<tr >
	<td><a href="mexico.jsp">Mexico - Statewise</a> <br> 32 states Covered 
		<br><a href="coahuila.jsp">Coahuila - 34 Cities</a>
	</td>
	<td><a href="covid_area.jsp">Covid Impacted Area</a> <br> <%= impact_area_count %> Area Registered 
	<%  if (!uname.equals("nouser")) { %>
		<br><a href="add_new_covid_area.jsp">Add New area</a>
	<% 	} %>
	</td>
	<td><a href="covid_hospital.jsp">Covid Hospital </a> <br> <%= hospital_count %> Hospital Registered 
	<%  if (!uname.equals("nouser")) { %>
		<br><a href="add_new_hospital.jsp">Add New Hospital</a>
	<% 	} %>
	</td>
	<td><a href="covid_request.jsp">Emergency Request </a> <br> <%= request_count %> request Registered 
	<%  if (!uname.equals("nouser")) { %>
	<br><a href="add_new_request.jsp">Add New Request</a>
	<% 	} %>
	</td>
	</tr>
	</table>

</td></tr>
</table>


</html>