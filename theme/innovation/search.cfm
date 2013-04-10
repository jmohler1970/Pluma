

<cfscript>
param rc.search = "";

qrySearch = application.IOAPI.get_by_search(rc.search, "Page");
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
		<b> #LSNumberFormat(Rank, '99.0')#%</b>
	</td>
	<td>&nbsp;</td>
	<td>
		
		<h3><a href="/index.cfm/main/#slug#">#htmleditformat(Title)#</a></h3>

		
		<p>#application.IOAPI.stripHTML(strData, 1000)#</p>
		
		<h6>
			<b>Created:</b> #application.GSAPI.stdDate(CreateDate)# by #CreateBy#		
	
			<b>Parent Page:</b> 
			<cfif ParentTitle EQ ""><i>None</i></cfif>
			<a href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#ParentNodeID#')#">#htmlEditFormat(ParentTitle)#</a> 
			
			
			<b>Tags:</b> 
			<cfif tags EQ ""><i>None</i></cfif>
				
			<cfloop index="i" list="#tags#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					>#htmleditformat(i)#</a><cfif i NEQ ListLast(tags)>,</cfif>
			</cfloop>
			
		</h6>	
	</td>
</tr>
</cfloop>
</table>

				
				
				<!-- page footer -->
				<div class="footer">
					<p>Published on <time>#application.GSAPI.get_page_date()#</time></p>
				</div>
			</section>
			
		</article>

		<cfinclude template="sidebar.cfi">
	</div>
</cfoutput>
