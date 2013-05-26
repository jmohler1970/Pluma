<cfsetting showDebugOutput="No">


<cfinclude template="header.cfi">




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


<div class="row">
	<div class="span12">				
	<cfoutput>#application.GSAPI.get_page_content()#
	

	
	
	<p><small>Published on &nbsp;#application.GSAPI.get_page_date()#</small></p>	
	</cfoutput>
	</div>
	
	
</div>				
	


	<div class="row">	

		<div class="span3">
			<div>
			
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
	



<cfinclude template="footer.cfi"> 

