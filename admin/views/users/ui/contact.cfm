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


<cfswitch expression="#thisTag.ExecutionMode#">
<cfcase value="start">

	<cfscript>
	rc = caller.rc;
	
	param rc.organization = "";
	param rc.address = "";
	param rc.city = "";
	param rc.stateprovince = "";
	param rc.postalcode = "";
	
	param attributes.showmap =1;
	</cfscript>
</cfcase>

<cfcase value= 'end'>


<cfoutput>
<p>
	<label>Organization (if any)</label>
   	<input type="text" name="additionalAddress" class="text" value="#htmleditformat(rc.organization)#" />
</p>


<div class="clear"></div>

<p>
	<label>Street</label>
	<input type="text" name="address" class="text" value="#htmleditformat(rc.address)#" />
</p>


<div class="clear"></div>

<p>
	<label>City</label>

    <input type="text" name="city" class="text" value="#htmleditformat(rc.city)#" />
</p>

<div class="clear"></div>

<p>
	<label>State/Province</label>
	<input type="text" name="stateprovince" class="text" maxlength="2" value="#htmleditformat(rc.stateprovince)#" />
</p>

<div class="clear"></div>

<p>
	<label>Postal Code</label>
   	<input type="text" name="postalcode" class="text" value="#htmleditformat(rc.postalcode)#"  />
</p>



	


<cfif rc.City NEQ "" AND attributes.showmap EQ 1>

	<cfset Address = "">
		<cfif isDefined("rc.Address")>
			<cfset Address = rc.Address & ",">
		</cfif>
		

		
		<cfmap name="gmap02" 
	   		centeraddress="#Address# #rc.City#, #rc.StateProvince# #rc.PostalCode#" 
	    	doubleclickzoom="true" 
	    	scrollwheelzoom="true" 
	    	showscale="false"
	    	zoomlevel="12"
	    	tip="My Map"/>
 	
	   	 
    </cfif>	



</cfoutput>





</cfcase>
</cfswitch>
