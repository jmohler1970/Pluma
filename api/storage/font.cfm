







<!DOCTYPE html>
<html ng-app lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >

	<title>Font Test</title>
</head>

<body>

<cfset fontlist = "arial,helvetica,verdana,candara,calibri">


<cfoutput>
<table>
<tr>
	<th></th>
	<cfloop list="#fontlist#" index="i">
	<th>#i#</th>	
	</cfloop>
</tr>	

<cfloop from="12" to="5" step="-0.1" index="j">
<tr>
	<th>#j#</th>
	<cfloop list="#fontlist#" index="i">
	
		<td style="font-family : #i#; font-size : #j#px"><small>Total</small> The quick brown fox <b>jumped</b></td>
	
	</cfloop>	
</tr>
</cfloop>
</table>
</cfoutput>




</body>
</html>	
	
	


