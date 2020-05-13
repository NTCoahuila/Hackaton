<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type = "text/javascript">
        
function validate() {
  
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
<body>

<form action="Impactarea_Updated" method="post" name="myForm"  onsubmit = "return(validate());">
  <div class="sidePanel">
	<table width=100%>
	<tr align="center" bgcolor="red">Updated Impacted Areas</tr>
	<tr></tr>
	<tr></tr>
	<tr><td>Latitude:</td>
	<td><input type=text name=xlat></td>
	 </tr>
	<tr>
	<td>Longtidue:</td>
	<td><textarea rows="4" cols="35" name="ylng"></textarea></td> 
	</tr>
	<tr><td align="center"> <br><input type=submit value ="Save">
		</table>
  </div>
 </form>


</body>
</html>