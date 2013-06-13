

<cfscript>
param rc.search = "";

qrySearch = application.IOAPI.get_by_search(rc.search, "All");
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
<cfloop query="qrySearch">
<tr>
	<td>
	<cfif isDefined("request.search.rank") AND request.search.rank EQ 1> 
		<b> #LSNumberFormat(Rank, '99.0')#%</b>
	</cfif>	
	</td>
	<td>&nbsp;</td>
	<td>
		
		<h3>
		<cfif Kind EQ "User">
			<a href="#application.GSAPI.find_url('profile')#/#slug#">#xmlformat(Title)#</a>
		<cfelse>
			<a href="#application.GSAPI.find_url(slug)#">#xmlformat(Title)#</a>
		</cfif>
		</h3>

		
		<p>#application.IOAPI.strip_tags(strData, request.search.letters)#</p>
		
		<p>
			<small>
			
		<cfif request.search.publishdate EQ 1>
			<strong>Created:</strong> #application.IOAPI.std_date(CreateDate)# by #CreateBy#		
		</cfif>	
	
		<cfif request.search.parentpage EQ 1>
			&nbsp;
			
			<strong>Parent Page:</strong> 
			<cfif ParentTitle EQ ""><i style="font-style : italic;">None</i></cfif>
			<a href="#application.GSAPI.find_url(parentslug)#">#xmlformat(ParentTitle)#</a> 
		</cfif>
			

		<cfif request.search.tags EQ 1>
			&nbsp;
					
			<strong>Tags:</strong> 
			<cfif tags EQ ""><i style="font-style : italic;">None</i></cfif>
				
				
				
			<cfloop index="i" list="#tagSlugs#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					rel="tag">#xmlformat(i)#</a><cfif i NEQ ListLast(tagSlugs)>,</cfif>
			</cfloop>
		</cfif>
		
			</small>
		</p>	
	</td>
</tr>
</cfloop>
</table>

<cfif qrySearch.recordcount EQ 0>
	<cfoutput>
	<p>Sorry, not matches for <b>#xmlformat(rc.search)#</b></p>
	

	<p>Suggestions:</p>

<ul>
	<li>Make sure all words are spelled correctly.</li>
	<li>Try different keywords.</li>
	<li>Try more general keywords.</li>
</ul>	
	</cfoutput>
</cfif>


				
				

			</section>
			
		</article>

		<cfinclude template="sidebar.cfi">
	</div>
</cfoutput>
