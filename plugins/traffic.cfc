<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->

<cfcomponent extends="plugin">

<cfscript>

thisFile = listfirst(listlast(GetCurrentTemplatePath(), "\"), ".");




function Init()	{
this.register_plugin(thisFile, 
	'Traffic Tracker',
	'0.1',
	'James Mohler',
	'http://www.flikr.com/james_mohler/',
	'A traffic summary plugin for Pluma CMS. Loads traffic statistics',
	'',
	'',
	'icon-heart');


	this.add_action("pages_sidebar", "createSideMenu", ["?plugin=traffic", "Traffic Tracker"]);
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
