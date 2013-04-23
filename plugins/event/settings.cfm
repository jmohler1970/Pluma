


<h3>Event Manager</h3>

<div class="edit-nav">
        <a <cfif rc.filter EQ "">class="current"</cfif> href="?plugin=event">All</a>
               
        <a <cfif rc.filter EQ "past">class="current"</cfif> href="?plugin=event&filter=past">Past</a>
        
        <a <cfif rc.filter EQ "thismonth">class="current"</cfif> href="?plugin=event&filter=thismonth">This Month</a>
                
        <a <cfif rc.filter EQ "future">class="current"</cfif> href="?plugin=event&filter=future">Future</a>
</div>

<div class="clear"></div>





<cfoutput query="rc.qryEvent" group="TimeFrame">

	<cfswitch expression="#TimeFrame#">
		<cfcase value="NextMonth"><h2><a name="future"></a>Future Events</h2></cfcase>
		<cfcase value="PastMonth"><h2><a name="past"></a>Past Events</h2></cfcase>
		<cfdefaultcase><h2><a name="thismonth"></a>This Months Events</h2></cfdefaultcase> 
	</cfswitch>


	<cfset areacount = 0>
	<table class="edittable highlight paginate">
	<thead> 
	<tr>
	

		<th>Title</th>
		<th>Event Date</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
	</thead>
	<cfoutput>
			<tr>
			
				<td>#location# <a href="?plugin=event&plx=edit&NodeID=#NodeID#" 
  							rel="tooltip" title="This leaves the tools area"><i class="icon-share-alt"></i><b>#Title#</b></a>
  				
  				</td>
			
				
				
				<td>#application.GSAPI.std_date(ExpirationDate)#</td>
				
				<td class="secondarylink">
					<a href="#application.GSAPI.get_site_root()#index.cfm/id/#NodeID#">##</a>
  				</td>			
  					
  				<td class="delete">			
  					<a href="?plugin=event&plx=delete&NodeID=#NodeID#">&times;</a>
				</td>
			</tr>
	</cfoutput>
	</table>
	
</cfoutput>
		


<cfoutput>
	<p><i><b>#rc.qryEvent.recordcount#</b> total pages</i></p>
</cfoutput>	
