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

<h3>Preview Registration Data</h3>

<p>This is the exact data that we are going to send via email to our support email box. If agree with the data below, please click the 'Send Data' button. Thank you again for registering.</p>


<cfoutput>
<form action="#buildURL(action='support.preview')#" method="post">
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