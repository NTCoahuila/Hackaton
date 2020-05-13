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

	<form action="jsp/hospital_add.jsp" method="POST">
	<table width=100% style="margin-right:20px;">
	<tr><th>Add new Hospital</th></tr>
	<tr><td>Hospital Name</td></tr><tr><td><input type=Text id=hospital_name name=hospital_name size=55></td> </tr>
	<tr><td>Street1</td></tr><tr><td><input type=text  id=hstreet1 name=hstreet1 size=55></td></tr>
	<tr><td>Street2</td></tr><tr><td><input type=text id=hstreet2 name=hstreet2 size=55></td></tr>
	<tr><td>City</td></tr><tr><td><input type=text id=hcity name=hcity size=55></td></tr>
	<tr><td>Telephone</td></tr><tr><td><input type=text id=htelephone name=htelephone size=55></td></tr>
	<tr><td>Available Beds</td></tr><tr><td><input type=text id=habeds name=habeds size=55></td></tr>
	<tr><td>Occupied Beds</td></tr><tr><td><input type=text id=hobeds name=hobeds size=55></td></tr>
	<tr><td>Latitude</td></tr><tr><td><input type=text id=xlat name=xlat size=55></td></tr>
	<tr><td>Longtidue</td></tr><tr><td><input type=text id=ylng name=ylng size=55></td></tr>
	<tr><td align=right> <br><input type=submit value ="Add new Location"></td> </tr>
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

	addlocation(-101.00524, 25.42237);

 	});
}


function addlocation(xlat,ylng) {

  //Create a HTML marker and add it to the map.
  var marker = new atlas.HtmlMarker({
    color: 'DodgerBlue',
    text: '+',
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

