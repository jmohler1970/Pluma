

<cfscript>
param splash = "";
param prebody = "";
</cfscript>

<!--- Normal output begins --->
<!--- Normal output begins --->
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<head>
	<meta charset="UTF-8" />


<cfoutput>
	<title>#application.GSAPI.get_site_name()#</title>
	#application.GSAPI.get_header()#

	<meta name="email" 			content="#application.GSAPI.get_site_email()#" />
	
</cfoutput>	
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
	<!--[if lt IE 9]>
          <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->


	<cfoutput>
	<!-- Le styles -->
   	<link href="#application.GSAPI.get_site_root()#theme/bootswatch/css/bootstrap.css" rel="stylesheet" />
    <link href="#application.GSAPI.get_site_root()#theme/bootswatch/css/bootstrap-responsive.css" rel="stylesheet" />
    <link href="#application.GSAPI.get_site_root()#theme/bootswatch/css/docs.css" 		rel="stylesheet" />
    <link href="#application.GSAPI.get_site_root()#theme/bootswatch/css/prettify.css" 	rel="stylesheet" />
    <cfif not isnull(request.stBootswatch.css) and request.stBootswatch.css NEQ "">
    	<link href="#application.GSAPI.get_site_root()#theme/bootswatch/css/#request.stBootswatch.css#" 	rel="stylesheet" />
   	</cfif>
    <link href="#application.GSAPI.get_site_root()#theme/bootswatch/css/calendar.css" 	rel="stylesheet" />


	
	
		<style type="text/css">
		body	{
			<cfif not isnull(request.stBootswatch.Backgroundcolor)>
				<cfif request.stBootswatch.backgroundcolor NEQ "">background-color : #request.stBootswatch.backgroundcolor#;</cfif>
			</cfif>
			<cfif not isnull(request.stBootswatch.Backgroundimage)>
				<cfset background = "#application.GSAPI.get_site_root()#theme/bootswatch/assets/background/#request.stBootswatch.backgroundimage#">
			
				<cfif request.stBootswatch.backgroundimage NEQ "">background-image : url('#background#');</cfif>
			</cfif>
			<cfif not isnull(request.stBootswatch.Backgroundrepeat)>background-repeat : #request.stBootswatch.backgroundrepeat#;</cfif>
			<cfif not isnull(request.stBootswatch.Backgroundattachment)>
				<cfif request.stBootswatch.backgroundattachment EQ 1>background-attachment : fixed;</cfif>
			</cfif>
			} 
		</style>  
	

	
	
    <!-- Le javascript
    ================================================== -->
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/less.js"  type="text/javascript"></script> 
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/sorttable.js" type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/calendar_us.js" type="text/javascript"></script>
    
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/jquery.js" type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-transition.js" type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-modal.js" type="text/javascript"></script>
	<script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-dropdown.js" type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-scrollspy.js" type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-carousel.js" type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-collapse.js" type="text/javascript"></script>
    <script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-tooltip.js" type="text/javascript"></script>
	<script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/bootstrap-popover.js" type="text/javascript"></script>
	<script src="#application.GSAPI.get_site_root()#theme/bootswatch/js/application.js" type="text/javascript"></script>

		
	<link rel="start"  	href="#application.GSAPI.find_url('')#" />
	<link rel="search"  href="#application.GSAPI.find_url('search')#" />
	<link rel="toc" 	href="#application.GSAPI.find_url('toc')#" />
	
	</cfoutput>
</head>	


<body data-spy="scroll" data-target=".subnav" data-offset="50">

	<cfinclude template="top.cfi">


<div class="container">

<cfoutput>#splash#</cfoutput>
	



	
<!-- Masthead
================================================== -->
<header class="jumbotron subhead" id="overview">
 
  	<h1 id="title"><cfoutput>#application.GSAPI.get_page_title()#</cfoutput></h1>
 
	
 	<!--- hold place even if blank. Javascript may come in later to set it --->
 	<p class="lead" id="lead"><cfoutput>#application.GSAPI.get_page_subtitle()#</cfoutput></p>
</header>




<div class="row">

	<cfif isDefined("session.qryMessageQueue")>
		<cfoutput query="session.qryMessageQueue">

			<div class="span2">&nbsp;</div>
			<div class="span5">
		
			<cfif message CONTAINS "error">
				<div class="alert alert-error">
					<h4 class="alert-heading">Error</h4>
					<p>#message#</p>
				</div>
			<cfelseif message CONTAINS "success">
				<div class="alert alert-success">
					<h4 class="alert-heading">Success</h4>
					<p>#message#</p>
				</div>
			<cfelse>	
				<div class="alert alert-block">
					<h4 class="alert-heading">Information</h4>
					<p>#message#</p>
				</div>	
			</cfif>
			</div>
			<div class="span2">&nbsp;</div>
	
		</cfoutput>
		
		<cfset StructDelete(session, "qryMessageQueue")>
	</cfif>
</div>

<cfoutput>#prebody#</cfoutput>



<cfoutput>
#body#<!--- FW/1 body --->
</cfoutput>

<!--- .cfm page generates this --->
<article>		
	<cfoutput>#application.GSAPI.get_page_content()#
	
	
	<p><small>Published on &nbsp;#application.GSAPI.get_page_date()#</small></p>	
	</cfoutput>
</article>				
	

<footer>
	<div class="row">	

		<div class="span3">
			<div style="padding-left : 20px;">
			
			<cfoutput>#application.GSAPI.get_component("About_Us")#</cfoutput>

			</div>
		</div>
		
		<div class="span3">
						
			<cfoutput>#application.GSAPI.get_component("Featured")#</cfoutput>
		
		</div>
		
		<div class="span3">
			
			<cfoutput>#application.GSAPI.get_component("Site_Links")#</cfoutput>
		</div>
		

	
		<div class="span3">
	
			<cfoutput>#application.GSAPI.get_component("Contact_Us")#</cfoutput>

	  	</div>
	
	</div>
	
	<div class="copywrite">
		<cfoutput>#application.GSAPI.get_component("Copywrite")#
		
		<p><small>#application.GSAPI.get_site_credits()#</small></p>
		</cfoutput>
	</div>	
	
</footer>


<cfoutput>#application.GSAPI.get_footer()#</cfoutput>

</div><!-- /container -->




</body>
</html>


