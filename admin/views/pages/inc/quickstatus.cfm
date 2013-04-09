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
<table class="table">
<tr>
	<td style="text-align : right;"><big>#rc.stPageCount.All#</big></td>
	<td>Pages</td>
	<td style="text-align : right;"><big><a href="#buildurl(action = 'page.home', querystring = 'pstatus=approved')###find">#rc.stPageCount.Approved#</a></big></td>
	<td style="color : green;">Approved</td>
</tr>
<tr>
	<td style="text-align : right;"></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildurl(action= 'page.home', querystring = 'pstatus=pending')###find">#rc.stPageCount.Pending#</a></big></td>
	<td style="color : orange;">Pending</td>
</tr>

<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildurl(action = 'page.home', querystring = 'pstatus=reject')###find">#rc.stPageCount.Rejected#</a></big></td>
	<td style="color : red;">Rejected</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big><a href="#buildurl(action = 'page.home', querystring = 'cstatus=0')###find">#rc.stPageCount.pseudo_Draft#</a></big></td>
	<td>Drafts</td>

</tr>
</table>
</cfoutput>


