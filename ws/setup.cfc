
 	
 			
<cfcomponent>		
 	
 	
<cffunction name="getStatus" output="false" access="remote" returnType="string" hint="Is this object ready to read and write data">

	<cfreturn "">
</cffunction> 	
 	


 	
<cffunction name="clear_all" returnType="boolean" output="false" access="remote" hint="Clears everything">

	
	<cfquery>
	DELETE
	FROM 	dbo.Pref
	
	DELETE
	FROM	dbo.LoginLog
	
	DELETE
	FROM	dbo.Users
	

	DELETE
	FROM	dbo.NodeArchive
	
	DELETE
	FROM	dbo.Node
		
	DELETE
	FROM	dbo.Traffic
	</cfquery> 


	<cfreturn true>
</cffunction> 
 	
 	
	
 	
 
 </cfcomponent>	
 	