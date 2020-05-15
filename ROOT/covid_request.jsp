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
  width: 100%;
  height: 100%;
  float: left;
}
</style>
</head>

<body onload='GetMap()'>
  <jsp:include page="header.jsp" />  
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

try {
	Class.forName("com.mysql.jdbc.Driver"); 
	con=DriverManager.getConnection(dburl,dbusername,dbpassword);
	pstmt=null;
	pstmt=con.prepareStatement("SELECT * FROM ntcoahulia_request");            
	rs=pstmt.executeQuery();
	while (rs.next()) {
	out.print("addlocation(" + rs.getString("xlat") + "," + rs.getString("ylng")+ ",'" + rs.getString("request_desc")+ "<br><b>"+ rs.getString("requester_name") + "</b><br>"+ rs.getString("requester_telephone") +"');");
	} 
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
%>


 	});
}


function addlocation(xlat,ylng,zTextContent) {

  //Create a HTML marker and add it to the map.
  var marker = new atlas.HtmlMarker({
    color: 'Green',
    text: '+',
    position: [xlat,ylng],
    popup: new atlas.Popup({
        content: '<div style="padding:10px">' + zTextContent + '</div>',
        pixelOffset: [0, -40]
    })
  });
  
  map.markers.add(marker);


//Add a click event to toggle the popup.
map.events.add('click',marker, () => {
    marker.togglePopup();
});
     

}
</script>



</html>

