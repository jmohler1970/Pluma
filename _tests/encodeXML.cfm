

<cffunction name="encodeXML" returnType="string" output="false">
	<cfargument name="data" required="true" type="any">
		

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


<h2>Testing encodeXML</h2>

<p>The idea is:</p>

<ul>
	<li>You could have an array or a single</li>
	<li>Struct</li>
	<li>That struct has a set of names and values OR has a yet another struct(st2)</li>
</ul>

<p>The array is free form and while each element has an index number, we discard that index number. If what you send in is not an array, we force it into a fake array at position 1.</p>

<p>The struct part of all this has a name, which depending on what a particular key has, may or may not be used</p>



<cfscript>


// type: struct shallow
data = {};
data.football = 'x';
data.baseball = 'y';
data.soccer = 'z';

writedump(data);
writedump(encodeXML(data));



// type: array struct shallow
data = [];
data[1] = {};
data[1].Name = "Tom";
data[2] = {};
data[2].Name = "Dick";
data[3] = {};
data[3].Name = "Harry";

writedump(data);
writedump(encodeXML(data));


// type: struct shallow + keys
data = {};
data.Link.type		= "Search";
data.Link.href 	= "http://google.com";
data.Link.message 	= "Google";

writedump(data);
writedump(encodeXML(data));



// type: array struct shallow + keys
data = [];
data[1] = {};
data[1].Link.type 	= "Search";
data[1].Link.href 	= "http://google.com";
data[1].Link.message = "Google";
data[2] = {};
data[2].Link.type 	= "Search";
data[2].Link.href 	= "http://yahoo.com";
data[2].Link.message = "Yahoo!";
data[3] = {};
data[3].Link.type 	= "Job";
data[3].Link.href	= "http://dice.com";
data[3].Link.message = "Dice.com";
	
writedump(data);
writedump(encodeXML(data));


</cfscript>	
