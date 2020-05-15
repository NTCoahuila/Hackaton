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

    function delete_hospital() {
    if (document.getElementById("hospital_no").value == "" ) {
	    alert("nada seleccionado");
        } else {
        var r = confirm("¿Quieres eliminar!");
	if (r == true) {
	    window.location.href="/jsp/hospital_delete.jsp?hospital_no=" + document.getElementById("hospital_no").value;
	}
      }
    }


    function validate() {

    if( document.myForm.hospital_name.value.trim() == "" ) {
       alert( "Por favor, introduzca HospitalName!" );
       document.myForm.hospital_name.focus() ;
       return false;
    }
    if( document.myForm.hstreet1.value.trim() == "" ) {
        alert( "Por favor, introduzca Hospitaladress1!" );
        document.myForm.hstreet1.focus() ;
        return false;
     }
 if( document.myForm.hstreet2.value.trim() == "" ) {
        alert( "Por favor, introduzca Hospitaladress2!" );
        document.myForm.hstreet2.focus() ;
        return false;
     }
if( document.myForm.hcity.value.trim() == "" ) {
        alert( "Por favor ingrese HospitalCity!" );
        document.myForm.hcity.focus() ;
        return false;
     }

    if( document.myForm.htelephone.value.trim() == "" ) {
        alert( "Por favor, introduzca el número de teléfono del hospital!" );
        document.myForm.htelephone.focus() ;
        return false;
     }

if( document.myForm.habeds.value.trim() == "" || isNaN(document.myForm.habeds.value) ) {
        alert( "Por favor, introduzca las camas disponibles!" );
        document.myForm.habeds.focus() ;
        return false;
     }
if( document.myForm.hobeds.value.trim() == "" || isNaN(document.myForm.hobeds.value) ) {
        alert( "Por favor, introduzca las camas ocupadas!" );
        document.myForm.hobeds.focus() ;
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
	<form action="jsp/hospital_update.jsp" method="POST" name="myForm"  onsubmit = "return(validate());">
	
	<input type=hidden id="hospital_no" name="hospital_no" required >
		<h2>Editar información del hospital</h2>
            <div class="form-group">
                <label>Nombre del hospital</label>
                <input type=Text id=hospital_name name=hospital_name size=55>
            </div>

            <div class="form-group">
                <label>Calle 1</label>
                <input type=text  id=hstreet1 name=hstreet1 size=55>
            </div>

            <div class="form-group">
                <label>Calle 2</label>
                <input type=text id=hstreet2 name=hstreet2 size=55>
            </div>

            <div class="form-group">
                <label>Ciudad</label>
                <input type=text id=hcity name=hcity size=55>
            </div>

            <div class="form-group">
                <label>Teléfono</label>
                <input type=text id=htelephone name=htelephone size=55>
            </div>

            <div class="form-group">
                <label>Camas disponibles</label>
                <input type=text id=habeds name=habeds size=55>
            </div>

            <div class="form-group">
                <label>Camas ocupadas</label>
                <input type=text id=hobeds name=hobeds size=55>
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
                <input class="btn00 graybtn" type=button value="Eliminar" onclick="delete_hospital()">
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
                center: [-102.5, 28.0],
                zoom : 6,
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
	pstmt=con.prepareStatement("SELECT * FROM ntcoahulia_hospital where user_no = " + userid);            
	rs=pstmt.executeQuery();
	while (rs.next()) {

        int totalbeds=0;
        int occupiedbeds=0;
        try {
		// convert to integer
		if (rs.getString("habeds") != null ) {
			totalbeds = Integer.parseInt(rs.getString("habeds"));
		} else {
			totalbeds = 0;
		}

		if (rs.getString("hoccupiedbeds") != null ) {
		        occupiedbeds = Integer.parseInt(rs.getString("hoccupiedbeds"));
		} else {
			occupiedbeds = 0;
		}


	} catch (Exception e) {
	        totalbeds =0;
	        occupiedbeds =0;
	}

	out.print("addlocation(" + rs.getString("hlatitude") + "," + rs.getString("hlongitude") + "," + rs.getInt("hid") + ",'"+ rs.getString("hospital_name") + "','"+ rs.getString("hstreet1")  + "','" + rs.getString("hstreet2")  + "','" + rs.getString("hcity")  + "','" + rs.getString("htelephone") + "','" + totalbeds  + "','"+ occupiedbeds +"');");
	} 
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
%>


 	});
}


function addlocation(xlat,ylng,hospitalno,s1,s2,s3,s4,s5,s6,s7) {

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
	var pos = marker.getOptions().position;
	load_hospital_details(hospitalno,s1,s2,s3,s4,s5,s6,s7,pos[0],pos[1]);
});


map.events.add('dragend',marker, () => {
	var pos = marker.getOptions().position;
	document.getElementById("xlat").value=pos[0];
	document.getElementById("ylng").value=pos[1];
	highlight_marker(marker);
});
     

}

function load_hospital_details(hospitalno,s1,s2,s3,s4,s5,s6,s7,s8,s9) {
	document.getElementById("hospital_no").value=hospitalno;
	document.getElementById("hospital_name").value=s1;
	document.getElementById("hstreet1").value=s2;
	document.getElementById("hstreet2").value=s3;
	document.getElementById("hcity").value=s4;
	document.getElementById("htelephone").value=s5;
	document.getElementById("habeds").value=s6;
	document.getElementById("hobeds").value=s7;
	document.getElementById("xlat").value=s8;
	document.getElementById("ylng").value=s9;
}


function highlight_marker(tmarker) {
	var allmarkers = map.markers.getMarkers();
	allmarkers.forEach(eachmarker => {
		eachmarker.setOptions({color: "DodgerBlue"});
          });

	tmarker.setOptions({color: "Yellow"});
}


</script>



</html>

