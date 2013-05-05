


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

	
		<cfif isDate(CreateDate)>
			<h6>Created: #LSDateFormat(CreateDate)#</h6>
		</cfif>
		
		<p>#application.IOAPI.strip_tags(strData, 1000)#</p>
		
		<h6>
			<b>Parent Page:</b> 
			<cfif ParentTitle EQ ""><i>None</i></cfif>
			<a href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#ParentNodeID#')#">#xmlformat(ParentTitle)#</a> 
			
			
			<b>Tags:</b> 
			<cfif tags EQ ""><i>None</i></cfif>
				
			<cfloop index="i" list="#tags#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					>#xmlformat(i)#</a><cfif i NEQ ListLast(tags)>,</cfif>
			</cfloop>
		</h6>
	</td>
</tr>
</cfloop>
</table>				
				
							
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
