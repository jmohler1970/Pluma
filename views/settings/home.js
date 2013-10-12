

// Configure application routes
Home.config(
	function ($routeProvider)	{
		
		// Map the routes to the HTML templates
		
		$routeProvider
			.when("/settings", 		{ templateURL: "settings.htm", 		controller: settingsCtrl 	})
			.when("/error404", 		{ templateURL: "error404.htm", 		controller: error404Ctrl 	})
			.when("/feedback", 		{ templateURL: "feedback.htm", 		controller: feedbackCtrl	})
			.when("/notification", 	{ templateURL: "notification.htm", 	controller: notificationCtrl})
			.when("/password", 		{ templateURL: "password.htm", 		controller: passwordCtrl 	})
			.when("/search", 		{ templateURL: "search.htm", 		controller: searchCtrl 		})
			
			
			.otherwise({ redirectTo: "/settings"})
			;
		}
		
	);	


// Controllers
function settingsCtrl($scope, $http, $location)	{
	$scope.data = [];
	
	
	
	$http.get('index.cfm/json/systemAdmins')
		.success(function(data)	{
			$scope.systemAdmins = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;
	
	
	
	$http.get('index.cfm/json/pref/meta')
		.success(function(data)	{
			$scope.data = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;
	

};




function error404Ctrl($scope, $http, $location)	{
	$scope.data = [];
	
	$http.get('index.cfm/json/systemAdmins')
		.success(function(data)	{
			$scope.systemAdmins = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;

	
	
	$http.get('index.cfm/json/pref/error404')
		.success(function(data)	{
			$scope.data = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;
	
};


function feedbackCtrl($scope, $http, $location)	{
	$scope.data = [];
	
	
	$http.get('index.cfm/json/systemAdmins')
		.success(function(data)	{
			$scope.systemAdmins = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;

	
	
	$http.get('index.cfm/json/pref/feedback')
		.success(function(data)	{
			$scope.data = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;
	

};

function notificationCtrl($scope, $http, $location)	{
	$scope.data = [];
	
	
	$http.get('index.cfm/json/systemAdmins')
		.success(function(data)	{
			$scope.systemAdmins = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;

	
	
	
	$http.get('index.cfm/json/pref/notification')
		.success(function(data)	{
			$scope.data = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;
	

};


function passwordCtrl($scope, $http, $location)	{
	$scope.data = [];
	
	};


function searchCtrl($scope, $http, $location)	{
	$scope.data = [];
	
	$http.get('index.cfm/json/pref/search')
		.success(function(data)	{
			$scope.data = data;
			}
		
		.error(function(data))	{
			console.log("Data load error");			
			})	
		;


};










