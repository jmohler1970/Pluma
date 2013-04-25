


<cfscript>
param rc.silent = 0;
</cfscript>

<cfif rc.silent><cfsetting showDebugOutput="No"><cfoutput>#body#</cfoutput><cfexit></cfif>




<!--- Normal output begins --->
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
	<meta charset="UTF-8" />

	<cfoutput>
	<title>#application.GSAPI.get_site_name()#</title>
	

		
	<!--[if lt IE 9]>
          <script src="/theme/thyroidologists/assets/js/html5shiv.js"></script>
    <![endif]-->


	
	<!-- Le styles -->
    <link rel="stylesheet" href="#application.GSAPI.get_site_root()#admin/layouts/css/jquery-ui.css" />
        
    <link href="#application.GSAPI.get_site_root()#admin/layouts/css/style.less"		rel="stylesheet/less" type="text/css" />
    <link href="#application.GSAPI.get_site_root()#admin/layouts/css/calendar.css"		rel="stylesheet/less" type="text/css" />
    
    <script src="#application.GSAPI.get_site_root()#admin/layouts/js/less.js" 		type="text/javascript"></script>
   
    <script src="#application.GSAPI.get_site_root()#admin/layouts/js/sorttable.js"	type="text/javascript"></script>
    
    <script src="#application.GSAPI.get_site_root()#admin/layouts/js/calendar_us.js" 	type="text/javascript"></script>
    
    
    <script src="#application.GSAPI.get_site_root()#admin/layouts/js/jquery.js" 		type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#admin/layouts/js/jquery-ui.js" 		type="text/javascript"></script>
	<script src="#application.GSAPI.get_site_root()#admin/layouts/js/application.js" 	type="text/javascript"></script>
	
</head>	


<cfif getSection() EQ "login">
	<body id="index">
<cfelse>
	<body id="#getSection()#">
</cfif>

<body id="#getSection()#">
</cfoutput>


<div class="header" id="header">

	<cfif session.LOGINAPI.lstGroup NEQ "">
    <div class="wrapper clearfix">


	
		<cfinclude template="top2.cfi">
	
	</div>
	</cfif>
	
	
</div>



<div class="wrapper">

	
	
	<cfif isDefined("session.qryMessageQueue")>
		<cfoutput query="session.qryMessageQueue">
			<cfswitch expression="#Priority#">
			<cfcase value="2,3">
				<div class="error">
					<b>Error:</b> #message#
				</div>	
			</cfcase>
			<cfcase value="1">
				<div class="updated">
					<b>Warning:</b> #message#
				</div>	
			</cfcase>
			<cfcase value="-1">
				<cfif isDebugMode()>
					<b>Debug:</b> #message#
				</cfif>
			</cfcase>
			
			<cfdefaultcase>
				<div class="updated">
					<b>Info:</b> #message#
				</div>	
			</cfdefaultcase> 
			</cfswitch>
		</cfoutput>
		
		<cfset StructDelete(session, "qryMessageQueue")>
	</cfif>


<div class="bodycontent clearfix">
	<div id="maincontent">
	

			
		<!--- FW/1 generates this --->	
		<cfoutput>#body#</cfoutput>
		
	</div><!--- main content --->
	
		
		<div id="sidebar">
			<cftry>
				<cfinclude template="sidebar-#getSection()#.cfi">
			<cfcatch><cfdump var="#cfcatch#"></cfcatch>
			</cftry>
		</div>
		

</div>






<div id="footer">
	<div class="footer-left">
		<p>&copy; <cfoutput>#Year(Now())# #application.GSAPI.get_site_credits()#</cfoutput>
	</p>
	</div>
	
	
	<div class="gslogo">
		<cfoutput>
	   		<a href="http://webworldinc.com/plumaCMS" target="_blank"><img src="#application.GSAPI.get_site_root()#admin/layouts/images/PlumaCMS_80x16.png" alt="PlumaCMS by James Mohler and Web World Inc."></a>
	    </cfoutput>
	</div>
	
	<div class="clear"></div>
</div>





</div><!-- /container -->




</body>
</html>



