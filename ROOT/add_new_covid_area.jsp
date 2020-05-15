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
    return true;
     }

  </script>

<body onload='GetMap()'>
<jsp:include page="header.jsp" />  
  <div class="sidePanel" >
	<form action="jsp/impacted_area_add.jsp" method="POST" name="myForm"  onsubmit = "return validate();">

        <h2>Añadir nueva zona</h2>

            <div class="form-group">
                <label>Latitud</label>
                <input type=text name="xlat" id=xlat size=55>
            </div>

            <div class="form-group">
                <label>Longitud</label>
                <input type=text name="ylng" id=ylng size=55>
            </div>
            <div class="right">
                <input class="btn00" type=submit value="Agregar zona">
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
                center:[-101.00524, 25.42237],
		zoom:10,
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

	addlocation(-101.00524, 25.42237);

 	});
}


function addlocation(xlat,ylng) {

  //Create a HTML marker and add it to the map.
  var marker = new atlas.HtmlMarker({
    htmlContent: '<image src="/img/covid_area/covid_area.png" style="pointer-events: none;" />',
    position: [xlat,ylng],
    draggable:true,
  });
  
  map.markers.add(marker);


//Add a click event to toggle the popup.
map.events.add('dragend',marker, () => {
        var pos = marker.getOptions().position;
document.getElementById("xlat").value=pos[0];
document.getElementById("ylng").value=pos[1];
});
     

}
</script>



</html>

