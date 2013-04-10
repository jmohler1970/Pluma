

<cfparam name="mode" default="">


<table class="table table-condensed">
<thead>
<tr>
	<th>Date</th>
	<th>Time</th>
	<cfif mode EQ "referer">
		<th>Referer</th>
	<cfelse>
		<th>Action</th>
		<th>Search</th>
		<th>Tag</th>
	</cfif>

	<th>OS</th>
	<th>Browser</th>
	<th>&nbsp;</th>
</tr>
</thead>

<cfoutput query="rc.qryLastHits">
<tr>
	<td>#application.GSAPI.stdDate(CreateDate)#</td>
	<td>#LSTimeFormat(CreateDate)#</td>
	
	<cfif mode EQ "referer">
		<td>#htmleditformat(referer)#</td>
	<cfelse>
		<td>#SubSystem#:#Section#.#Item#</td>
		<td>#HTMLEditFormat(Search)#</td>
		<td>#HTMLEditFormat(Tags)#</td>
	</cfif>
	
	
	<td>#OS#</td>
	<td>#Browser#</td>
	<td>
	<a href="##" rel="popover" title="More Info" data-content="Referer: #Referer# Agent: #agent#"></a>
	</td>
</tr>
</cfoutput>
</table>



