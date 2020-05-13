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
  width: 100%;
  height: 100%;
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

	addlocation(-30,0,"<b>Hospital1</B> <br>saltillo <br> Total beds : 2000 <br> Occupied : 200","Green");
	addlocation(-10,0,"<b>Hospital2</B> <br>saltillo <br> Total beds : 2300 <br> Occupied : 2000","Red");
	addlocation(0,10,"<b>Hospital13</B> <br>saltillo <br> Total beds : 400 <br> Occupied : 300","Red");
	addlocation(10,30,"<b>Hospital4</B> <br>saltillo <br> Total beds : 50 <br> Occupied : 25","Green");
	addlocation(-20,30,"<b>Hospital5</B> <br>saltillo <br> Total beds : 200 <br> Occupied : 100","Green");

 	});
}


function addlocation(xlat,ylng,zTextContent,MarkerColor) {

  //Create a HTML marker and add it to the map.
  var marker = new atlas.HtmlMarker({
    color: MarkerColor,
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

