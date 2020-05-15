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

<head>
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

<body onload='GetMap()'>
    <jsp:include page="header.jsp" />  
    <div id="myMap"></div>
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
	pstmt=con.prepareStatement("SELECT * FROM ntcoahulia_hospital");            
	rs=pstmt.executeQuery();
	while (rs.next()) {

        int totalbeds=0;
        int occupiedbeds=0;
	String icon="icon-covid-06.png";
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

		// red is greater than 66%, orange is greater than 50% and green is less than 50 % 
		// red is icon-covid-07.png
		// orange is icon-covid-08.png
		// green is icon-covid-06.png

		if (occupiedbeds > (totalbeds*10/15)) {
			icon="icon-covid-07.png";
		} else if (occupiedbeds > (totalbeds/2)) {
			icon="icon-covid-08.png";
		} else {
			icon="icon-covid-06.png";
		}

	} catch (Exception e) {
	        totalbeds =0;
	        occupiedbeds =0;
		icon="icon-covid-06.png";
	}


	out.println("addlocation(" + rs.getString("hlatitude") + "," + rs.getString("hlongitude") + ",'<b>"+ rs.getString("hospital_name") + " </b><br>"+ rs.getString("hstreet1")  + "<br>" + rs.getString("hstreet2")  + "<br>" + rs.getString("hcity")  + "<br>" + rs.getString("htelephone") + "<br> Total beds :" + totalbeds  + "<br> Occupied : "+ occupiedbeds +"','" + icon +"');");
	} 
        con.close(); 
} catch(Exception e) {
      out.print(e.toString()); 
} 
%>

        });
    }


    function addlocation(xlat, ylng, zTextContent, MarkerColor) {

        //Create a HTML marker and add it to the map.
        var marker = new atlas.HtmlMarker({
	    htmlContent: '<image src="/img/Covid_hospital/'+ MarkerColor +'" style="pointer-events: none;" />',
            position: [xlat, ylng],
            popup: new atlas.Popup({
                content: '<div style="padding:10px">' + zTextContent + '</div>',
                pixelOffset: [0, -40]
            })
        });

        map.markers.add(marker);


        //Add a click event to toggle the popup.
        map.events.add('click', marker, () => {
            marker.togglePopup();
        });


    }
</script>



</html>