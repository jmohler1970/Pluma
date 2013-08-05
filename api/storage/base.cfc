
 			
<cfcomponent>		



<cffunction name="encodeXML" output="no"  returnType="string">
	<cfargument name="rc" required="true" type="struct">
	<cfargument name="filter" required="false" type="string" default="">
	

	<cfscript>
	var qryData = QueryNew("position, id, href, rel, title, message", "integer, varchar, varchar, varchar, varchar, varchar");

	
	
	param rc.fieldnames = structkeyList(rc); // If this did not come from a form submit, then make a default list
	
	param rc.fieldsort = rc.fieldnames; // If an explicit sort was passed over, use it
	
	
	for (var MyFormField in rc)	{
			
		if (ListFindNoCase("action,submit,fieldnames,fieldsort", MyFormField) == 0
			AND NOT MyFormField CONTAINS "href"
			AND NOT MyFormField CONTAINS "title"
			)	{
			if (MyFormField CONTAINS arguments.filter OR arguments.filter EQ "")	{
			
				var shortField = listrest(MyFormField , "_");
				
				if (shortField == "new")	{
					param arguments.rc.new_title = "";

					shortField = reReplace(arguments.rc.new_title, "[^a-z0-9]_", "", "all");


					if (shortField == "" AND arguments.rc.new_title != "")	{
						return "A valid key could not be created from &quot;#xmlformat(arguments.rc.new_title)#&quot;";
						}


					if (ListFindNoCase(shortfield, structKeyList(rc)))	{
						return "A key could not be added because it already exists";
						}

					}
				// end of coming up with name	
			
				
				mposition = ListFindNoCase(rc.fieldsort, MyFormField); 
				
				var mhref = "";
				if (isDefined("rc.#myFormField#_href"))	{							
					mhref = xmlFormat(arguments.rc["#MyFormField#_href"]);
					
					mhref = 'href="#href_field#"';							
					}								
				
				var mrel = "";
				if (isDefined("rc.#myFormField#_rel"))	{							
					mrel = xmlFormat(arguments.rc["#MyFormField#_rel"]);
					
					mrel = 'rel="#rel_field#"';							
					}
				
				
				var mtitle = ""; // overridable
				
				if (isDefined("rc.#myFormField#_title"))	{							
					mtitle = xmlFormat(arguments.rc["#MyFormField#_title"]);
					
					mtitle = 'title="#title_field#"';							
					}								
				
				QueryAddRow(qryData);
				QuerySetCell(qryData, "position", 	mposition);
				QuerySetCell(qryData, "id", 		lcase(shortfield));
				QuerySetCell(qryData, "href", 		mhref);
				QuerySetCell(qryData, "rel", 		mrel);
				QuerySetCell(qryData, "title",	 	mtitle);
				QuerySetCell(qryData, "message", 	xmlformat(evaluate("rc.#MyFormField#")));
	
				} // end if
			} //end if
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






