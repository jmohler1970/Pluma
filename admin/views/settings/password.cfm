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
