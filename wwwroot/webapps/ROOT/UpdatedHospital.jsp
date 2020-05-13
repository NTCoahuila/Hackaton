<html>
<head>
<link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css" />
<script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
<script type = "text/javascript">
        
function validate() {
    
    if( document.myForm.hospital_name.value == "" ) {
       alert( "Please provide hospital name!" );
       document.myForm.hospital_name.focus() ;
       return false;
    }
    if( document.myForm.hstreet1.value == "" ) {
        alert( "Please Enter hospital street1 !" );
        document.myForm.hstreet1.focus() ;
        return false;
     }
    if( document.myForm.hstreet2.value == "" ) {
        alert( "Please provide hospital street2 !" );
        document.myForm.hstreet2.focus() ;
        return false;
     }
    if( document.myForm.hcity.value == "" ) {
        alert( "Please provide hospital City!" );
        document.myForm.hcity.focus() ;
        return false;
     }
    if( document.myForm.htelephone.value == "" ) {
        alert( "Please provide hospital Telephone number!" );
        document.myForm.htelephone.focus() ;
        return false;
     } 
    if( document.myForm.habeds.value == "" ) {
         alert( "Please provide Available beds!" );
         document.myForm.habeds.focus() ;
         return false;
      }
    if( document.myForm.hoccupiedbeds.value == "" ) {
          alert( "Please provide Occupiedbeds!" );
          document.myForm.hoccupiedbeds.focus() ;
          return false;
       } 
    if( document.myForm.hlatitude.value == "" ) {
           alert( "Please provide Latitude!" );
           document.myForm.hlatitude.focus() ;
           return false;
        } 
    if( document.myForm.hlongitude.value == "" ) {
            alert( "Please provide hlongitude!" );
            document.myForm.hlongitude.focus() ;
            return false;
         }
    return( true );

}    
        
      </script>   
</head>
</html>
<body onload='GetMap()'>
	<form action="servletupdatehospital" method="post" name="myForm"  onsubmit = "return(validate());">
  <div class="sidePanel">
	<table width=100%>
	<tr align="center">Update Hospital</tr>
	<tr><td>Hospital Name:</td>
	<td><input type=text name=hospital_name></td>
	 </tr>
	<tr>
	<td>Street1:</td>
	<td><input type=text name=hstreet1></td> 
	</tr>
	<tr><td>Street2:</td>
	<td><input type=text name=hstreet2></td> 
	</tr>
	<tr><td>City:</td>
	<td><input type=text name=hcity></td>
	</tr>
	<tr><td>Telephone:</td>
	<td><input type=text name=htelephone></td> 
	</tr>
	<tr><td>Available Beds:</td>
	<td><input type=text name=habeds></td> 
	</tr>
	<tr><td>Occupied Beds:</td>
	<td><input type=text name=hoccupiedbeds></td> 
	</tr>
	<tr><td>Latitude:</td>
	<td><input type=text name=hlatitude></td> 
	</tr>
	<tr><td>Longtidue:</td>
	<td><input type=text name=hlongitude></td> </tr>
		<tr><td align="center"> <br><input type=submit value ="Save"></td> </tr>
	
	</table>
  </div>
 </form>
</body>







