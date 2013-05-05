

<div class="main">
	<h3 class="float">Preview Data Import</h3>



<form action="#buildURL(action = '.preview')#" method="post" class="anondata">


	<input type="hidden" name="title" value="#xmlformat(rc.title)#" />
	<input type="hidden" name="tags" value="#xmlformat(rc.tags)#" />
	<input type="hidden" name="menuStatus" value="#xmlformat(rc.menuStatus)#" />
	<input type="hidden" name="menu" value="#xmlformat(rc.menu)#" />
	<input type="hidden" name="menuorder" value="#xmlformat(rc.menuorder)#" />
	<input type="hidden" name="theme_template" value="#xmlformat(rc.theme_template)#" />
	<input type="hidden" name="parentnodeid" value="#xmlformat(rc.parentnodeid)#" />
	<input type="hidden" name="pStatus" value="#xmlformat(rc.pStatus)#" />
	
	<input type="hidden" name="modifyby" value="#xmlformat(rc.modifyby)#" />
	
	
	<input type="hidden" name="xmlData" value="#xmlformat(rc.xmlData)#" />
	<input type="hidden" name="strData" value="#xmlformat(rc.strData)#" />
	


	
	<cfoutput>
	<p><b>Title:</b> #xmlformat(rc.title)# <cfif rc.title EQ ""><i>None</i></cfif></p>
	<p><b>pStatus:</b> #xmlformat(rc.pStatus)# <cfif rc.pstatus EQ ""><i>None</i></cfif></p>

	<blockquote> 	
		#rc.strData#
		<cfif rc.xmlData NEQ ""><hr /></cfif>
		#rc.xmlData#
	</blockquote>	
	</cfoutput>


<h3>Merge To</h3>
	


<p class="clearfix">
	<label>Page</label>


		<select name="NodeID"  class="text autowidth">
			<option> -- Pick One</option>
			<option>Create new page</option>
						
			<cfoutput query="rc.qryAllPages">
				<option value="#NodeID#" <cfif slug EQ rc.slug>selected="selected"</cfif>>
					<cfloop from="1" to="#level#" index="i">
							<span>&nbsp; &mdash; &nbsp;</span>
					</cfloop>
					
					 #xmlformat(Title)#</option>
			</cfoutput>
			
		</select>
</p>


<!---
<p class="clearfix">
	<label>Apply to</label>
	
	<input type="radio" name="apply" value="strData" checked="checked"> Body
	
	&nbsp; &nbsp;
	
	<input type="radio" name="apply" value="xmlData"> XML Data (Must have Template support)
	
</p>
--->


<p class="submit">
	<br />
	<button type="submit" name="submit" class="submit">Data Import</button>
</p>	


	
</form>




</div>
