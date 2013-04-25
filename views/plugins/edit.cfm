



<cfset application.GSAPI.get_path(rc.NodeID, "internal", "breadcrumb")>


<cfif rc.cStatus EQ 0>
	<div class="alert">
	   <strong>Warning!</strong> This message is in draft status. Right now it is hidden from the public users. Use <i>Save</i> if you want it to visible.
	</div>
</cfif>


<cfoutput>#rc.Content#</cfoutput>

