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


<cfimport prefix="ui" taglib="ui"> 

<div class="main">

<h3>Add Contact</h3>


<cfoutput>
<cfform action="#BuildURL(action = 'users.edit')#" method="post" id="rForm" class="anondata">


<p class="clearfix">
	<label>First Name <em>*</em></label>
	<cfinput type="text" name="firstname" class="text" required="yes" value="" maxLength="50" message="First name is required" />
</p>


<p>
	<label>Last Name <em>*</em></label>
    <cfinput type="text" name="lastname" class="text" required="yes" value="" maxLength="50" message="Last name is required" />
</p>

<div class="clear"></div>

<p>
	<label>Email <em>*</em></label>
    <cfinput type="text" name="email" class="text" value="" required="yes" maxLength="80" message="Email address is required" />
</p>

<div class="clear"></div>

<p>
	<label>Stars</label>
  	<cfmodule template="ui/stars.cfm" />
</p>

<h2>Business Info</h2>


<ui:contact formonly="true" />


<input type="submit" class="submit" value="Add" />

	



</cfform>
</cfoutput>


</div>
