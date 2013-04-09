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
	<td><big>#rc.stEventCount.All#</big></td>
	<td>Events</td>
	<td style="text-align : right;"><big>#rc.stEventCount.pseudo_Draft#</big></td>
	<td>Draft Events</td>
</tr>

<tr style="margin-bottom : 1px solid beige;">
	<td><big></big></td>
	<td></td>
	<td style="text-align : right;"><big>#rc.stEventCount.Approved#</big></td>
	<td style="color : green;">Published Events</td>
</tr>
<tr style="margin-bottom : 1px solid beige;">
	<td><big></big></td>
	<td></td>
	<td style="text-align : right;"><big>#rc.stEventCount.Pending#</big></td>
	<td style="color : orange;">Pending Events</td>
</tr>
<tr>
	<td></td>
	<td></td>
	<td style="text-align : right;"><big>#rc.stEventCount.Rejected#</big></td>
	<td style="color : red;">Rejected Events</td>
</tr>
</table>
</cfoutput>

