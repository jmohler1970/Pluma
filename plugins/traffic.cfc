
<cfcomponent>

<cfscript>

thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");




function Init()	{
application.GSAPI.register_plugin(thisFile, 
	'Traffic Tracker',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'A traffic summary plugin for Pluma CMS. Loads traffic statistics',
	'',
	'',
	'icon-heart');


	application.GSAPI.add_action("pages_sidebar", "createSideMenu", ["?plugin=traffic", "Traffic Tracker"]);
	}	
</cfscript>





<cffunction name="settings" returnType="struct">
	<cfargument name="rc" required="true" type="struct">	

	<cfscript>
	param rc.startDate 	= LSDateformat(DateAdd("m", -1, now()), "mm/dd/yyyy");
	param rc.endDate 	= LSDateformat(now(), "mm/dd/yyyy");
	
	
	// old school
	param rc.DateType = "Month";
	param rc.mode = "";
	param rc.filterDate = now();
	param rc.filterSubSystem = "";
	param rc.filterSection = "";
	param rc.filterItem = "";
	
	
	switch(rc.mode)	{
		case "Today" :
			rc.DateType = "Day";
			rc.filterDate = now();
			break;
		 
		case "ThisMonth" :
			rc.DateType = "Month";
			rc.filterDate = now();
			break;
			
		case "ThisYear" :
			rc.DateType = "Year";
			rc.filterDate = now();
			break;
		}

	var stFilter = {
		Type		= rc.dateType,
		Date 		= rc.filterDate, 
		Subsystem 	= rc.filterSubSystem,
		Section 	= rc.filterSection,
		Item 		= rc.filterItem
		};


	</cfscript>
	
<cfswitch expression="#rc.plx#">
<cfcase value="referer">

	<cfset rc.qryTrafficDetails 	=	application.IOAPI.get_traffic_details(
		{startDate = rc.startDate, endDate = rc.endDate, mode="referer", server_name = cgi.server_name}
		)>



	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="traffic/referer.cfm">
	</cfsavecontent>
</cfcase>

<cfcase value="os">

	
	<cfset rc.qryTrafficDetails 	=	application.IOAPI.get_traffic_details(
		{startDate = rc.startDate, endDate = rc.endDate, mode="os"}
		)>

	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="traffic/os.cfm">
	</cfsavecontent>
</cfcase>


<cfcase value="search">

	<cfset rc.qryTrafficDetails 	=	application.IOAPI.get_traffic_details(
		{startDate = rc.startDate, endDate = rc.endDate, mode="organic"}
		)>



	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="traffic/search.cfm">
	</cfsavecontent>
</cfcase>

<cfcase value="country">
	
	<cfset rc.qryTrafficDetails 	=	application.IOAPI.get_traffic_details(
		{startDate = rc.startDate, endDate = rc.endDate, mode="country"}
		)>
	

	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="traffic/country.cfm">
	</cfsavecontent>
</cfcase>

<cfdefaultcase>


	
	<cfset rc.qryLastHits 		=	application.IOAPI.get_traffic_last_hits("All")>
	
	
	<cfset rc.qryTrafficDetails =	application.IOAPI.get_traffic_details({startDate = rc.startDate, endDate = rc.endDate})>
		
	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="traffic/home.cfm">
	
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	
	
	
	
		
	<cfreturn variables.stResult>
</cffunction>

</cfcomponent>
