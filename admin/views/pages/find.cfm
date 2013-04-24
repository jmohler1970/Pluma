

<div class="main">

<cfoutput>
	<h3>#application.GSAPI.i18n("search")#</h3>


<form action="?" method="get" name="myFrm">
       
        	<input type="text" class="text" name="search" value="#htmleditformat(rc.search)#" placeholder="Part or all of title" />
       	

	<button type="submit">#application.GSAPI.i18n("search")#</button>
</form>
</cfoutput>

<p></p>


<cfoutput query="rc.qryPage">
	



	<cfif isnumeric(rank)>

		<h3>#LSNumberFormat(Rank, '99.0')#%</h3>
	
	</cfif>	
	
	
	<h2>
		<a href="#buildURL(action = 'admin:pages.edit', querystring = 'PageID=#NodeID#')#">#Title# <cfif title EQ ""><i>None</i></cfif></a> 
		
		(#Kind#)
	</h2>

		
		
		<cfif rc.taxonomy>
			<cfif strData CONTAINS "<p>">
				#application.IOAPI.strip_tags(strData, 1000)#
			<cfelse>
				#paragraphformat(strData)#
			</cfif>
		
			<p>
			<b>Created:</b> #application.IOAPI.std_date(CreateDate)# by #CreateBy#		
	
			<b>Parent Page:</b> 
			<cfif ParentTitle EQ ""><i>None</i></cfif>
			<a href="#buildURL(action = 'pages.edit', querystring = 'NodeID=#ParentNodeID#')#">#htmlEditFormat(ParentTitle)#</a> 
			
			
			<b>Tags:</b> 
			<cfif tags EQ ""><i>None</i></cfif>
				
			<cfloop index="i" list="#tags#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					>#htmleditformat(i)#</a><cfif i NEQ ListLast(tags)>,</cfif>
			</cfloop>
			
			</p>	
		</cfif>

</cfoutput>


<cfif rc.qryPage.recordcount EQ 0 AND rc.search NEQ "">
	<p><i>No matches</i></p>
</cfif>




</div>



