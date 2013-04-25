


<div class="row">
	<div class="span2">&nbsp;</div>

    <div class="span5">



<cfoutput query="rc.qryUser">


<cfform action="#buildURL(action = '.')#" method="post" id="rForm">

	<legend>Reset Password</legend> 


<div class="control-group">
	<label class="control-label">Login</label>
    <div class="controls">
    	<span class="uneditable-input">#login#</span>
    
    	
    </div>
</div>


<div class="control-group error">
	<label class="control-label">Password</label>
    <div class="controls">
      	<cfinput type="password" name="password" placeholder="******" value="" maxlength="20" required="yes" message="Password is required"  class="input-medium" />
    </div>
</div>


<div class="control-group  error">
	<label class="control-label">Confirm Password</label>
    <div class="controls">
      	<cfinput type="password" name="confirmpassword" placeholder="******" value="" maxlength="20" required="yes" message="Confirmation of password is required" class="input-medium" />
    </div>
</div>



<div class="form-actions">
	<button type="submit" class="btn btn-primary pull right"><i class="icon-ok icon-white"></i> Update</button>
</div>


</cfform>

</cfoutput>


	</div>
	<div class="span2">&nbsp;</div>
</div> <!--/ row -->
