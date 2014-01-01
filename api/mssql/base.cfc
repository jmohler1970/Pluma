
 			
<cfcomponent>		



<cffunction name="encodeXML" returnType="string" output="false">
	<cfargument name="data" required="true" type="array" hint="accepts only arrays of structs">
		
	<!--- encode has one mode 
	data=[{mything = {href, rel, title, message, ...}}]
	
	Ex: profile[1].credential.title
	--->


	<cfscript>
	local.qryData = QueryNew( "id, 	  position, status,  title,	  type,    href, 	rel, 	 time, cite,	message", 
							"varchar, integer,	varchar, varchar, varchar, varchar, varchar, date, varchar,	varchar");

	
	
	for (var MyAr in arguments.data)	{
				
		for (var MyKeyName in MyAr)	{		
			MyKey = MyAr[MyKeyName];			
			
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






