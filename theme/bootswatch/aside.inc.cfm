<!---
Copyright © 2012 James Mohler

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


<cfif not isdefined("doMenu")><!--- Error pages will try to do this twice --->
	<cffunction name="doMenu"> 
		<cfargument name="Extra" type="string" required="true">
	
		<cfset qryNode = application.IOAPI.getOne({Extra = arguments.Extra, Kind = "Menu"})>	
	
		<cfset qryMenu = application.IOAPI.getLink(qryNode.NodeID)>
	
		
		<div class="well">
		<cfoutput query="qryNode"><h4>#Title#</h4></cfoutput>
	
		<cfoutput query="qryMenu" group="Category">
			
			<cfif Category NEQ "">
			<h6>#Category#</h6>
			</cfif>
			<cfoutput>
				<a href="#href#"><i class="icon-share" title="External Site"></i> #Value#</a><br />
			</cfoutput>		
		</cfoutput>
		
		
		<cfif session.LOGINAPI.adhocSecurity("system")>
			<cfoutput><a class="btn btn-success" href="#buildURL(action = 'admin:menu.home', querystring='extra=#arguments.extra#')#" target="_top"><i class="icon-pencil icon-white"></i> Edit</a></cfoutput>	
		</cfif>
		
		</div>
		
	</cffunction>
</cfif>


<div class="well">

<form method="post" action="/index.cfm/login">
<h4>Member Login</h4>

<table class="table table-condensed info">
<tr>
    <td>Email</td>
    <td>
        <input type="text" name="login" class="input-small" placeholder="name@site.com" />
    </td>
</tr>
<tr>
    <td>Password</td>
    <td>
        <input type="password" name="password" class="input-small" placeholder="password" />
    </td>
</tr>
<tr>
	<td></td>
    <td>
  		<button class="btn btn-primary" type="submit">Login</button>
  		
  		<a href="" class="btn" type="submit">Register</a>
	</td>
</tr>
</table>
</form>

<cfif session.LOGINAPI.adhocSecurity("system")>
	<cfoutput><a class="btn btn-success" href="#buildURL(action = 'admin:menu.aside')#" target="_top"><i class="icon-pencil icon-white"></i> Edit</a></cfoutput>	
</cfif>

</div>


<!--- Global Links --->
<cfset doMenu("Global")>

<h4>Advertisements</h4>

<!--- Get Banners here --->



<h4>More Links</h4>

<!--- Page Links --->
<h4>Related Links</h4>

<h4>Calendar</h4>

<h4>Search</h4>


<h4>Tags</h4>







<cfdump var="#request.stAside#">
<cfset variables.showAside = 1>
