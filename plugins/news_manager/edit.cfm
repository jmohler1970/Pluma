


<div class="main">

	<h3>Add / Edit Event</h3>






<cfparam name="rc.simple_location" default="">


<cfif rc.qryNode.cStatus EQ 0>
	<div class="alert">
	   <strong>Warning!</strong> This message is in draft status. Right now it is hidden from the public users. Use <i>Save</i> if you want it to visible.
	</div>
</cfif>



<cfset application.GSAPI.get_path({NodeID = rc.NodeID, Kind="Event"}, "internal", "breadcrumb")>



<cfoutput query="rc.qryNode">
<cfform action="?plugin=event&plx=edit" method="post" name="myFrm" class="form-horizontal" onSubmit="doPull();">



	
<input type="hidden" name="NodeID" value="#rc.NodeID#" />


<p>
	<cfinput type="Text" name="title" value="#title#" class="text" maxlength="50" required="yes" message="Title is required" placeholder="Title of Event" />
</p>


<div id="metadata_window">
<div class="leftopt">	

<!---
<p class="inline clearfix">
	<label class="control-label" for="startDate">Event Start</label>

	<cfset myStartDate = startDate>
	<cfif myStartDate EQ "">
		<cfset myStartDate = LSDateFormat(now(), "mm/dd/yyyy")>
	</cfif>
	
	
 	<cfset application.IOAPI.showDatePicker("startDate", myStartDate)>
</p>

</div>


<div class="rightopt">	
--->


<p class="inline clearfix">
	<label class="control-label" for="expirationDate">Event End</label>
	
	
	<cfset myExpirationDate = ExpirationDate>
	<cfif myExpirationDate EQ "">
		<cfset myExpirationDate = LSDateFormat(now(), "mm/dd/yyyy")>
	</cfif>
  	
  
  	<cfset application.IOAPI.showDatePicker("expirationDate", myExpirationDate)>
</p>

</div>


<div class="clear"></div>

</div>

	
<cftextarea name="strData" richtext="true" toolbar="Enhanced"  height="400" style="width : 800px;">#htmleditformat(strData)#</cftextarea>


<cfparam name="simple_location" default="">

<p>
   <b>Location</b>
   		<cfinput type="Text" name="simple_location" value="#simple_location#" class="text" maxlength="50" />	
</p>


<p>
   <b>Map URL</b>
   		<cfinput type="text" name="map" value="#htmleditformat(map)#" class="text" />	
</p>



	
		
<button type="submit">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
			


</cfform>
</cfoutput>

</div>
