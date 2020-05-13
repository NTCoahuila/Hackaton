<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css" />
<script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
<script type = "text/javascript">
        
function validate() {
    
    if( document.myForm.requester_name.value == "" ) {
       alert( "Please Enter RequesterName!" );
       document.myForm.requester_name.focus() ;
       return false;
    }
    if( document.myForm.request_desc.value == "" ) {
        alert( "Please Enter RequestDescription !" );
        document.myForm.request_desc.focus() ;
        return false;
     }
    if( document.myForm.requester_telephone.value == "" ) {
        alert( "Please Enter Telephonenumber!" );
        document.myForm.requester_telephone.focus() ;
        return false;
     }
    if( document.myForm.xlat.value == "" ) {
        alert( "Please Enter Latitude!" );
        document.myForm.xlat.focus() ;
        return false;
     }
    if( document.myForm.ylng.value == "" ) {
        alert( "Please Enter Longtidue!" );
        document.myForm.ylng.focus() ;
        return false;
     }
    return( true );

}    
        
      </script>   
</head>
</html>
<body>
	<form action="User_request" method="post" name="myForm"  onsubmit = "return(validate());">
  <div class="sidePanel">
	<table width=100%>
	<tr align="center" bgcolor="red">User RequestForm</tr>
	<tr></tr>
	<tr></tr>
	<tr><td>Requester Name:</td>
	<td><input type=text name=requester_name></td>
	 </tr>
	<tr>
	<td>Request Desc:</td>
	<td><textarea rows="4" cols="35" name="request_desc"></textarea></td> 
	</tr>
	<tr><td>Telephone:</td>
	<td><input type=text name=requester_telephone></td> 
	</tr>
	<tr><td>Latitude:</td>
	<td><input type=text name=xlat></td> 
	</tr>
	<tr><td>Longtidue:</td>
	<td><input type=text name=ylng></td> 
	</tr>
	<tr><td align="center"> <br><input type=submit value ="Register">
	<input type =reset value="cancel"></td></tr>
	
	</table>
  </div>
 </form>
</body>







