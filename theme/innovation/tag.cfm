


<cfscript>
param rc.tag = "";

qryTag = application.IOAPI.get_by_tag(rc.tag, "Page");
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
<cfloop query="qryTag">
<tr>
	<td>
		
		<h3><a href="#application.GSAPI.find_url(slug)#">#xmlformat(Title)#</a></h3>

	

		
		<p>#application.IOAPI.strip_tags(strData, 1000)#</p>
		
		<p>
			<small>
			<cfif isDate(CreateDate)>
				<strong>Created:</strong> #application.IOAPI.std_date(CreateDate)# by #CreateBy#
			</cfif>
			
			<cfif request.search.parentpage EQ 1>
				&nbsp;
				<strong>Parent Page:</strong> 
				<cfif ParentTitle EQ ""><i>None</i></cfif>
				<a href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#ParentNodeID#')#">#xmlformat(ParentTitle)#</a> 
			</cfif>
			
			
			<cfif request.search.tags EQ 1>
				&nbsp;				
				<strong>Tags:</strong> 
				<cfif tags EQ ""><i>None</i></cfif>
				
				<cfloop index="i" list="#tagSlugs#">
					<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
						rel="tag">#xmlformat(i)#</a><cfif i NEQ ListLast(tagSlugs)>,</cfif>
				</cfloop>
			</cfif>
			
			</small>
		</h6>
	</td>
</tr>
</cfloop>
</table>


<cfif qryTag.recordcount EQ 0>
	<cfoutput>
	<p>Sorry, not matches for <b>#xmlformat(rc.tag)#</b></p>
	

	<p>Suggestions:</p>

<ul>
	<li>Make sure all tag is spelled correctly.</li>
	<li>Try different tag.</li>
</ul>	
	</cfoutput>
</cfif>

				

			</section>
			
		</article>

		<cfinclude template="sidebar.cfi">
	</div>
</cfoutput>
