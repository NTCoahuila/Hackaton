<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Covid Rescuer</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="apple-touch-icon" href="icon.png">
    <link rel="stylesheet" href="css/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
</head>

<body ng-app="postRegister" ng-controller="PostController as postCtrl">
    <header>
        <div class="container">
            <a class="back" href="#" onclick="window.history.back();">
                <img src="img/back-icon.svg">
            </a>
            <a class="logo" href="https://ntcoahuila.azurewebsites.net">
                <img src="img/covidRescuerLogo.svg">
            </a>
        </div>
    </header>
    <div class="container">
        <div class="log-box">
            <form name="register" ng-submit="postCtrl.postForm()" method="POST">


                <div class="from-group">
                    <label>Usuario</label>
                    <input type=Text name="username" id="inputUsername" ng-model="postCtrl.inputData.username" required>
                    <span style="color:red" ng-show="register.username.$invalid">
                        <span ng-show="register.username.$error.required">** Se requiere nombre de usuario.</span>
                    </span>
                </div>

                <div class="from-group">
                    <label>Contrase�a</label>
                    <input type=password name="password" id="inputPassword" required
                        ng-model="postCtrl.inputData.password"><br>
                    <span style="color:red" ng-show="register.password.$invalid">
                        <span ng-show="register.password.$error.required">** Se requiere contrase�a.</span>
                    </span>
                </div>

                <label>Confirmar contrase�a</label>
                <input type=password name="confirmpassword" id="inputPassword" compare-to="postCtrl.inputData.password"
                    required ng-model="postCtrl.inputData.cpassword">
                <span style="color:red" ng-show="register.confirmpassword.$invalid">
                    <span ng-show="register.confirmpassword.$error.compareTo">** Contrase�a que no coincide.</span>
                </span>

                <label>Correo electr�nico</label>
                <input type=email name="emailid" id="inputEmailId" required ng-model="postCtrl.inputData.emailid"><br>
                <span style="color:red" ng-show="register.emailid.$invalid">
                    <span ng-show="register.emailid.$error.required">** Se requiere correo electr�nico.</span>
                    <span ng-show="register.emailid.$error.email">** ID de correo electr�nico no v�lido.</span>
                </span>


                <div class="right">
                    <input type=reset value="Cancelar" class="btn00 graybtn">
                    <input type=submit value="Registrar" ng-disabled="register.$invalid" class="btn00">
                </div>

                    <div class="alert alert-danger text-center" ng-show="errorMsg">
                        <span color="red"><b>{{errorMsg}} </b></span>
                    </div>


            </form>
        </div>
    </div>

    <script>
        var app = angular.module('postRegister', []);
        app.controller('PostController', function ($scope, $http) {
            this.postForm = function () {
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
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        }
                    })
                    .then(function (response) {
                            $scope.errorMsg = response.data.trim();
                    })
            }
        });

        app.directive("compareTo", function () {
            return {
                require: "ngModel",
                scope: {
                    confirmPassword: "=compareTo"
                },
                link: function (scope, element, attributes, modelVal) {
                    modelVal.$validators.compareTo = function (val) {
                        return (val == scope.confirmPassword);
                    };
                    scope.$watch("confirmPassword", function () {
                        modelVal.$validate();
                    });
                }
            };
        });
    </script>
</body>

</html>