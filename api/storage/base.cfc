
 			
<cfcomponent>		



<cffunction name="encodeXML" output="no"  returnType="string">
	<cfargument name="data" required="true" type="array">
		

	<cfscript>
	var qryData = QueryNew("position, id, href, rel, title, message", "integer, varchar, varchar, varchar, varchar, varchar");

	
	
	for (var MyData in arguments.data)	{
			
		var shortField = listlast(MyData.title, "_");
				
		if (shortField == "new")	{
			param MyData.new_title = "";

			shortField = reReplace(MyData.new_title, "[^a-z0-9]_", "", "all");


			if (shortField == "" AND MyData.new_title != "")	{
				return "A valid key could not be created from &quot;#xmlformat(arguments.rc.new_title)#&quot;";
				}
			}
			// end of coming up with name	
			
				
		mposition	= structKeyExists(MyData, "position") 	? 'href="#xmlFormat(MyData.position)#"'	: "";	
		mhref		= structKeyExists(MyData, "href") 		? 'href="#xmlFormat(MyData.href)#"'		: "";	
		mhrel		= structKeyExists(MyData, "rel")  		? 'href="#xmlFormat(MyData.rel)#"'		: "";	
		mhtitle		= structKeyExists(MyData, "title")		? 'href="#xmlFormat(MyData.title)#"'	: "";	
			
	
				
		QueryAddRow(qryData);
		QuerySetCell(qryData, "position", 	mposition);
		QuerySetCell(qryData, "id", 		lcase(shortfield));
		QuerySetCell(qryData, "href", 		mhref);
		QuerySetCell(qryData, "rel", 		mrel);
		QuerySetCell(qryData, "title",	 	mtitle);
		QuerySetCell(qryData, "message", 	xmlformat(MyData.Message) );
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






