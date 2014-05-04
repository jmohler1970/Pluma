

<div class="main">


<h3>Link Categories</h3>

	
<table class="edittable highlight paginate">

<cfoutput>
<thead>
<tr>
	<th>Link Category</th>
	<th style="text-align : right;">Usage</th>
	<th style="text-align : right;">#application.GSAPI.i18n("date")#</th>
	<th></th>
</tr>
</thead>
</cfoutput>

<cfoutput query="rc.qryLinkCategory">
	<tr>
		<td>#xmlformat(Title)#</td>
		
		<td style="text-align : right;"><!--- #FacetCount# ---></td>	
		
		<td style="text-align : right;">#application.IOAPI.std_date(CreateDate)#</td>
		
		<td class="delete">
		<!---
			<cfif FacetCount EQ 0>
		--->
		
				<a class="delconfirm" href="#buildURL(action='.linkCategoryDelete', querystring ='NodeID=#NodeID#')#" id="delete-#slug#" title="#application.GSAPI.i18n('delete')#">&times;</a>
		
		<!---
			<cfelse>
				&nbsp;
			</cfif>
			
		--->	
		</td>
		
	</tr>
	</cfoutput>
	</table>
	

<cfoutput>
	<p><i><b>#rc.qryLinkCategory.recordcount#</b> total link categories</i></p>
</cfoutput>




<h3>Add Link Category</h3>	

<cfoutput>
<form action="#BuildURL(action = '.linkcategory')#" method="post">
	


<p>
   <b>Title</b>
   <br />
  
	<input type="Text" name="title" class="text" value="" size="50" maxlength="75" required="required" message="You must enter a new item" />	
</p>

		
	<button type="submit" class="submit" id="add">#application.GSAPI.i18n('add')#</button>
</form>
</cfoutput>


</div>
