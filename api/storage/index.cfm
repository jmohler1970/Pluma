<cfscript>
wsNode 	= createobject("component", "Node");

	rc.Bundle = wsNode.getbundle({Slug = "Index"}, cgi.remote_addr, -1);
		
	writedump(rc);
	exit;

</cfscript>	
<cfexit>


<cfscript>
	wsPref 	= createobject("component", "Pref");


	
	rc.qryNode = wsPref.get();
		
	
	writedump(rc);

</cfscript>	
<cfexit>




<cfscript>
wsNode 	= createobject("component", "Node");

	rc.Bundle = wsNode.delete({NodeID = 109, Kind = "Facet"}, cgi.remote_addr, -1);
		
	writedump(rc);
	exit;

</cfscript>	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	rc.Bundle = wsNode.getByTag('new-york-city', 'Page');
		
	writedump(rc);
	exit;

</cfscript>	
<cfexit>
	


<cfsavecontent variable="x"> 
<?xml version="1.0" encoding="UTF-8"?> <Response> <Ip>142.136.11.230</Ip> <CountryCode>CA</CountryCode> <CountryName>Canada</CountryName> <RegionCode>QC</RegionCode> <RegionName>Québec</RegionName> <City>Dorval</City> <ZipCode>h9p1j3</ZipCode> <Latitude>45.45000076293945</Latitude> <Longitude>-73.75</Longitude> <MetroCode></MetroCode> <AreaCode></AreaCode> </Response>
</cfsavecontent>


<cfset x = REreplace(x, '[^\x00-\x7F]', '?', 'all')>


<cfquery>
	DECLARE @xml XML
	SET @xml = <cfqueryparam CFSQLType="cf_sql_varchar" value="#trim(x)#">
</cfquery>

<cfexit>


<cfset wsTraffic = createobject("component", "Traffic")>

<cfset wsTraffic.add(action =
			{
			SubSystem	= '',
			Section 	= '',
			Item 		= ''
			},
			remote_addr = cgi.remote_addr,
			url_vars				= Duplicate(url)
			)>

<cfexit>

<cfscript>
wsNode 	= createobject("component", "Node");

	rc.Bundle = wsNode.getLink(NodeID=102);
	rc.Bundle = wsNode.getLink(NodeID='a');
	rc.Bundle = wsNode.getLink(NodeID=1000);
	rc.Bundle = wsNode.getLink(NodeID='');
	
		
	writedump(rc);
	exit;

</cfscript>	
<cfexit>
	


<cfscript>
wsNode 	= createobject("component", "Node");

	rc.Bundle = wsNode.delete({NodeID=102}, "", "");
		
	writedump(rc);
	exit;

</cfscript>	
<cfexit>
	




<cfscript>
wsNode 	= createobject("component", "Node");

	rc.Bundle = wsNode.getBundle({Kind="Page", NodeID=100}, "", "");
		
	writedump(rc);
	exit;

	rc.qryNode = wsNode.LinkSave({Kind="Page", NodeID=100}, 
		{href_1="", key_1="",type_1="",value_1=""},
		"", "");
	
	
	rc.qryNode = wsNode.LinkSave({Kind="Page", NodeID=100}, 
		{href_1="http://dice.com", key_1="",type_1="Jobs",value_1="Dice"},
		"", "");
		

	
	rc.Bundle = wsNode.getBundle({Kind="Page", NodeID=100}, "", "");
		
	writedump(rc);

</cfscript>	
<cfexit>
	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.TaxonomyAdd("Link_Category", "Jobs", "", "");
		
	writedump(rc);

</cfscript>	
<cfexit>


<cfscript>
wsUser 	= createobject("component", "Users");

	rc = wsUser.addlog(20, "logout", cgi.remote_addr);

	
	writedump(rc);

</cfscript>	
<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getBundle({Slug = 'install'}, "", "");
		
	writedump(rc);

</cfscript>	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");


	
	result = wsNode.getByTag("Cat", 'Page');
	
	
	
	writedump(result);

</cfscript>	

<cfexit>


<cfset wsTraffic = createobject("component", "Traffic")>




<cfset wsTraffic.add(url_vars = {})>


<cfloop index="cache" array="#cacheGetAllIds()#">
    <cfdump var="#cacheGetMetadata(cache)#" label="Cache Metadata for #cache#">
</cfloop>


<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");


	
	result = wsNode.getByTag("Cat", 'Page');
	
	
	
	writedump(result);

</cfscript>	

<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getBundle({Slug = 'hosting'}, "", 1019);
		
	
	rc.qryNode = wsNode.TaxonomySave({NodeID = 385, Kind="Page"},
		 {tags = "webhosting", menustatus = 1, menu = 'Hosting'}, cgi.remote_addr, -1 );
	
	rc.qryNode = wsNode.getBundle({Slug = 'hosting'}, "", 1019);
	
	writedump(rc);

</cfscript>	
<cfexit>



<cfscript>
	wsPref 	= createobject("component", "Pref");


	
	rc.qryNode = wsPref.getPref("Plugin", "traffic");
		
	
	writedump(rc);

</cfscript>	
<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");

	NodeK = {NodeID = 385, Kind = "Page"};
	
	rc.qryNode = wsNode.getBundle(NodeK, "", 1019);
		
	
	writedump(rc);

</cfscript>	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	result = wsNode.getarchivedetails(57);

	result = wsNode.restorearchive(57, '', '');
		
	writedump(result);

</cfscript>	
<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");


	
	result = wsNode.deletearchive(57, '', '');
	
	
	
	writedump(result);

</cfscript>	

<cfexit>

<cfscript>
wsNode 	= createobject("component", "Node");


	
	result = wsNode.getarchive(97);
	
	
	
	writedump(result);

</cfscript>	

<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");


	
	result = wsNode.commit({Kind="Page"}, {title = "Welcome to PlumaCMS", pStatus = "Public"}, "", 1019);
	
	
	
	writedump(result);

</cfscript>	

<cfexit>




<cfscript>
wsUser 	= createobject("component", "Users");

	wsUser.atleastoneuser();

	
	rc.qryUser = wsUser.commit("", 
		{login = 'James', passhash = left(hash("kc"), 10), email = 'james@webworldinc.com', group = 'System'}, cgi.remote_addr, -1);
		
	
	writedump(rc);

</cfscript>	
<cfexit>




<cfscript>
wsUser 	= createobject("component", "Users");

	rc = wsUser.addlog(20, "logout", cgi.remote_addr);

	
	writedump(rc);

</cfscript>	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");


	
	rc.qryNode = wsNode.commit({Kind="Page"}, {title = "Welcome to PlumaCMS", pStatus = "Public"}, "", 1019);
	
	
	wsNode.getPageParent();	
	
	writedump(rc);

</cfscript>	

<cfexit>



<cfscript>
wsUser 	= createobject("component", "Users");

	rc = wsUser.getBundle(20);

	
	writedump(rc);

</cfscript>	
<cfexit>


<cfscript>
wsUser 	= createobject("component", "Users");

	rc = wsUser.getuserbylogin('Admin', '');

	
	
		
	
	writedump(rc);

</cfscript>	
<cfexit>




<cfscript>
wsUser 	= createobject("component", "Users");

	wsUser.atleastoneuser();

	
	rc.qryUser = wsUser.commit("", 
		{login = 'James', password = "", email = 'james@webworldinc.com', group = 'System'}, cgi.remote_addr, -1);
		
	
	writedump(rc);

</cfscript>	
<cfexit>





<cfscript>
wsSetup 	= createobject("component", "Setup");

	
	wsSetup.clear_all();
		
	

</cfscript>	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getDBDSN();
		
	
	writedump(rc);

</cfscript>	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	NodeK = {NodeID = 385, Kind = "Page"};
	
	rc.qryNode = wsNode.getBundle(NodeK, "", 1019);
		
	
	rc.qryNode = wsNode.XMLConfSave(NodeK, {},cgi.remote_addr, 1019);
	
	rc.qryNode = wsNode.getBundle(NodeK, "", 1019);
	
	writedump(rc);

</cfscript>	
<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getSitemap("", 8);
		
	
	writedump(rc);

</cfscript>	
<cfexit>




<cfset wsTraffic = createobject("component", "Traffic")>

<cfset wsTraffic.add(action =
			{
			SubSystem	= '',
			Section 	= '',
			Item 		= ''
			},
			remote_addr = cgi.remote_addr,
			url_vars				= Duplicate(url)
			)>

<cfexit>



<cfset wsUser 	= createobject("component", "Users")>

<cfset qryUsers = wsUser.getBundle('')>

<cfset writedump(qryUsers)>

<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getAllbyUserID("Page", 1019, "");
		
	
	writedump(rc);

</cfscript>	
<cfexit>




<cfset wsUser 	= createobject("component", "Users")>

<cfset qryUsers = wsUser.getAllbyUserID(1019)>

<cfset writedump(qryUsers)>

<cfexit>



<cfset wsUser 	= createobject("component", "Users")>

<cfset qryUsers = wsUser.getBundle(1019)>

<cfset writedump(qryUsers)>

<cfexit>




<cfscript>
wsNode 	= createobject("component", "Node");

	NodeK = {Kind = "Page"};
	
	rc.qryNode = wsNode.getBundle(NodeK, "", 1019);
		
	
	writedump(rc);

</cfscript>	
<cfexit>



<cfset wsUser 	= createobject("component", "Users")>

<cfset qryUsers = wsUser.getProfile(1019)>

<cfset writedump(qryUsers)>

<cfexit>



<cfset wsUser 	= createobject("component", "Users")>

<cfset qryUsers = wsUser.getUserByLogin('james', left(hash('powergoo'), 10))>

<cfset writedump(qryUsers)>

<cfexit>






<cfscript>
wsNode 	= createobject("component", "Node");

	NodeK = {NodeID = 384, Kind = "Page"};
	
	rc.qryNode = wsNode.getBundle(NodeK, "", 1019);
		
	
	writedump(rc);

</cfscript>	
<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");

	NodeK = {NodeID = 385, Kind = "Page"};
	
	rc.qryNode = wsNode.getBundle(NodeK, "", 1019);
	
	wsNode.doTouch(NodeK, 1019);	
	
	rc.qryNode = wsNode.XMLConfSave(NodeK, {}, 1019);
	
	rc.qryNode = wsNode.getBundle(NodeK, "", 1019);
	
	writedump(rc);

</cfscript>	
<cfexit>




<cfscript>
	rc.wsTraffic = CreateObject("component", "Traffic");

	rc.stForecas			= rc.wsTraffic.getTrafficDetails({startDate = '12/1/2012', endDate = '12/1/2013', mode="os", server_name=cgi.server_name});
	
//	rc.stOS			= rc.wsTraffic.getTrafficDetails({startDate = '10/1/2012', endDate = '12/1/2012', mode="os", server_name=cgi.server_name});

//	rc.stForecastUsers			= rc.wsTraffic.getTrafficDetails({startDate = '10/1/2012', endDate = '12/1/2012', mode="referer", server_name=cgi.server_name});
	
writedump(rc);
</cfscript>
<cfexit>










<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getBundle({Slug = 'hosting'}, "", 1019);
		
	

	
	writedump(rc);

</cfscript>	
<cfexit>



<cfset wsPref 	= createobject("component", "Pref")>



<cfscript>
rc = {
FIELDNAMES="META_TITLE,META_ROOT,META_DESCRIPTION,META_KEYWORDS,META_EMAIL,SUBMIT",
META_DESCRIPTION="",
META_EMAIL="",
META_KEYWORDS="",
META_ROOT="http://foundation.qcliving.com/index.cfm/",
META_TITLE="Pluma CMS by JM & WWI",
SUBMIT="Save"
	};
</cfscript>






<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getBundle({Slug = 'hosting'}, "", 1019);
		
	
	rc.qryNode = wsNode.TaxonomySave({NodeID = 385, tags = "webhosting", menustatus = 1, menu = 'Hosting', UserID = 1019});
	
	rc.qryNode = wsNode.getBundle({Slug = 'hosting'}, "", 1019);
	
	writedump(rc);

</cfscript>	
<cfexit>


<cfset wsUser 	= createobject("component", "Users")>	
	
<cfset wsUser.getOne('')>

<cfexit>




<cfset wsUser 	= createobject("component", "Users")>	
	
<cfset wsUser.getMatchlist('','','',0,0)>

<cfexit>







<cfscript>
wsNode 	= createobject("component", "Node");

	wsNode.getAll("Page", '', "Menu", 100);

	
//	rc.qryNode = wsNode.getBundle({Slug = 'hosting'}, "", 1019);
		
	
	rc.qryNode = wsNode.TaxonomySave({NodeID = 385, tags = "skip", facet = "skip",
		 menuorder = 7, menu = 'skip', UserID = 1019});
	
//	rc.qryNode = wsNode.getBundle({Slug = 'hosting'}, "", 1019);
	
	writedump(rc);

</cfscript>	
<cfexit>






<cfscript>
	wsNode 	= createobject("component", "Node");


	rc.qryNode = wsNode.getAll('Page', "All", 'Title', 100);
		
	
	
	writedump(rc);




	wsNode 	= createobject("component", "Node");


	rc.result = wsNode.getMatchlist("Blog", '', '', '', '', '', 0);



	rc.wsTraffic = CreateObject("component", "Traffic");
	rc.stForecastUsers			= rc.wsTraffic.getForecastUsers(now());
	
	


	wsNode 	= createobject("component", "Node");


	rc.data = EntityLoad("Node", {PrimaryRecord = 1});

	
	rc.qryNode = wsNode.getAll('Page', "All", 'Title', 100);
	
	
		
	
	
	writedump(rc);

</cfscript>	
<cfexit>




<cftry>
	<cfthrow>


	<cfcatch><cfdump var="#cfcatch#"></cfcatch>
</cftry>




<cfscript>
wsNode 	= createobject("component", "Node");

	
	rc.qryNode = wsNode.getBundle({Slug = 'home'}, "", 1019);
	
	
		
	
	
	writedump(rc);

</cfscript>	
<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	
	//rc.qryNode = wsNode.getBundle({NodeID = 64, Kind = "Page"}, "", 1019);
	
	
	rc.qryFuseaction 	= wsNode.getPageParent();	
	
	
	writedump(rc);

</cfscript>	
<cfexit>

<cfscript>
wsNode 	= createobject("component", "Node");

	
	//rc.qryNode = wsNode.getBundle({NodeID = 64, Kind = "Page"}, "", 1019);
	
	
	rc.qryFuseaction 	= wsNode.getMatchlist("Any", "", "", "", "", false, false);	
	
	
	writedump(rc);

</cfscript>	
<cfexit>


<cfset wsNode 	= createobject("component", "Node")>	
	
<cfset writedump(wsNode.setPlugin("Fake", 0))>

<cfexit>



<cfset wsNode 	= createobject("component", "Node")>	
	
<cfset writedump(wsNode.getBundle({nodeID = 8235}, "", 1019))>

<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");

	
	//rc.qryNode = wsNode.getBundle({NodeID = 64, Kind = "Page"}, "", 1019);
	
	
	rc.qryFuseaction 	= wsNode.getMatchlist("Page", "", "Any", "Any", "Any", false, true);	
	
	
	writedump(rc);

</cfscript>	
<cfexit>



<cfscript>
wsNode 	= createobject("component", "Node");

	rc.qryNode = wsNode.getOne({Extra = "Top", Kind = "Menu" }, "", 1019);
	
		writedump(rc);
	
	rc.qryNode = wsNode.getBundle({Extra = "Top", Kind = "Menu" }, "", 1019);
	
		
	
	
	writedump(rc);

</cfscript>	
<cfexit>


<cfset wsNode 	= createobject("component", "Node")>	
	
<cfscript>

	stGroup = wsNode.getBundleByFA("main.home", ''); 

	
	writedump(stGroup);
</cfscript>	

<cfexit>


<cfscript>
wsNode 	= createobject("component", "Node");
	
	rc.qryNode = wsNode.getOne({NodeID = "max", Kind = "Sitemap" } );
	
		
	rc.qrySiteMap = wsNode.getSiteMap(rc.qryNode.NodeID, 8); 
	
	writedump(rc);

</cfscript>	
<cfexit>

<cfscript> 
wsTraffic = createobject("component", "Traffic");

//wsTraffic.getHitSwitch(now(), "Year", "direct");



stFilter = {Type="Month", Date = now(), subsystem = ''};


rc.DirectVisitors 	= wsTraffic.getHitSwitch(now(), stFilter.Type, 'direct');
rc.OrganicVisitors 	= wsTraffic.getHitSwitch(now(), stFilter.Type, 'organic');
rc.ReferralVisitors = wsTraffic.getHitSwitch(now(), stFilter.Type, 'referral');
rc.BounceVisitors 	= wsTraffic.getHitSwitch(now(), stFilter.Type, 'bounce');


writedump(rc);

exit;

rc.stGraph			 = wsTraffic.getDetails(		stFilter);

rc.qryTopSectionItem = wsTraffic.getTopSectionItem(stFilter, 'nobot');
rc.qryOSBrowser		 = wsTraffic.getOSBrowser(	stFilter, 'nobot');
rc.qryBot			 = wsTraffic.getOSBrowser(	stFilter, 'bot');
rc.qryCountry		 = wsTraffic.getCountry(		stFilter, 'nobot');
rc.qryStateProv		 = wsTraffic.getStateProv(	stFilter, 'nobot');
rc.qryCity			 = wsTraffic.getCity(		stFilter, 'nobot');
</cfscript>

<cfexit>


<cfset wsNode 	= createobject("component", "Node")>	
	
<cfscript>

	stGroup = wsNode.NodeSave('', {
		Kind 	= "Page", 
		title 	= "CapMetro - MetroRail Red Line Stadler GTW 2/6 DMU", 
		src 	= "PQoD0b9axPQ",
		parentNodeID = 358},
		1019); 

	
	writedump(stGroup);
</cfscript>	




<cfset wsNode 	= createobject("component", "Node")>


<cfset wsNode.getAll("Event", 1, "ExpirationDate DESC", 100)>


<cfexit>
	
	
<cfscript>

	stGroup = wsNode.getAll("Category", "All", "Title", 100);

	
	writedump(stGroup);
</cfscript>	

<cfexit>





<cfset wsUser 	= createobject("component", "Users")>	
	
<cfset wsUser.getBundle(8235)>

<cfexit>



<cfexit>


<cfset wsNode 	= createobject("component", "Node")>	
	
<cfscript>

	stGroup = wsNode.getBundle(NodeID = 383, Kind = "Page", UserID = 1019); 

	
	writedump(stGroup);
</cfscript>	

<cfexit>



<cfset wsNode 	= createobject("component", "Node")>	
	
<cfscript>

	stGroup = wsNode.getBundleByFA("main.home", ''); 

	
	writedump(stGroup);
</cfscript>	

<cfexit>



<cfset wsNode 	= createobject("component", "Node")>	
	
<cfscript>

	stGroup = wsNode.getBundle(NodeID = 7846, Kind = "Page", UserID = 1019); 

	
	writedump(stGroup);
</cfscript>	

<cfexit>



<cfset wsUser 	= createobject("component", "Users")>	
	
<cfscript>

	stResult = wsUser.bulkChange({bulkuserid = 1154, subaction = 'renew:12'}, 1019); 


	stGroup = wsUser.getBundle(1019); 

	
	stGroup = wsUser.getstGroup(1019); 
	
	writedump(stGroup);
	
	writedump(StructIsEmpty(stGroup));
	
	wsUser.getCountByStatus();
	
	wsUser.getMatchlist("","","",0,0);
</cfscript>	

<cfexit>





<cfset wsNode 	= createobject("component", "Page")>

<cfset writedump(wsNode)>


<cfset  writedump(wsNode.getOne({NodeID = 4105, Kind = "Photo"}))>	

<cfset  writedump(wsNode.getSecondary())>	

<cfexit>





<cfset wsNode 	= createobject("component", "Page")>

<cfset writedump(wsNode)>


<cfset  writedump(wsNode.getOne({NodeID = 4105, Kind = "Photo"}))>	

<cfset  writedump(wsNode.getSecondary())>	

<cfexit>








<cfset wsNode 	= createobject("component", "Node")>

<cfset rc.qryJournal = wsNode.getOne({NodeID=4,Kind="Page"})>

<cfexit>


<cfscript> 
wsTraffic = createobject("component", "Traffic");

//wsTraffic.getHitSwitch(now(), "Year", "direct");



stFilter = {Type="Month", Date = now(), subsystem = ''};


rc.DirectVisitors 	= wsTraffic.getHitSwitch(now(), stFilter.Type, 'direct');
rc.OrganicVisitors 	= wsTraffic.getHitSwitch(now(), stFilter.Type, 'organic');
rc.ReferralVisitors = wsTraffic.getHitSwitch(now(), stFilter.Type, 'referral');
rc.BounceVisitors 	= wsTraffic.getHitSwitch(now(), stFilter.Type, 'bounce');


writedump(rc);

exit;

rc.stGraph			 = wsTraffic.getDetails(		stFilter);

rc.qryTopSectionItem = wsTraffic.getTopSectionItem(stFilter, 'nobot');
rc.qryOSBrowser		 = wsTraffic.getOSBrowser(	stFilter, 'nobot');
rc.qryBot			 = wsTraffic.getOSBrowser(	stFilter, 'bot');
rc.qryCountry		 = wsTraffic.getCountry(		stFilter, 'nobot');
rc.qryStateProv		 = wsTraffic.getStateProv(	stFilter, 'nobot');
rc.qryCity			 = wsTraffic.getCity(		stFilter, 'nobot');
</cfscript>

<cfexit>

<cfset wsTraffic.add(url_vars = {})>


<cfloop index="cache" array="#cacheGetAllIds()#">
    <cfdump var="#cacheGetMetadata(cache)#" label="Cache Metadata for #cache#">
</cfloop>


<cfexit>








<cfset wsNode 	= createobject("component", "Node")>


<cfset  writedump(wsNode.getBundle(2, "SubPage", ''))>







<cfexit>


<cfset wsNode 	= createobject("component", "Node")>

<cfset wsNode.getBundleByFA("hey", 0)>


<cfexit>



<cfset wsNode 	= createobject("component", "Node")>

<cfset rc.qryKindCount = wsNode.getKindCount2("All", "All")>


<cfdump var="#wsNode#">

<cfdump var="#rc#">

<cfexit>


<cfset wsNode 	= createobject("component", "Node")>

<cfset rc.qryJournal = wsNode.getJournal(100)>

<cfexit>



<cfset wsUser 	= createobject("component", "Users")>	
	
<cfscript>	
	rc.qryCommunity = wsNode.getAll("All", "Any", "ModifyDate DESC", 30); 
	
	rc.stKindCount 	= wsNode.getKindCount("Any", "Any");
	
	//rc.UserCount 	= wsUser.getCount();
</cfscript>	

<cfexit>


	

<cfset wsNode 	= createobject("component", "Node")>

<cfset wsNode.getBundleByFA("hey", 0)>


<cfexit>


<cfset wsUser 	= createobject("component", "Users")>

<cfset writedump(wsUser.getGroup())>


<cfexit>






<cfset wsNode 	= createobject("component", "Node")>


<cfset writedump(wsNode.LinkAdd(182, {LinkCategory = 'Job Beach', href= 'Lots and lots of text'}, 1019))>
<cfset writedump(wsNode.LinkDelete(182, {LinkCategory = 'Job Beach', href= 'Lots and lots of text'}, 1019))>

<cfexit>



<cfset wsNode 	= createobject("component", "Node")>

<cfset writedump(wsNode.NodeDelete("0,0,0",0))>

<cfexit>




<cfset wsNode 	= createobject("component", "Node")>

<cfset qryCategory = wsNode.getAll("Category", 1, "Title", 100)>

<cfexit>


<cfset wsTraffic = createobject("component", "Traffic")>

<cfexit>


<cfset wsNode 	= createobject("component", "Event")>

<cfset writedump(wsNode.NodeSave("", {Kind="fake", strData = "I have a cat"}, 100))>

<cfexit>




<cfset wsTraffic = createobject("component", "Traffic")>




<cfset wsTraffic.add(url_vars = {})>


<cfloop index="cache" array="#cacheGetAllIds()#">
    <cfdump var="#cacheGetMetadata(cache)#" label="Cache Metadata for #cache#">
</cfloop>


<cfexit>


<cfset wsBanner 	= createobject("component", "Banner")>

<cfscript>
	qryFutureBanner 	= wsBanner.getBanner("Future", 0, 1019);
	qryCurrentBanner = wsBanner.getBanner("Current", 0, 1019);
	qryPastBanner 	= wsBanner.getBanner("Past", 0, 1019);
</cfscript>


<cfexit>

<cfset wsNode 	= createobject("component", "Node")>



<cfset  writedump(wsNode.getBundle(352, "Subpage", 0))>



<cfset  wsNode.getAll("Category", 1, "Title", 100)>


<!--- fake node fake user --->
<cfset  wsNode.getBundleByFA('hi.mom', 0)>	
<cfset  wsNode.getBundleByFA('home:main.home', "~")>	



<!--- fake node fake user --->
<cfset  writedump(wsNode.NodeSave(0, {}, 21578))>	

<!--- fake node fake user --->
<cfset  writedump(wsNode.NodeSave(352, {Kind="Fake"}, 21578))>

<cfset  writedump(wsNode.NodeSave(1727, {Kind="Fake"}, 21578))>



<cfset wsNode 	= createobject("component", "Node")>


<!--- fake node fake user --->
<cfset  writedump(wsNode.NodeReactivate('', 21578))>	


<cfexit>



<cfset wsNode 	= createobject("component", "Page")>

<cfset writedump(wsNode)>


<cfset  writedump(wsNode.getBundle(8181, "SubPage"))>	


<cfexit>






<cfset wsUser 	= createobject("component", "Users")>

<cfset wsUser.getMatchlist("", "Contributor", "Any", 0, 0)>

<cfdump var="#wsUser#">


<cfexit>






<cfset wsUser 	= createobject("component", "Users")>

<cfset wsUser.setUser(1)>

<cfdump var="#wsUser#">

<cfset qryUsers = wsUser.getStGroup(1)>

<cfset writedump(qryUsers)>

<cfexit>


<cfset x = {}>

<cfset x["404"] = "hi mom">
<cfdump var="#x#">


<cfoutput>
#evaluate('x["404"]')#
#isdefined('x["404"]')#
</cfoutput>


<cfset wsNode 	= createobject("component", "Node")>
<cfset  writedump(wsNode.getFA("Market", "All"))>	
<cfexit>



<cfset wsNode 	= createobject("component", "Node")>



<cfset  writedump(wsNode.getBySearch("Market", "All"))>	


<cfexit>




<!--- Set the feed metadata. ---> 
<cfscript>
	wsNode 	= createobject("component", "Node");
	
	qryBlog = wsNode.getFeed("Blog");


	//stPref = this.wsPref.getGroup("Blog");


	p = {};
	p.version = "atom_1.0";
	
	p.title = {};
	p.title.type = "text";
	p.title.value = "Atom Title";


	p.subtitle = {};
	p.subtitle.type = "text";
	p.subtitle.value = "My Sub Title";
	
	p.category = [];
	p.category[1] = {};
	p.category[1].term = "Fun Stuff";
	
	p.author = [];
	p.author[1] = {};
	p.author[1].name = "Raymond Camden";
	p.author[1].uri = "http://www.coldfusionjedi.com";
	p.author[1].email = "ray@camdenfamily.com";
	
	p.updated = now();


	/*
	meta.title 		= stPref.rss_title; 
	meta.link 		= stPref.rss_link; 
	meta.description = stPref.rss_description;
	meta.version 	= stPref.rss_version; 
	*/

</cfscript>

 
<!--- Create the feed. ---> 
<cffeed action	="create"  
    query		="#qryBlog#"  
    properties	="#p#" 
    xmlvar		="rssXML"> 
 
<cfdump var="#XMLParse(rssXML)#">


<cfexit>




<cfset rc.wsComment 	= createobject("component", "Comment")>

<cfset rc.wsComment.getByKindpStatus("Blog", "Pending")>


<cfexit>




<cfset rc.wsPhoto 	= createobject("component", "Node")>

<cfset rc.wsPhoto.TagsSave(4190, "Average,CA Bay Area,PictureCD", 1019)>


<cfexit>





<cfset rc.wsTraffic 	= createobject("component", "Pref")>

<cfset result =  rc.wsTraffic.ClearAll()>

<cfdump var="#result#">

<cfexit>



<cfset rc.wsTraffic 	= createobject("component", "Banner")>

<cfset rc.wsTraffic.getAll()>


<cfexit>




<cfset rc.wsTraffic 	= createobject("component", "Traffic")>



<cfscript>
rc.DateType = "year";


rc.DirectVisitors 	= rc.wsTraffic.getHits(now(), rc.DateType, 'direct');
rc.OrganicVisitors 	= rc.wsTraffic.getHits(now(), rc.DateType, 'organic');
rc.ReferralVisitors = rc.wsTraffic.getHits(now(), rc.DateType, 'referral');

rc.BounceVisitors = rc.wsTraffic.getHits(now(), rc.DateType, 'bounce');
</cfscript>


<cfexit>


<cfset myTest 	= createobject("component", "Users")>



<cfset qryResult =  myTest.getUserByUserHomeAsQuery(1019)>
<cfset qryResult =  myTest.getUserByUserHomeAsQuery('')>
<cfset qryResult =  myTest.getUserByUserHomeAsQuery('James')>


<cfdump var="#qryResult#">


<cfexit>






<cfset myTest 	= createobject("component", "Users")>



<cfset qryResult =  myTest.decodeXMLProfile(1019)>

<cfdump var="#qryResult#">


<cfexit>






<cfset myTest 	= createobject("component", "Users")>



<cfset qryResult =  myTest.decodeXMLPref(1019)>

<cfdump var="#qryResult#">


<cfexit>



<cfset myTest 	= createobject("component", "Event")>


<!---
<cfset qryResult =  myTest.getCountByKind("Event", "All")>
--->

<cfset application.IOAPI.getAll('Category', "All", 'Title')>



<cfexit>



<cfset myTest 	= createobject("component", "Node")>



<cfset qryResult =  myTest.encodeStdXML(8150, {simple_location = 'Washington'}, 1918)>


<cfset qryResult =  myTest.decodeStdXMLByNodeID(8150)>



<cfset myTest 	= createobject("component", "Node")>



<cfset qryResult =  myTest.getAll("Event", "Title")>

<cfdump var="#qryResult#">


<cfexit>




<cfset myTest 	= createobject("component", "Node")>



<cfset qryResult =  myTest.doSortOrder("6142,6143,6144,6145,6146,6147,6148,6149",8081,21259)>

<cfdump var="#qryResult#">


<cfexit>




<cfset myTest 	= createobject("component", "Users")>



<cfset qryResult =  myTest.getByGroup("System")>

<cfdump var="#qryResult#">


<cfexit>

<!---
<cfset myTest.addContact({firstname='first', lastname='last'}, 1111)>
--->







<cfset myTest 	= createobject("component", "Node")>

<!---
<cfset myTest 	= CreateObject("webservice", "http://foundation.qcliving.com/resource/node.cfc?wsdl")>

--->


<cfset result = myTest.decodeStdXMLByNodeID(4146)>

<cfset myTest.NodeSave(2, result, 2)>

<!---



<cfset result2 = myTest.encodeStdXML(2, result)>


<cfdump  var="#result#">
<cfdump  var="#result2#">
<cfdump  var="#myTest#">
--->

