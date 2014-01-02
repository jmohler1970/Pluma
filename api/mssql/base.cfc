
 			
<cfcomponent>		



<cffunction name="encodeXML" returnType="string" output="false">
	<cfargument name="data" required="true" type="any">
		
	<!--- encode has the following modes 
	data=[{credential = {href = 'x', rel = 'x', title = 'x', message = 'x', ...}}]
	Ex: data[1].credential.title
	
	
	data={credential = {href = 'x', rel = 'x', title = 'x', message = 'x', ...}}
	Ex: data.credential.title
	
	data={credential = 'x'}
	Ex: data.credential
	
	--->


	<cfscript>
	local.qryData = QueryNew( "id, 	  position, status,  title,	  type,    href, 	rel, 	 time, cite,	message", 
							"varchar, integer,	varchar, varchar, varchar, varchar, varchar, date, varchar,	varchar");

	
	if (not isArray(arguments.data))	{
		arguments.data = [arguments.data];			
		}	
	
	
	for (var MyAr in arguments.data)	{ 	// array, even if only one element
				
		for (var MyKeyName in MyAr)	{		// struct always	
			MyKey = MyAr[MyKeyName];		// struct or simple 
			
			if (isStruct(MyKey))	{		
				mtype		= structKeyExists(MyKey, "type")		? MyKey.type										: MyKeyName;			
				mid			= structKeyExists(MyKey, "id") 			? 'data-id="#xmlFormat(MyKey.id)#"'					: "";
				mposition	= structKeyExists(MyKey, "position") 	? MyKey.position 									: "";
				mstatus		= structKeyExists(MyKey, "status") 		? 'data-status="#xmlFormat(MyKey.position)#"'		: "";
				mtitle		= structKeyExists(MyKey, "title")		? 'title="#xmlFormat(MyKey.title)#"'				: "";
				
				mhref		= structKeyExists(MyKey, "href") 		? 'href="#xmlFormat(MyKey.href)#"'					: "";	
				mrel		= structKeyExists(MyKey, "rel")  		? 'rel="#xmlFormat(MyKey.rel)#"'					: "";
				mdatetime	= structKeyExists(MyKey, "time")  		? '<time>#xmlFormat(MyKey.time)#</time>'			: "";
				mcite		= structKeyExists(MyKey, "cite")  		? '<cite>#xmlFormat(MyKey.cite)#</cite>'			: "";
						
				mmessage	= structKeyExists(MyKey, "message")		? xmlFormat(MyKey.message)							: "";
				}
			else	{
				mType =  MyKeyName;
				mid = '';
				mposition = '';
				mstatus = '';
				mtitle = '';
				mhref = '';
				mrel = '';
				mdatetime = '';
				mmessage = MyKey;
				}		
	
		
		
			/* load into temp table */		
			QueryAddRow(local.qryData);
			QuerySetCell(local.qryData, "type", 		mtype);
			
			QuerySetCell(local.qryData, "id", 			mid);
			QuerySetCell(local.qryData, "position", 	mposition);
			QuerySetCell(local.qryData, "status", 		mstatus);
			QuerySetCell(local.qryData, "title",	 	mtitle);
					
			QuerySetCell(local.qryData, "href", 		mhref);
			QuerySetCell(local.qryData, "rel", 			mrel);
			
			
			QuerySetCell(local.qryData, "message", 	mmessage);
		
			} // end for struct
		} // end for array
	</cfscript>
	
	
	<cfquery name="local.qryData" dbtype="query">
		SELECT 	[position], type, id, status, href, rel, title, message
		FROM 	qryData
		WHERE	type <> ''
		AND		type <> 'title'
		ORDER BY [position]
	</cfquery>
	
	<cfsavecontent variable="xmlData">
	<ul class="xoxo">
	<cfoutput query="local.qryData">
		<cfif href EQ '' AND rel EQ ''>
			<li #id# #status# #title#><b>#type#</b> <var>#xmlformat(message)#</var></li>
		<cfelse> 
			<li #id# #status# #title#><b>#type#</b> <a #href# #rel#>#xmlformat(message)#</a></li>
		</cfif>		
	</cfoutput> 
	</ul>
	</cfsavecontent>
	
	
	<cfreturn trim(xmlData)>
</cffunction>


</cfcomponent>






