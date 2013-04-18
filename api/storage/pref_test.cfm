<!--- this test is destructive --->


<cfset wsPref 	= createobject("component", "Pref")>

<cfset writedump(wsPref.get("Components"))>


<cfset writedump(wsPref.delete("Components", "componentssitelinks"))>


<cfset writedump(wsPref.get("Components"))>





<cfset writedump(wsPref.get())>


<cfset writedump(wsPref.commit("Components",{title_new = '----', components_new = "himom"}, cgi.remote_addr,  -1))>


<cfset writedump(wsPref.get("Components"))>




<cfscript>
rc = {
FIELDNAMES="META_TITLE,META_ROOT,META_DESCRIPTION,META_KEYWORDS,META_EMAIL,SUBMIT",
META_DESCRIPTION="",
META_EMAIL="",
META_KEYWORDS="",
META_ROOT="http://foundation.qcliving.com/index.cfm/",
META_TITLE="Pluma CMS by JM & WWI",
SUBMIT="Save"
	};
</cfscript>



<cfset writedump(wsPref.commit("meta", rc, cgi.remote_addr, 1019))>





