<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->



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
			
				
				
				<td>#application.GSAPI.stdDate(ExpirationDate)#</td>
				
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
