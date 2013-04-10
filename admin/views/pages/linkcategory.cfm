

<div class="main">


<h3>Link Categories</h3>

	
<table class="edittable highlight paginate">
<thead>
<tr>
	<th>Link Category</th>
	<th style="text-align : right;">Usage</th>
	<th style="text-align : right;">Date</th>
	<th></th>
</tr>
</thead>

<cfoutput query="rc.qryLinkCategory">
	<tr>
		<td>#htmleditformat(Title)#</td>
		
		
		<td style="text-align : right;">#FacetCount#</td>	
		<td style="text-align : right;">#application.GSAPI.stdDate(CreateDate)#</td>
		<td class="delete">
			<cfif FacetCount EQ 0>
				<a  class="delconfirm" href="#buildURL(action='.linkCategoryDelete', querystring ='NodeID=#NodeID#')#" onclick="return confirm('Are you sure?');">&times;</a>
			<cfelse>
				&nbsp;
			</cfif>
		</td>
		
	</tr>
	</cfoutput>
	</table>
	

<cfoutput>
	<p><i><b>#rc.qryLinkCategory.recordcount#</b> total link categories</i></p>
</cfoutput>




<h3>Add Link Category</h3>	

<cfoutput>
<cfform action="#BuildURL(action = '.linkcategory')#" method="post">
	


<p>
   <b>Title</b>
   <br />
  
	<cfinput type="Text" name="title" class="text" value="" size="50" maxlength="75" required="yes" message="You must enter a new item" />	
</p>

		
	<input type="submit" class="submit" value="Add" />
</cfform>
</cfoutput>


</div>
