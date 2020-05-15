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
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Covid Rescuer</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="apple-touch-icon" href="icon.png">
    <link rel="stylesheet" href="css/main.css">
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
<jsp:include page="header.jsp" />  
    <div class="container push">
        <div class="flex-container">
            <div class="item">
                <a href="mexico.jsp">
                    <div class="circle">
                        <img src="img/mexico.svg">
                    </div>
                    <h2>
                        Contagios por Estado
                    </h2>
                </a>


                <a class="tag orange" href="coahuila.jsp">
                    Ver Coahuila
                </a>


            </div>

            <div class="item">
                <a href="covid_area.jsp">
                    <div class="circle">
                        <img src="img/person.svg">
                    </div>
                    <h2>
                        Zonas<br>COVID-19
                    </h2>
                </a>

	<%  if (!uname.equals("nouser")) { %>
                <a href="add_new_covid_area.jsp" class="btn00">
                    Agregar Zona
                </a>
	<% 	} %>

                <div class="tag">
                    <%= impact_area_count %> registrada(s)
                </div>
            </div>

            <div class="item">
                <a href="covid_hospital.jsp">
                    <div class="circle">
                        <img src="img/hospital.svg">
                    </div>
                    <h2>
                        Hospitales Disponibles
                    </h2>
                </a>

	<%  if (!uname.equals("nouser")) { %>
                <a href="add_new_hospital.jsp" class="btn00">
                    Agregar Hospital
                </a>
	<% 	} %>

                <div class="tag">
                    <%= hospital_count %> registrado(s)
                </div>
            </div>

            <div class="item">
                <a href="covid_request.jsp">
                    <div class="circle">
                        <img src="img/help.svg">
                    </div>
                    <h2>
                        Solicitud de Emergencia
                    </h2>
                </a>

	<%  if (!uname.equals("nouser")) { %>
                <a href="add_new_request.jsp" class="btn00">
                    Agregar Solicitud
                </a>
	<% 	} %>

                <div class="tag">
                    <%= request_count %> registrada(s)
                </div>
            </div>

        </div>
    </div>
    </div>

</html>