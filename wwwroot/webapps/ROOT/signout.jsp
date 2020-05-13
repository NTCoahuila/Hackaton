<%
try {
session.removeAttribute("username");
} catch (Exception e) {
out.print(e.toString());
}
response.sendRedirect("https://ntcoahuila.azurewebsites.net");
%>