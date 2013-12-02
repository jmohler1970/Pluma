
 			
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
	var qryData = QueryNew("position, id, href, rel, title, message", "integer, varchar, varchar, varchar, varchar, varchar");

	
	
	for (var MyKey in arguments.data)	{
			
		var shortField = listlast(MyKey, "_");
		
				
		if (shortField == "new")	{
			param data.new_title = "";

			shortField = reReplace(Data.new_title, "[^a-z0-9]_", "", "all");


			if (shortField == "" AND Data.new_title != "")	{
				return "A valid key could not be created from &quot;#xmlformat(arguments.data.new_title)#&quot;";
				}
			}
			// end of coming up with name	
		
		if (isStruct(arguments.data[MyKey]))	{
			mposition	= structKeyExists(data[MyKey], "position") 	? 'href="#xmlFormat(data[MyKey].position)#"'	: "";	
			mhref		= structKeyExists(data[MyKey], "href") 		? 'href="#xmlFormat(data[MyKey].href)#"'		: "";	
			mrel		= structKeyExists(data[MyKey], "rel")  		? 'href="#xmlFormat(data[MyKey].rel)#"'			: "";	
			mtitle		= structKeyExists(data[MyKey], "title")		? 'href="#xmlFormat(data[MyKey].title)#"'		: "";	
			mmessage	= structKeyExists(data[MyKey], "message")	? 'href="#xmlFormat(data[MyKey].message)#"'		: "";
			}	
		else	{
			mposition 	= '';
			mhref 		= '';			
			mrel 		= '';			
			mtitle 		= '';			
			mmessage	= xmlformat(data[MyKey]);			
			
			}	
	
	
				
		QueryAddRow(qryData);
		QuerySetCell(qryData, "position", 	mposition);
		QuerySetCell(qryData, "id", 		lcase(shortfield));
		QuerySetCell(qryData, "href", 		mhref);
		QuerySetCell(qryData, "rel", 		mrel);
		QuerySetCell(qryData, "title",	 	mtitle);
		QuerySetCell(qryData, "message", 	mmessage);
		} // end for
	</cfscript>
	
	<cfquery name="qryData" dbtype="query">
		SELECT 	[position], id, href, rel, title, message
		FROM 	qryData
		WHERE	id <> ''
		ORDER BY [position]
	</cfquery>
	
	<cfsavecontent variable="xmlData">
	<ul class="xoxo">
	<cfoutput query="qryData">
		<cfif href EQ '' AND rel EQ ''>
			<li #title#><b>#id#</b> <var>#xmlformat(message)#</var></li>
		<cfelse> 
			<li #title#><b>#id#</b> <a #href# #rel#>#xmlformat(message)#</a></li>
		</cfif>		
	</cfoutput> 
	</ul>
	</cfsavecontent>
	
	
	<cfreturn trim(xmlData)>
</cffunction>


</cfcomponent>






