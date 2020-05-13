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
<link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css" />
<script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
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

.sidePanel {
   width: 325px;
   height: 580px;
   float: left;
}

</style>

<body onload='GetMap()'>
<table width=100% border = 1>
<tr><td>
<jsp:include page="header.jsp" />  
</td></tr>
</table>
  <div class="sidePanel">
	<form name="impactedarea" action="jsp/hospital_update.jsp" method="POST">
	<input type=hidden id="hospital_no" name="hospital_no" required >
	<table width=100% style="margin-right:20px;">
	<tr><th>Update Hospital</th></tr>
	<tr><td>Hospital Name</td></tr><tr><td><input type=Text id=hospital_name name=hospital_name size=55></td> </tr>
	<tr><td>Street1</td></tr><tr><td><input type=text  id=hstreet1 name=hstreet1 size=55></td></tr>
	<tr><td>Street2</td></tr><tr><td><input type=text id=hstreet2 name=hstreet2 size=55></td></tr>
	<tr><td>City</td></tr><tr><td><input type=text id=hcity name=hcity size=55></td></tr>
	<tr><td>Telephone</td></tr><tr><td><input type=text id=htelephone name=htelephone size=55></td></tr>
	<tr><td>Available Beds</td></tr><tr><td><input type=text id=habeds name=habeds size=55></td></tr>
	<tr><td>Occupied Beds</td></tr><tr><td><input type=text id=hobeds name=hobeds size=55></td></tr>
	<tr><td>Latitude</td></tr><tr><td><input type=text id=xlat name=xlat size=55></td></tr>
	<tr><td>Longtidue</td></tr><tr><td><input type=text id=ylng name=ylng size=55></td></tr>
	<tr><td align=right> <br><input type=submit value ="Save"></td> </tr>
	</table>
	</form>
  </div>
  <div id="myMap" ></div>
</body>


<script type='text/javascript'>
var map;
function GetMap() {
            //Initialize a map instance.
            map = new atlas.Map('myMap', {
                center: [-102, 23],
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
			position: "top-right"
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
	out.print("addlocation(" + rs.getString("hlatitude") + "," + rs.getString("hlongitude") + "," + rs.getInt("hid") + ",'"+ rs.getString("hospital_name") + "','"+ rs.getString("hstreet1")  + "','" + rs.getString("hstreet2")  + "','" + rs.getString("hcity")  + "','" + rs.getString("htelephone") + "','" + rs.getString("habeds")  + "','"+ rs.getString("hoccupiedbeds") +"');");
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

