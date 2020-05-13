<table width=100%>
<tr><td><a href="https://ntcoahuila.azurewebsites.net">Logo</a></td>
<td width=300 align=right>
<%

String uname = "nouser" ;
try {
	uname = session.getAttribute("username").toString() ;
} catch (Exception e) {
	uname = "nouser";
}

if (uname.equals("nouser")) {
%>
<a href="register.jsp">Register</a>
<a href="login.jsp">Login</a><br>
<% } else { %>
<a href="myimpactedarea.jsp">MyArea</a>
<a href="myhospital.jsp">MyHospital</a>
<a href="myrequest.jsp">MyRequest</a>
<a href="signout.jsp">Signout</a>
<% } %>

</td></tr>
</table>
