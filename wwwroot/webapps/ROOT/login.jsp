<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Covid Rescuer</title>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
</head>
<body ng-app="postLogin" ng-controller="PostController as postCtrl">
<table width=100% border = 1>
<tr>
<td>
<jsp:include page="header.jsp" /> 
</td></tr>
<tr><td align=center colspan=2>
<br><br>
	<form name="login" ng-submit="postCtrl.postForm()" method="POST">
	<table cellpadding=10 border=1>
	<tr><td>User Name </td> <td><input type=Text name="username" id="inputUsername" ng-model="postCtrl.inputData.username" required ><br>
	<span style="color:red" ng-show="login.username.$invalid">
	<span ng-show="login.username.$error.required">** Username is required.</span>
	</span>
	</td> </tr>
	<tr><td>Password </td> <td><input type=password name="password" id="inputPassword" class="form-control" required ng-model="postCtrl.inputData.password"><br>
	<span style="color:red" ng-show="login.password.$invalid">
	<span ng-show="login.password.$error.required">** Password is required.</span>
	</td> </tr>
	<tr><td align=right colspan=2> <input type=submit value ="login" ng-disabled="login.$invalid"> <input type =reset value="cancel">
                     <div class="alert alert-danger" ng-show="errorMsg">
				&nbsp;&nbsp;{{errorMsg}}
                     </div>

	</td> </tr>
	</table>
	</form>
<br><br>
&nbsp;
</td></tr>
</table>

<script>
var app = angular.module('postLogin', []);
app.controller('PostController', function($scope, $http) {
            this.postForm = function() {
                var encodedString = 'username=' +
                    encodeURIComponent(this.inputData.username) +
                    '&password=' +
                    encodeURIComponent(this.inputData.password);
                $http({
                    method: 'POST',
                    url: 'jsp/userauth.jsp',
                    data: encodedString,
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'}
                })
                .then(function(response) {
                        if ( response.data.trim() === 'success') {
                            
				window.location.href = 'index.jsp';
                        } else {
                            $scope.errorMsg = "Username and password do not match.";
                        }
                }) 
	}
});

</script>


</body>

</html>