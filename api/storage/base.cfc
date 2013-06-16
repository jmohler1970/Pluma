
 			
<cfcomponent extends="nodero">		



<cffunction name="encodeXML" output="no"  returnType="string">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="filter" required="false" type="string" default="">
	

	<cfscript>
	var qryData = QueryNew("category, position, href, title, message", "varchar,integer,varchar,varchar,varchar");

	
	
	param rc.fieldnames = structkeyList(rc); // If this did not come from a form submit, then make a default list
	
	param rc.fieldsort = rc.fieldnames; // If an explicit sort was passed over, use it
	
	
	
	for (var MyFormField in rc)	{
			
		if (ListFindNoCase("action,submit,fieldnames,fieldsort", MyFormField) == 0
			AND NOT MyFormField CONTAINS "href"
			AND NOT MyFormField CONTAINS "title"
			)	{
			if (MyFormField CONTAINS arguments.filter OR arguments.filter EQ "")	{
				
				position = ListFindNoCase(rc.fieldsort, MyFormField); 
				
				var href = "";
				if (isDefined("rc.#myFormField#_href"))	{							
					var href_field = xmlFormat(arguments.rc["#MyFormField#_href"]);
					
					href = 'href="#href_field#"';							
					}								
				
				
				var title = "";
				if (isDefined("rc.#myFormField#_title"))	{							
					var title_field = xmlFormat(arguments.rc["#MyFormField#_title"]);
					
					href = 'title="#title_field#"';							
					}								
				
				QueryAddRow(qryData);
				QuerySetCell(qryData, "category", 	lcase(MyFormField));
				QuerySetCell(qryData, "position", 	position);
				QuerySetCell(qryData, "href", 		href);
				QuerySetCell(qryData, "title", 		title);
				QuerySetCell(qryData, "message", 	message);
				} // end if
			} //end if
		} // end for
	</cfscript>
	
	<cfquery name="qryData" dbtype="query">
		SELECT 	category, position, href, title, message
		FROM 	qryData
		ORDER BY position
	</cfquery>
	
	<cfsavecontent variable="xmlData">
	<ul class="xoxo">
	<cfoutput query="qryData" group="category">
		<li>#xmlFormat(category)#
		<ul>
		<cfoutput>
			<li><a #href# #title#>#message#</a></li>	
		</cfoutput>
		</ul>
		</li>
	</cfoutput> 
	</ul>
	</cfsavecontent>
	
	
	<cfreturn trim(xmlData)>
</cffunction>


</cfcomponent>






