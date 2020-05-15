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
</head>

  <script type = "text/javascript">


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



<body onload='GetMap()'>
    <jsp:include page="header.jsp" />  
  <div class="sidePanel">

	<form action="jsp/hospital_add.jsp" method="POST" name="myForm"  onsubmit = "return(validate());">
	    <h2>Añadir nuevo hospital</h2>
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
                <input class="btn00" type=submit value="Agregar Hospital">
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
			position: "bottom-left"
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

