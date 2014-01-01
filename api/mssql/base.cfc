
 			
<cfcomponent>		



<cffunction name="encodeXML" output="no"  returnType="string">
	<cfargument name="data" required="true" type="struct">
		
	<!--- encode has two modes 
		
	data=simple
	----
	data=struct (href, rel, title, message)
	data.href = data.href
	--->

	<cfscript>
	local.qryData = QueryNew( "id, 	  position, status,  title,	  type,    href, 	rel, 	 time, cite,	message", 
							"varchar, integer,	varchar, varchar, varchar, varchar, varchar, date, varchar,	varchar");

	
	
	for (var MyKey in arguments.data)	{
		
		var shortField = listlast(MyKey, "_");
		
				
		if (shortField == "new")	{
			param arguments.data.new_title = "";

			shortField = reReplace(Data.new_title, "[^a-z0-9]_", "", "all");


			if (shortField == "" AND Data.new_title != "")	{
				return "A valid key could not be created from &quot;#xmlformat(arguments.data.new_title)#&quot;";
				}
			}
			// end of coming up with name	
		
		if (isStruct(arguments.data[MyKey]))	{
			mid			= structKeyExists(data[MyKey], "id") 		? 'data-id="#xmlFormat(data[MyKey].id)#"'				: "";
			mposition	= structKeyExists(data[MyKey], "position") 	? data[MyKey].position : '';
			mstatus		= structKeyExists(data[MyKey], "status") 	? 'data-status="#xmlFormat(data[MyKey].position)#"'		: "";
			mtitle		= structKeyExists(data[MyKey], "title")		? 'title="#xmlFormat(data[MyKey].title)#"'				: "";
				
			mhref		= structKeyExists(data[MyKey], "href") 		? 'href="#xmlFormat(data[MyKey].href)#"'				: "";	
			mrel		= structKeyExists(data[MyKey], "rel")  		? 'rel="#xmlFormat(data[MyKey].rel)#"'					: "";
			mdatetime	= structKeyExists(data[MyKey], "time")  	? '<time>#xmlFormat(data[MyKey].time)#</cite>'					: "";
			mcite		= structKeyExists(data[MyKey], "cite")  	? '<cite>#xmlFormat(data[MyKey].cite)#</cite>'			: "";
					
			mmessage	= structKeyExists(data[MyKey], "message")	? xmlFormat(data[MyKey].message)						: "";
			}	
		else if (isArray(MyKey))	{
			mid			= structKeyExists(MyKey, "id") 			? 'data-id="#xmlFormat(MyKey.id)#"'				: "";
			mposition	= structKeyExists(MyKey, "position") 	? MyKey.position : '';
			mstatus		= structKeyExists(MyKey, "status") 		? 'data-status="#xmlFormat(MyKey.position)#"'	: "";
			mtitle		= structKeyExists(MyKey, "title")		? 'title="#xmlFormat(MyKey.title)#"'			: "";
				
			mhref		= structKeyExists(MyKey, "href") 		? 'href="#xmlFormat(MyKey.href)#"'				: "";	
			mrel		= structKeyExists(MyKey, "rel")  		? 'rel="#xmlFormat(MyKey.rel)#"'				: "";
			mdatetime	= structKeyExists(MyKey, "time")  		? '<time>#xmlFormat(MyKey.time)#</cite>'		: "";
			mcite		= structKeyExists(MyKey, "cite")  		? '<cite>#xmlFormat(MyKey.cite)#</cite>'		: "";
				
			mmessage	= structKeyExists(data[MyKey], "message")	? xmlFormat(MyKey.message)					: "";
	
			}	
		else	{
			mid			= '';
			mposition 	= '';
			mstatus		= '';
			mtitle 		= '';
			
			mhref 		= '';			
			mrel 		= '';
			mdatetime	= '';
			mcite		= '';
						
			mmessage	= xmlformat(data[MyKey]);			
			}	
	
	
				
		QueryAddRow(local.qryData);
		QuerySetCell(local.qryData, "type", 		lcase(shortfield));
		
		QuerySetCell(local.qryData, "id", 			mid);
		QuerySetCell(local.qryData, "position", 	mposition);
		QuerySetCell(local.qryData, "status", 		mstatus);
		QuerySetCell(local.qryData, "title",	 	mtitle);
				
		QuerySetCell(local.qryData, "href", 		mhref);
		QuerySetCell(local.qryData, "rel", 			mrel);
		
		
		QuerySetCell(local.qryData, "message", 	mmessage);
		} // end for
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






