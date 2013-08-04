

<!--- Yes this goes before class="main" --->
<cfoutput>#application.GSAPI.exec_action("pages-main")#</cfoutput>
<div class="main">


<cfoutput>
<h3 class="floated">#application.GSAPI.i18n("page_management")#</h3>





<div class="edit-nav clearfix">
	<a href="##" id="filtertable" accesskey="r">#application.GSAPI.i18n("filter")#</a>
	
	<a href="##" id="show-characters" accesskey="u">#application.GSAPI.i18n("toggle_status")#</a>
</div>	



<div id="filter-search" style="display : none; ">
	<form>
		<input type="text" autocomplete="off" class="text" id="q" 
			placeholder="#application.GSAPI.strip_tags(application.GSAPI.i18n("filter"))#..." /> 
		&nbsp; <a href="#buildurl('.home')#" class="cancel">#application.GSAPI.i18n("cancel")#</a>
	</form>
</div>
</cfoutput>			
<!---

<cfoutput>
<table id="editpages" class="edittable highlight paginate">
<tr>
	<th>#application.GSAPI.i18n("page_title")#</th>
	<th style="text-align : right;">#application.GSAPI.i18n("date")#</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
</cfoutput>

<tbody>
<cfoutput query="rc.qryAllPages">
<tr id="tr-#slug#">
	<td <cfif Root>style="text : bold;"</cfif> class="pagetitle">
		<cfloop from="1" to="#level#" index="i">
			<span>&nbsp; &nbsp; &mdash; &nbsp; &nbsp; </span>
		</cfloop>
	
	
		<cfif Kind EQ "Page">
			<a href="#BuildURL(action = 'pages.edit', querystring = 'NodeID=#NodeID#')#"
			title="#application.GSAPI.i18n("editpage_title")#"><cfif Root><b>#xmlformat(title)#</b><cfelse>#xmlformat(title)#</cfif> 
			<cfif title EQ "">#application.GSAPI.i18n("plumacms/notitle")#</cfif></a>
		<cfelse>
			<a title="Edit Page" href="#BuildURL(action = 'plugins.edit', querystring = 'NodeID=#NodeID#')#"><cfif Root><b>#xmlformat(title)#</b><cfelse>#xmlformat(title)#</cfif>
			<cfif title EQ "">#application.GSAPI.i18n("plumacms/notitle")#</cfif>
			</a>
		</cfif>
		
		<span class="showstatus toggle" style="display : none;">
			<cfif Root><sup>[#application.GSAPI.i18n("homepage_subtitle")#]</sup></cfif>	
			<cfif MenuStatus EQ 1><sup>[#application.GSAPI.i18n("menuitem_subtitle")#]</sup></cfif>
			<cfif pStatus NEQ "Public"><sup>[#application.GSAPI.i18n("private_subtitle")#]</sup></cfif>
			
		</span>
	</td>

	<td style="text-align : right;"><span>#application.IOAPI.std_date(ModifyDate)#</span></td>
	<td class="secondarylink">
	
		<a href="#application.GSAPI.find_url(slug)#" rel="tooltip" 
			title="#application.GSAPI.i18n("viewpage_title")#" target="_blank"><cfif Root><b>##</b><cfelse>##</cfif></a>
	
	</td>	
	<td class="delete">
		<cfif NoDelete EQ 0>	
			<a class="delconfirm" href="#buildURL(action = 'pages.delete', querystring = 'NodeID=#NodeID#')#" rel="tooltip"
				title="#application.GSAPI.i18n("delete_file")#" id="delete-#slug#">&times;</a>
		</cfif>
	</td>
</tr>
</cfoutput>
<cfif rc.qryAllPages.recordcount EQ 0>
<tr>
	<td colspan="8"><i>Sorry, no matches</i></td>
</tr>
</cfif>
</tbody>

</table>


<cfoutput>
	<p><i><b>#rc.qryAllPages.recordcount#</b> #application.GSAPI.i18n("total_pages")#</i></p>
</cfoutput>
--->


<cffunction name="QueryToArray" access="public" returntype="array" output="false"
hint="This turns a query into an array of structures.">

<!--- Define arguments. --->
<cfargument name="Data" type="query" required="yes" />

<cfscript>

// Define the local scope.
var LOCAL = StructNew();

// Get the column names as an array.
LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );

// Create an array that will hold the query equivalent.
LOCAL.QueryArray = ArrayNew( 1 );

// Loop over the query.
for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){

// Create a row structure.
LOCAL.Row = StructNew();

// Loop over the columns in this row.
for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){

// Get a reference to the query column.
LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];

// Store the query cell value into the struct by key.
LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];

}

// Add the structure to the query array.
ArrayAppend( LOCAL.QueryArray, LOCAL.Row );

}

// Return the array equivalent.
return( LOCAL.QueryArray );

</cfscript>
</cffunction>



<cfquery name="qryPage" dbtype="query">
	SELECT NodeID, slug, title, Date2 AS ModifyDate, NoDelete
	FROM rc.qryAllPages
</cfquery>




<cfoutput>

<div ng-init='xpages = #serializeJSON(queryToArray(qryPage))#'></div>


</cfoutput>


    <form>
      Search: <input ng-model="query">
 
      <select ng-model="sortorder">
        <option value="">-- sort order --</option>
        <option value="title">Ascending</option>
        <option value="-title">Descending</option>
      </select>
    </form>
    
    

    <table class="edittable highlight paginate" ng-show="(xpages|filter:query).length">
    
    <cfoutput>
    <tr>
		<th>#application.GSAPI.i18n("page_title")#</th>
		<th style="text-align : right;">#application.GSAPI.i18n("date")#</th>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
	</tr>
    
    
      <tr ng-repeat="page in xpages|filter:query|orderBy:sortorder">
        <td><a href="#buildurl('.edit')#/NodeID/{{page.NODEID}}">{{page.TITLE}}</a></td>
        <td style="text-align : right;"><span>{{page.MODIFYDATE|date:'EEE. MMM d, yyyy'}}</span></td>
        <td class="secondarylink">
        	<a href="#buildurl('main.home')#/main/{{page.SLUG}}" rel="tooltip" 
				title="#application.GSAPI.i18n("viewpage_title")#" target="_blank">##</a>
    
        </td>
        <td class="delete">
        
        <div ng-switch on="page.NODELETE">
       	<a ng-switch-when="0" class="delconfirm" href="#buildURL('.delete')#NodeID/{{page.NodeID}}" rel="tooltip"
				title="#application.GSAPI.i18n("delete_file")#" id="delete-{{page.SLUG}}">&times;</a>
        </div>
        </td>
      </tr>
    </cfoutput>
	</table>

 <p>There are <strong>{{(xpages|filter:query).length}}</strong> contacts<span ng-show="query.length"> matching &quot;{{query}}&quot;</span>.</p>
   
</div>

