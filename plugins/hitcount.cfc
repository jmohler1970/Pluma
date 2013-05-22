
<cfcomponent>

<cfscript>
thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");



function Init()	{
	this.stPlugin_info = application.GSAPI.register_plugin(thisFile, 
	'Hit Count',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'A traffic summary plugin for PlumaCMS. Loads traffic statistics. Based on ',
	'',
	'',
	'icon-heart');


	application.GSAPI.add_action("pages_sidebar", "createSideMenu", ["?plugin=hitcount", "HITCOUNT/SIDEMENU", "hitcount"]);
	
	application.GSAPI.add_action('index-pretemplate', 'hitcount_header', ["hitcount"]);
	}	
</cfscript>


<cffunction name="hitcount_header" returnType="void">
	<cfargument name="rc" required="true" type="struct">	
	
	
	<cfset application.IOAPI.add_traffic(rc, rc._SubSystem, rc._Section, rc._item)>
	
</cffunction>	
	


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
		<cfinclude template="hitcount/referer.cfi">
	</cfsavecontent>
</cfcase>

<cfcase value="os">

	
	<cfset rc.qryTrafficDetails 	=	application.IOAPI.get_traffic_details(
		{startDate = rc.startDate, endDate = rc.endDate, mode="os"}
		)>

	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="hitcount/os.cfi">
	</cfsavecontent>
</cfcase>


<cfcase value="search">

	<cfset rc.qryTrafficDetails 	=	application.IOAPI.get_traffic_details(
		{startDate = rc.startDate, endDate = rc.endDate, mode="organic"}
		)>



	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="hitcount/search.cfi">
	</cfsavecontent>
</cfcase>

<cfcase value="country">
	
	<cfset rc.qryTrafficDetails 	=	application.IOAPI.get_traffic_details(
		{startDate = rc.startDate, endDate = rc.endDate, mode="country"}
		)>
	

	<cfsavecontent variable="variables.stResult.Content">
		<cfinclude template="hitcount/country.cfi">
	</cfsavecontent>
</cfcase>

<cfdefaultcase>


	
	<cfset rc.qryLastHits 		=	application.IOAPI.get_traffic_last_hits("All")>
	
	
	<cfset rc.qryTrafficDetails =	application.IOAPI.get_traffic_details({startDate = rc.startDate, endDate = rc.endDate})>
		
	<cfsavecontent variable="variables.stResult.Content">
		
		<cfinclude template="hitcount/home.cfi">
	
	</cfsavecontent>

</cfdefaultcase> 
</cfswitch>	
	
	
	
		
	<cfreturn variables.stResult>
</cffunction>

</cfcomponent>
