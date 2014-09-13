<!---@ Description: The Controller and the ORM are expected to have the same name. ORM by default uses the same name as the table. If it not, the ORM should be overwitten, not the the scaffold --->




	<cfcomponent hint="this is expected to be extended, and never used directly">
	
	
	
	<cfscript>
	function init(fw) { 
		variables.fw = fw;
		}
		
		
	void function before()	{
		
		variables.entityName 	= ListLast( GetMetaData(this).fullname, "." );
		variables.propertyNames = ORMGetSessionFactory().getAllClassMetadata()[ variables.entityName ].getPropertyNames();	
		}	
		
		
	
	void function home (required struct rc) output="false"	{
	
		rc.entResult = EntityLoad(variables.entityName); /* Sort by PK? */		
		setView("scaffold.home");
		}
		
		
		
	void function add (required struct rc) output="false"	{
	
		rc.entResult = EntityNew(variables.entityName);
	
		if(cgi.request.method == "post")	{
			
			
			rc.entResult.setSomething(rc.Something); // Do something better than this			
						
			EntitySave(rc.entResult);
			
			/* add message */	
						
			}	
	
		setView("scaffold.add");
		}
	
	
	void function edit (required struct rc) output="false"	{
	
		rc.entResult = EntityLoadByPK(variables.entityName, rc.id);
	
		if (cgi.request_method == "post")	{
						
			rc.entResult.setSomething(rc.Something); // Do something better than this			
						
			EntitySave(rc.entResult);
			
			/* add message */			
			}
	
	
		setView("scaffold.edit");
		}
	



	</cfscript>
	
	
	</cfcomponent>


