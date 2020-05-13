<html>
<head>
<link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css" />
<script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>
<script type = "text/javascript">
        
function validate() {
    
    if( document.myForm.username.value == "" ) {
       alert( "Please Enter UserName!" );
       document.myForm.username.focus() ;
       return false;
    }
    if( document.myForm.password.value == "" ) {
        alert( "Please Enter Password !" );
        document.myForm.password.focus() ;
        return false;
     }
    if( document.myForm.emailid.value == "" ) {
        alert( "Please Enter EmailId!" );
        document.myForm.emailid.focus() ;
        return false;
     }
     
    return( true );

}    
        
      </script>   
</head>
</html>
<body>
	<form action="Userregister" method="post" name="myForm"  onsubmit = "return(validate());">
  <div class="sidePanel">
	<table width=100%>
	<tr align="center">User Register</tr>
	<tr><td>User Name:</td>
	<td><input type=text name=username></td>
	 </tr>
	<tr>
	<td>Password:</td>
	<td><input type="password" name=password></td> 
	</tr>
	<tr><td>Email ID:</td>
	<td><input type=text name=emailid></td> 
	</tr>
	<tr><td align="center"> <br><input type=submit value ="Register"></td> 
	<td><input type =reset value="cancel"></td></tr>
	
	</table>
  </div>
 </form>
</body>







