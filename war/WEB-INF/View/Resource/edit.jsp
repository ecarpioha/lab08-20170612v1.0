<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.appengine.api.users.*"%>
<%
	Resource resource = (Resource) request.getAttribute("resource");
	UserService use = UserServiceFactory.getUserService();
	User user = use.getCurrentUser();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->


<title>ACL - Home</title>

<!-- Bootstrap core CSS -->
<link href="/CSS/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href="/CSS/ie10-viewport-bug-workaround.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/CSS/cover.css" rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="/JS/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
#data {
	align-items: center;
	padding: 30px;
}

#contenido {
	align-text: center;
}

.contenido {
	background-color: white;
	color: black;
}

.lista {
	background-color: black;
	color: white;
	width: 100%;
}

.boton {
	color: black;
	width: 130px;
}

input .dato {
	width: 20%;
	color: black;
}

select {
	color: black
}

a {
	color: blue;
}

a:HOVER {
	color: aqua;
}

.link {
	color: white;
}
</style>
<script>
        function verificarUrl() {
            var prueba = document.getElementById("url").value;
            var er1 = new RegExp("^/[a-z]+(/[a-z]+)?$");
            var rpta = er1.test(prueba);
            if (!rpta) {
                alert("Introduzca una expresi�n correcta /*/*");
                return false;
            }else{
                document.forms['formulario']
                ['boton'].disabled=true;
                return true;
            }
        }
    </script>
</head>

<body>

	<div class="site-wrapper">

		<div class="site-wrapper-inner">

			<div class="cover-container">

				<div class="masthead clearfix">
					<div class="inner">
						<h3 class="masthead-brand">
							<b>Access Control List (ACL)</b>
						</h3>
						<nav>
							<ul class="nav masthead-nav">
								<li><a href="/index.html">Inicio</a></li>
								<li><a href="/user">Usuarios</a></li>
								<li><a href="/role">Roles</a></li>
								<li><a href="/access">Accesos</a></li>
								<li class="active"><a href="/resource">Recursos</a></li>
								<li><a href="/billing">Facturas</a></li>
								<%
									if (use.isUserLoggedIn()) {
								%>
								<li class="active"><a href="/user/login"><%=user.getNickname()%></a></li>
								<li><a href="/user/logout">LogOut</a></li>
								<%
									} else {
								%>
								<li><a href="/user/login">Login</a></li>
								<%
									}
								%>

							</ul>
						</nav>
					</div>
				</div>
				<div class="inner cover">
					<br> <br> <br> <br>
					<div id="contenido">
						<div class="titulo">
							<h1>Editar Recurso</h1>
						</div>
						<div class="formulario">
							<form action="/resource/edit" method="post"  onsubmit="return verificarUrl()">
								<label><b>Direcci�n (URL): </b></label> <br> <input
									type="text" name="url" id="url" value="<%=resource.getUrl()%>"></input>
								<br> <label><b>Estado:</b></label> <br> <select
									name="status">
									<option value="true">Activo</option>
									<option value="false">Desactivado</option>
								</select> <br> <br> <input type="hidden" name="id"
									value="<%=resource.getId()%>"> <input name="boton" class="boton"
									type="submit" value="Editar Recurso">
							</form>
						</div>
						<div class=link>
							<a class="link" href="/resource"><b>Lista de Recursos</b></a>
						</div>
					</div>
				</div>

				<!-- Bootstrap core JavaScript
    ================================================== -->
				<!-- Placed at the end of the document so the pages load faster -->
				<script
					src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
				<script>
					window.jQuery
							|| document
									.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')
				</script>
				<script src="/JS/bootstrap.min.js"></script>
				<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
				<script src="/JS/ie10-viewport-bug-workaround.js"></script>
</body>
</html>



