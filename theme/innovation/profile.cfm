


<cfscript>
param rc.slug = "";

stUser = application.USERAPI.get_by_slug(rc.profile);
</cfscript>




<cfinclude template="header.cfi"> 


<cfoutput>	
	<div class="wrapper clearfix">
		<!-- page content -->
		<article>
			<section>
				
				<!-- title and content -->
				<h1>#application.GSAPI.get_page_title()#</h1>
				
				
<table>	

<tr>
	<td>
		
	
		
		
<div class="vcard">
	<span class="fn">#stUser.given# #stUser.family#</span>
	
	 <div class="vcardmain"> 
		<span class="n">
			<span class="honorific-prefix">#stUser.prefix#</span>
			<span class="given-name">#stUser.given#</span>
			<abbr class="additional-name">#stUser.additional#</abbr>
			<span class="family-name">#stUser.family#</span>
			<span class="honorific-suffix">#stUser.suffix#</span>
		</span>
	
		<div class="org">#stUser.title#</div>
		<div class="org">#stUser.org#</div>
		
		<a class="url" href="#stUser.url#">#stUser.url#</a>
		<a class="email" href="#stUser.email#">#stUser.email#</a>
		
		<cfif stUser.officetel NEQ "">	
			<div class="tel">Office: #stUser.officetel#</div>
		</cfif>	

		<div class="adr">
			<div class="street-address">#stUser.street#</div>
			<span class="locality">#stUser.locality#</span>,
			<abbr class="region">#stUser.region#</abbr>,
			<span class="postal-code">#stUser.code#</span>
			<div class="country-name">#stUser.country#</div>
		</div>
	
		<div class="note">#stUser.note#</div>
	</div>
</div>
</cfoutput>

<br />

<cfoutput query="stUser.qryProfile">
<cfif message NEQ "" AND title NEQ "">
	<h3>#title#</h3>
	
	
	<p>#message#</p>
</cfif>	
</cfoutput>



	</td>
</tr>

</table>

<!---
<cfif qrySlug.recordcount EQ 0>
	<cfoutput>
	<p>Sorry, not matches for <b>#xmlformat(rc.slug)#</b></p>
	

	<p>Suggestions:</p>

<ul>
	<li>Make sure profile is spelled correctly.</li>
	<li>Try different profile.</li>
</ul>	
	</cfoutput>
</cfif>

--->				

			</section>
			
		</article>

		<cfinclude template="sidebar.cfi">
	</div>

