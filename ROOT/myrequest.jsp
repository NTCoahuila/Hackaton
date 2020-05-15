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

 function delete_request() {

    if (document.getElementById("request_no").value == "" ) {
	    alert("nada seleccionado");
        } else {
        var r = confirm("¿Quieres eliminar!");
	if (r == true) {
	    window.location.href="/jsp/request_delete.jsp?request_no=" + document.getElementById("request_no").value;
	}
      }
    }



     
function validate() {

 if( document.myForm.request_type.selectedIndex == 0 ) {
       alert( "Seleccione Tipo de solicitud!" );
       document.myForm.request_type.focus() ;
       return false;
    }

    
    if( document.myForm.request_entered.value.trim() == "" ) {
        alert( "Por favor, introduzca la descripción de la solicitud !" );
        document.myForm.request_entered.focus() ;
        return false;
     }
    
    if( document.myForm.requester_name.value.trim() == "" ) {
       alert( "Ingrese RequesterName!" );
       document.myForm.requester_name.focus() ;
       return false;
    }
    if( document.myForm.requester_telephone.value.trim() == "" ) {
        alert( "Introduzca el número de teléfono!" );
        document.myForm.requester_telephone.focus() ;
        return false;
     }

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
</head>

<body onload='GetMap()'>
  <jsp:include page="header.jsp" />  
  <div class="sidePanel">

        <form action="jsp/request_update.jsp" method="POST" name="myForm"  onsubmit = "return(validate());">
	    <h2>Editar solicitud</h2>
	<input type=hidden id="request_no" name="request_no" required >
            <div class="form-group">
                <label>Tipo de solicitud</label>
		<select class="control" id=request_type name=request_type>
			<option value="Select">Selecciona...</option>
			<option value="Food">víveres</option>
			<option value="Medical">Médica</option>
			<option value="Groceries">Comestibles</option>
			<option value="Other">Otro</option>
		</select>

            </div>

            <div class="form-group">
                <label>Solicitud</label>
                <textarea id=request_entered name=request_entered cols=45 rows=6></textarea>
            </div>

            <div class="form-group">
                <label>Nombre del solicitante</label>
                <input type=text id=requester_name name=requester_name size=55>
            </div>

            <div class="form-group">
                <label>Teléfono</label>
                <input type=text id=requester_telephone name=requester_telephone size=55>
            </div>

            <div class="form-group">
                <label>Latitud</label>
                <input type=text id=xlat name=xlat size=55>
            </div>

            <div class="form-group">
                <label>Longitud</label>
                <input type=text id=ylng name=ylng size=55>
            </div>

            <div class="right">
                <input class="btn00 graybtn" type=button value="Eliminar" onclick="delete_request()"></a>
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
	pstmt=con.prepareStatement("SELECT * FROM ntcoahulia_request where user_no = " + userid);            
	rs=pstmt.executeQuery();
	while (rs.next()) {
        String rtype= rs.getString("request_type");
	int rtypeindex=0;
	if (rtype.equals("Food")) {
		rtypeindex=1;
	}
	else if (rtype.equals("Medical")) {
		rtypeindex=2;
	}
	else if (rtype.equals("Groceries")) {
		rtypeindex=3;
	}
	else if (rtype.equals("Other")) {
		rtypeindex=4;
	}
	else {
		rtypeindex=0;
	}

	out.println("addlocation(" + rs.getString("xlat") + "," + rs.getString("ylng") + "," + rs.getInt("request_no") + ",'"+  rtypeindex + "','" + rs.getString("request_desc") + "','"+ rs.getString("requester_name")  + "','" + rs.getString("requester_telephone")  + "');");
	} 
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
%>

 	});
}


function addlocation(xlat,ylng,request_no,s1,s2,s3,s4) {

  //Create a HTML marker and add it to the map.
  var marker = new atlas.HtmlMarker({
    color: 'DodgerBlue',
    text: '+',
    position: [xlat,ylng],
    draggable:true,
  });
  
  map.markers.add(marker);


//Add a click event to toggle the popup.
map.events.add('click',marker, () => {
	highlight_marker(marker);
	load_hospital_details(request_no,s1,s2,s3,s4,xlat,ylng);
});


map.events.add('dragend',marker, () => {
	var pos = marker.getOptions().position;
	document.getElementById("xlat").value=pos[0];
	document.getElementById("ylng").value=pos[1];
	highlight_marker(marker);
});
     

}

function load_hospital_details(request_no,s1,s2,s3,s4,s5,s6) {
	document.getElementById("request_no").value=request_no;
	document.getElementById("request_type").selectedIndex=s1;
	document.getElementById("request_entered").value=s2;
	document.getElementById("requester_name").value=s3;
	document.getElementById("requester_telephone").value=s4;
	document.getElementById("xlat").value=s5;
	document.getElementById("ylng").value=s6;
}


function highlight_marker(tmarker) {
	var allmarkers = map.markers.getMarkers();
	allmarkers.forEach(eachmarker => {
		eachmarker.setOptions({color: "Green"});
          });

	tmarker.setOptions({color: "Yellow"});
}


</script>



</html>

