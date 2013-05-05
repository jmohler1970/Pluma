

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
   	<input type="text" name="additionalAddress" class="text" value="#xmlformat(rc.organization)#" />
</p>


<div class="clear"></div>

<p>
	<label>Street</label>
	<input type="text" name="address" class="text" value="#xmlformat(rc.address)#" />
</p>


<div class="clear"></div>

<p>
	<label>City</label>

    <input type="text" name="city" class="text" value="#xmlformat(rc.city)#" />
</p>

<div class="clear"></div>

<p>
	<label>State/Province</label>
	<input type="text" name="stateprovince" class="text" maxlength="2" value="#xmlformat(rc.stateprovince)#" />
</p>

<div class="clear"></div>

<p>
	<label>Postal Code</label>
   	<input type="text" name="postalcode" class="text" value="#xmlformat(rc.postalcode)#"  />
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
