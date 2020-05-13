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
<table width=100%>
<tr><td><a href="https://ntcoahuila.azurewebsites.net">Logo</a></td>
<td width=300 align=right><a href="register.html">Register</a><a href="login.html">Login</a><br>
<a href="myimpactedarea.html">MyArea</a>
<a href="myhospital.html">MyHospital</a>
<a href="myrequest.html">MyRequest</a>
<a href="signout.html">Signout</a>
</td></tr>
</table>
</td></tr>
</table>
  <div class="sidePanel">
	<table width=100% style="margin-right:20px;">
	<tr><th>Add New Request</th></tr>
	<tr><td>Request Type</td></tr><tr><td>
		<select style="width:350px;" id=request_type>
			<option value="Select">Select</option>
			<option value="Food">Food</option>
			<option value="Medical">Medical</option>
			<option value="Groceries">Groceries</option>
			<option value="Other">Other</option>
		</select>
        </td> </tr>
	<tr><td>Request</td></tr><tr><td><textarea id=request_exntered cols=45 rows=6></textarea></td></tr>
	<tr><td>Name</td></tr><tr><td><input type=text id=requester_name size=55></td></tr>
	<tr><td>Telephone</td></tr><tr><td><input type=text id=requester_telephone size=55></td></tr>
	<tr><td>Latitude</td></tr><tr><td><input type=text id=xlat size=55></td></tr>
	<tr><td>Longtidue</td></tr><tr><td><input type=text id=ylng size=55></td></tr>
	<tr><td align=right> <br><input type=submit value ="Save"> <input type =reset value="cancel"></td> </tr>
	</table>
  </div>
  <div id="myMap" ></div>
</body>


<script type='text/javascript'>
var map;
function GetMap() {
            //Initialize a map instance.
            map = new atlas.Map('myMap', {
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

	addlocation(-101.00524, 25.42237,1);
	addlocation(-30,0,2);
	addlocation(-10,0,3);
	addlocation(0,10,4);
	addlocation(10,30,5);
	addlocation(-20,30,6);

 	});
}


function addlocation(xlat,ylng,request_no) {

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
	load_hospital_details(request_no);
});


map.events.add('dragend',marker, () => {
	var pos = marker.getOptions().position;
	document.getElementById("xlat").value=pos[0];
	document.getElementById("ylng").value=pos[1];
	highlight_marker(marker);
});
     

}

function load_hospital_details(request_no) {
	document.getElementById("request_type").selectedIndex=Math.floor((Math.random() * 10) % 4 ) + 1;
	document.getElementById("request_exntered").value="This is the description type by the requester for " + document.getElementById("request_type").value;
	document.getElementById("requester_name").value="requester_name " + request_no;
	document.getElementById("requester_telephone").value=Math.floor(Math.random() * 10000000000);
	document.getElementById("xlat").value=Math.random() * 100;
	document.getElementById("ylng").value=Math.random() * 100;
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

