



<cfset Innovation_Settings()>



<cfinclude template="header.cfi"> 


<cfoutput>	
	<div class="wrapper clearfix">
		<!-- page content -->
		<article>
			<section>
				
				<!-- title and content -->
				<h1>#application.GSAPI.get_page_title()#</h1>
							
				#application.GSAPI.get_page_content()#
				
				
				
				<!-- page footer -->
				<div class="footer">
					<p>Published on <time>#application.GSAPI.get_page_date()#</time></p>
				</div>
			</section>
			
		</article>

		<cfinclude template="sidebar.cfi">
	</div>
</cfoutput>

<cfinclude template="footer.cfi">

