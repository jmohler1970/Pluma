

<div class="main">

<h3>Preview Registration Data</h3>

<p>This is the exact data that we are going to send via email to our support email box. If agree with the data below, please click the 'Send Data' button. Thank you again for registering.</p>


<cfoutput>
<form action="?plugin=anonymous_data&amp;plx=preview" method="post">
	<input type="hidden" name="sendData" value="1" /> 

<cfoutput>
	<textarea name="registrationData" readonly="readonly">
		#htmleditformat(rc.registrationdata)#
	</textarea>


</cfoutput>

<br />


	<input type="submit" class="submit" value="Send Data" />
</form>
</cfoutput>


</div>