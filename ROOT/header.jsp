    <header>
        <div class="container">
            <a class="back" href="#" onclick ="window.history.back();">
                <img src="img/back-icon.svg">
            </a>
            <a class="logo" href="https://ntcoahuila.azurewebsites.net">
                <img src="img/covidRescuerLogo.svg">
            </a>
<%

String uname = "nouser" ;
try {
	uname = session.getAttribute("username").toString() ;
} catch (Exception e) {
	uname = "nouser";
}

if (uname.equals("nouser")) {
%>
            <div class="right-menu">
                <div class="group-btn">
                    <a class="btn00" href="login.jsp">
                        Iniciar sesión
                    </a>
                    <a class="linked-text" href="register.jsp">
                        o Regístrate
                    </a>
                </div>
            </div>

<% } else { %>

            <div class="right-menu">
                <a class="edit" href="myimpactedarea.jsp">Editar<br>Zonas</a>
                <a class="edit" href="myhospital.jsp">Editar<br>Hospitales</a>
                <a class="edit" href="myrequest.jsp">Editar<br>Solicitudes</a>
 
                <a class="btn00 graybtn" href="signout.jsp">
                     Cerrar sesión
                </a>
	   </div>

<% } %>
        </div>

    </header>
