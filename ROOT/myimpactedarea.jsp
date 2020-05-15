<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%

String dburl="jdbc:mysql://ntcoahuila-db.mysql.database.azure.com:3306/mysql_ntcoahuila_db?useSSL=true&requireSSL=false";
String dbusername="NTCoahuila@ntcoahuila-db"; 
String dbpassword="Covid19Hackaton";

int impact_area_count=0;
int hospital_count=0;
int request_count=0;

Connection con;
PreparedStatement pstmt;
ResultSet rs;

%>
<html>

<head>
<link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css" />
<script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Covid Rescuer</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="apple-touch-icon" href="icon.png">
<link rel="stylesheet" href="css/main.css">
</head>

<style>
html,
body {
  width: 100%;
  height: 100%;
  padding: 0;
  margin: 0;
}

#myMap {
  position: relative;
  width: calc(100% - 375px);
  height: 100%;
  float: right;
}


</style>

  <script type = "text/javascript">

 function delete_area() {
    if (document.getElementById("areano").value == "" ) {
	alert("nada seleccionado");
    } else {
       var r = confirm("¿Quieres eliminar!");
	if (r == true) {
	window.location.href="/jsp/impacted_area_delete.jsp?areano=" + document.getElementById("areano").value;
       }
     } 
   }


    function validate() {


    if( document.myForm.xlat.value.trim() == "" || isNaN(document.myForm.xlat.value) ) {
        alert( "Por favor, introduzca Latitud! , Mover el marcador en el mapa" );
        document.myForm.xlat.focus() ;
        return false;
     }
    if( document.myForm.ylng.value.trim() == "" || isNaN(document.myForm.ylng.value)  ) {
        alert( "Por favor, ingrese Longtidue!, Mover el marcador en el mapa" );
        document.myForm.ylng.focus() ;
        return false;
     }
  
    return( true );

}    
    </script> 





<body onload='GetMap()' >
<jsp:include page="header.jsp" />  
  <div class="sidePanel" >
	<form action="jsp/impacted_area_update.jsp" method="POST" name="myForm"  onsubmit = "return(validate());">

        <h2>Editar ubicación de zona afectada</h2>
	<input type=hidden id="areano" name="areano" required >

            <div class="form-group">
                <label>Latitud</label>
                <input type=text name="xlat" id=xlat size=55>
            </div>

            <div class="form-group">
                <label>Longitud</label>
                <input type=text name="ylng" id=ylng size=55>
            </div>
            <div class="right">
                <input class="btn00 graybtn" type=button value="Eliminar" onclick="delete_area()">
                <input class="btn00" type=submit value="Guardar">
            </div>

	</form>
  </div>
  <div id="myMap" ></div>
</body>


<script type='text/javascript'>
var map;
function GetMap() {
            //Initialize a map instance.
            map = new atlas.Map('myMap', {
                center: [-102, 25],
                zoom : 4,
		view: 'Auto',
				//Add your Azure Maps subscription key to the map SDK. Get an Azure Maps key at https://azure.com/maps
                authOptions: {
                    authType: 'subscriptionKey',
                    subscriptionKey: 'w48YXU4iDSv6uC1R2IW-EmWGWYUCupsOtEe15Urwf5A'
                }
            });


	//Wait until the map resources are ready.
	map.events.add('ready', function () {

		//add all map controls
		map.controls.add([
			new atlas.control.ZoomControl(),
			new atlas.control.CompassControl(),
			new atlas.control.PitchControl(),
			new atlas.control.StyleControl()
		], {
			position: "bottom-left"
		});

<%

String userid = "-1" ;
try {
	userid = session.getAttribute("userid").toString() ;
} catch (Exception e) {
	userid = "-1";
}


try {
	Class.forName("com.mysql.jdbc.Driver"); 
	con=DriverManager.getConnection(dburl,dbusername,dbpassword);
	pstmt=null;
	pstmt=con.prepareStatement("SELECT * FROM ntcoahulia_impacted_area where user_no = " + userid);            
	rs=pstmt.executeQuery();
	while (rs.next()) {
	out.print("addlocation(" + rs.getString("xlat") + "," + rs.getString("ylng")+ "," + rs.getInt("area_no")+ ");");
	} 
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
%>

 	});
}


function addlocation(xlat,ylng,areano) {

  //Create a HTML marker and add it to the map.
  var marker = new atlas.HtmlMarker({
    htmlContent: '<image src="/img/covid_area/covid_area.png" style="pointer-events: none;" />',
    position: [xlat,ylng],
    draggable:true,
  });
  
  map.markers.add(marker);


//Add a click event to toggle the popup.
map.events.add('click',marker, () => {
	highlight_marker(marker);
	var pos = marker.getOptions().position;
	load_area_details(pos[0], pos[1], areano);
});


map.events.add('dragend',marker, () => {
	var pos = marker.getOptions().position;
	document.getElementById("areano").value=areano;
	document.getElementById("xlat").value=pos[0];
	document.getElementById("ylng").value=pos[1];
	highlight_marker(marker);

});
     

}

function load_area_details(xl,yl, areano) {
	document.getElementById("areano").value=areano;
	document.getElementById("xlat").value=xl;
	document.getElementById("ylng").value=yl;
}

function highlight_marker(tmarker) {
	var allmarkers = map.markers.getMarkers();
	allmarkers.forEach(eachmarker => {
		eachmarker.setOptions({color: "Red"});
          });

	tmarker.setOptions({color: "Yellow"});
}


</script>





</html>

