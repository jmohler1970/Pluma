

<cfscript>
param rc.search = "";
</cfscript>

<cfsavecontent variable="prebody">
<form action="/index.cfm/search" class="form-search">


<form class="form-search">
	<cfoutput>
		<input type="text" name="search" class="input-medium search-query" value="#rc.search#" />
  	</cfoutput>
  <button type="submit" class="btn">Search</button>
</form>

	


<cfscript>

rc.href = "/index.cfm/search/#urlencodedformat(rc.search)#";

include "search.cfi";
</cfscript>
</cfsavecontent>


<cfinclude template="template.cfm">


