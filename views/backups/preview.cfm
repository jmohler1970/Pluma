

<div class="main">
	<h3 class="float">Preview Data Import</h3>


<cfoutput>
<form action="#buildURL(action = '.preview')#" method="post" class="anondata">


	<input type="hidden" name="title" value="#xmlformat(rc.title)#" />
	<input type="hidden" name="meta" value="#xmlformat(rc.meta)#" />
	<input type="hidden" name="metad" value="#xmlformat(rc.metad)#" />
	<input type="hidden" name="menuStatus" value="#xmlformat(rc.menuStatus)#" />
	<input type="hidden" name="menu" value="#xmlformat(rc.menu)#" />
	<input type="hidden" name="menuorder" value="#xmlformat(rc.menuorder)#" />
	<input type="hidden" name="template" value="#xmlformat(rc.template)#" />
	<input type="hidden" name="parent" value="#xmlformat(rc.parent)#" />
	<input type="hidden" name="private" value="#xmlformat(rc.private)#" />
	<input type="hidden" name="author" value="#xmlformat(rc.author)#" />
	
	<input type="hidden" name="content" value="#xmlformat(rc.content)#" />
	
	



	
	<p><b>Title:</b> #xmlformat(rc.title)# <cfif rc.title EQ ""><i>None</i></cfif></p>


	<blockquote> 	
		#rc.content#
	</blockquote>	
	</cfoutput>


<br />

<h3>Merge To</h3>
	


<p class="clearfix">
	<label>Page</label>


		<select name="NodeID"  class="text autowidth">
			<option value=""> -- Pick One</option>
			<option value="">Create new page</option>
						
			<cfoutput query="rc.qryAllPages">
				<option value="#NodeID#" <cfif slug EQ rc.slug>selected="selected"</cfif>>
					
					 #xmlformat(Title)#</option>
			</cfoutput>
			
		</select>
</p>




<p class="submit">
	<br />
	<button type="submit" name="submit" class="submit">Data Import</button>
</p>	


	
</form>




</div>
