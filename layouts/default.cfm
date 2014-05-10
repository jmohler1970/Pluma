

<!--- Normal output begins --->

<cfif getSection() NEQ "login">
	<cfset application.GSAPI.exec_action("admin-pre-header")>	
</cfif>

<!DOCTYPE html>
<html ng-app lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" >


	<cfoutput>
	<title>#application.GSAPI.get_site_name()# 
		<cfif isDebugMode()>#getSection()#/#getItem()# (#cgi.request_method#)</cfif>
	</title>
	
	
	<!-- Le styles -->
	<link href="#application.GSAPI.get_site_root()#layouts/jquery/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />
  
	<link href="#application.GSAPI.get_site_root()#layouts/css/style.cfm"		rel="stylesheet" type="text/css" media="screen"   />
    <link href="#application.GSAPI.get_site_root()#layouts/css/more.css"		rel="stylesheet" type="text/css" />
	
  
	
    <script src="#application.GSAPI.get_site_root()#layouts/js/sorttable.js"	type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#layouts/jquery/jquery.js" 		type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#layouts/jquery/jquery-ui.js" 	type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#layouts/jquery/angular.js" 	type="text/javascript"></script>

	<script src="#application.GSAPI.get_site_root()#layouts/jquery/application.js" 	type="text/javascript"></script>

	
	<!--- AngularJS needs these --->
	<cfif FileExists("#application.GSROOTPATH#views/#getSection()#/#getItem()#.js")>
		<script type="text/javascript" src="#application.GSAPI.get_site_root()#views/#getSection()#/#getItem()#.js"></script>
	</cfif>	

    
    
    <cfif getSection() NEQ "login">
		#application.GSAPI.exec_action("admin-pre-header")#	
	</cfif>
    

</head>	


<cfif getSection() EQ "login">
	<body id="index">
<cfelseif getSection() EQ "users">
	<body id="load"><!--- This is so that the default CSS files does not have to be altered --->
<cfelse>
	<body id="#getSection()#">
</cfif>




<div class="header" id="header">

	<cfif ArrayLen(session.LOGINAPI.arGroup) GT 0>
    <div class="wrapper clearfix">

	<cfif getSection() NEQ "login">
		#application.GSAPI.exec_action("header-body")#
	</cfif>	
	
		<cfinclude template="include-nav.cfi">
	
	</div>
	</cfif>
	
	
</div>
</cfoutput>


<div class="wrapper">

	
	
	<cfif isDefined("session.qryMessageQueue")>
		<cfoutput query="session.qryMessageQueue">
			<cfswitch expression="#Priority#">
			<cfcase value="3,4">
				<div class="error">
					#message#
				</div>	
			</cfcase>
			<cfcase value="2">
				<div class="warning">
					#message#
				</div>	
			</cfcase>
			
			<cfcase value="1">
				<div class="success">
					#message#
				</div>	
			</cfcase>
			<cfcase value="-1">
				<cfif isDebugMode()>
					<b>Debug:</b> #message#
				</cfif>
			</cfcase>
			
			<cfdefaultcase>
				<div class="updated">
					#message#
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
	</div>

	
	<div id="sidebar"> 
	
		<cfif fileexists("#application.GSROOTPATH#layouts/sidebar-#getSection()#.cfi")>
			<cfinclude template="sidebar-#getSection()#.cfi">
		</cfif>
	</div>
</div>




<cfoutput>
<div id="footer">
	<div class="footer-left">
		<p>&copy; #Year(Now())# #application.GSAPI.get_site_credits()#
	</p>
	</div>
	
	
	<div class="gslogo">
		
	   		<a href="https://github.com/jmohler1970/Pluma" target="_blank"><img src="#application.GSAPI.get_site_root()#layouts/css/images/PlumaCMS_80x16.png" alt="PlumaCMS by James Mohler and Web World Inc."></a>
	   
	</div>
	
	<div class="clear"></div>
	
	<cfif getSection() NEQ "login">
		
		#application.GSAPI.exec_action("footer")#	
	</cfif>
</div>
</cfoutput>




</div><!-- /container -->



</body>
</html>



