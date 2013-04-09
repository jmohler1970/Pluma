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



	
		
<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
			


</cfform>
</cfoutput>

</div>

