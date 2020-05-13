<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Covid Rescuer</title>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
</head>
<body ng-app="postRegister" ng-controller="PostController as postCtrl">
<table width=100% border = 1>
<tr>
<td>
<jsp:include page="header.jsp" /> 
</td></tr>
<tr><td align=center colspan=2>
<br><br>
	<form name="register" ng-submit="postCtrl.postForm()" method="POST">
	<table cellpadding=10 border=1>
	<tr><td>User Name </td> <td><input type=Text name="username" id="inputUsername" ng-model="postCtrl.inputData.username" required ><br>
	<span style="color:red" ng-show="register.username.$invalid">
	<span ng-show="register.username.$error.required">** Username is required.</span>
	</span>
	</td> </tr>
	<tr><td>Password </td> <td><input type=password name="password" id="inputPassword" required ng-model="postCtrl.inputData.password"><br>
	<span style="color:red" ng-show="register.password.$invalid">
	<span ng-show="register.password.$error.required">** Password is required.</span>
	</span>
	</td> </tr>
		<tr><td>Confirm Password </td> <td><input type=password name="confirmpassword" id="inputPassword" compare-to="postCtrl.inputData.password" required ng-model="postCtrl.inputData.cpassword"><br>
	<span style="color:red" ng-show="register.confirmpassword.$invalid">
	<span ng-show="register.confirmpassword.$error.compareTo">** Password not matching.</span>
	</span>
	</td> </tr>
	<tr><td>Email Id</td> <td><input type=email name="emailid" id="inputEmailId" required ng-model="postCtrl.inputData.emailid"><br>
	<span style="color:red" ng-show="register.emailid.$invalid">
	<span ng-show="register.emailid.$error.required">** EmailId is required.</span>
	<span ng-show="register.emailid.$error.email">** Invalid Email address.</span>
	</span>
	</td> </tr>
	<tr><td align=right colspan=2> <input type=submit value ="Register"  ng-disabled="register.$invalid"> <input type =reset value="cancel">
                     <div class="alert alert-danger" ng-show="errorMsg">
				&nbsp;&nbsp;{{errorMsg}}
                     </div>
	</td> </tr>
	</table>
<br><br>
&nbsp;
</td></tr>
</table>
<script>
var app = angular.module('postRegister', []);
app.controller('PostController', function($scope, $http) {
            this.postForm = function() {
                var encodedString = 'username=' +
                    encodeURIComponent(this.inputData.username) +
                    '&password=' +
                    encodeURIComponent(this.inputData.password) +
                    '&emailid=' +
                    encodeURIComponent(this.inputData.emailid);
                $http({
                    method: 'POST',
                    url: 'jsp/useradd.jsp',
                    data: encodedString,
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'}
                })
                .then(function(response) {
                        if ( response.data.trim() === 'success') {
                            $scope.errorMsg = "User registered Sucessfully !!. U can login now ";
                        } else if ( response.data.trim() === 'already') {
                            $scope.errorMsg = "User is already registered !!";
                        }else {
                            $scope.errorMsg = "Server Issue try after some time";
                        }
                }) 
	}
});

app.directive("compareTo", function ()  
{  
    return {  
        require: "ngModel",  
        scope:  
        {  
            confirmPassword: "=compareTo"  
        },  
        link: function (scope, element, attributes, modelVal)  
        {  
            modelVal.$validators.compareTo = function (val)  
            {  
                return (val == scope.confirmPassword);  
            };  
            scope.$watch("confirmPassword", function ()  
            {  
                modelVal.$validate();  
            });  
        }  
    };  
});

</script>
</body>
</html>