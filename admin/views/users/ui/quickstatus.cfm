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

<cfoutput>
<table class="table table-condensed">

<tr style="margin-bottom : 1px solid beige;">
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'expired=0')###find"><cfoutput>#rc.stUserCount.All#</cfoutput></a></big></td>
	<td>All Users</td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring ='ustatus=confirmed')###find"><cfoutput>#rc.stUserCount.Confirmed#</cfoutput></a></big></td>
	<td style="color : green;">Approved</td>
</tr>
<tr style="margin-bottom : 1px solid beige;">
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'recent=1')###find"><cfoutput>#rc.stUserCount.pseudo_Recent#</cfoutput></a></big></td>
	<td>Recently Logged in</td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'uStatus=pending')###find"><cfoutput>#rc.stUserCount.Pending#</cfoutput></a></big></td>
	<td style="color : orange;">Pending</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'uStatus=rejected')###find"><cfoutput>#rc.stUserCount.Rejected#</cfoutput></a></big></td>
	<td style="color : red;">Rejected</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildURL(action = 'users.home', querystring = 'expired=1')###find"><cfoutput>#rc.stUserCount.Expired#</cfoutput></a></big></td>
	<td>Expired</td>
</tr>
</table>
</cfoutput>
