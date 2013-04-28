


<cfoutput>
<div class="main">

<!---
<cfdump var="#cacheGet("stPref")#">	
--->	

<h3 class="floated">#application.GSAPI.i18n("side_components")#</h3>

<div class="edit-nav">
	<a href="##" id="components_toggle" accesskey="a">#application.GSAPI.i18n("add_component")#</a>

</div>

<div class="clear"></div>

<form action="#buildURL(action = '.components')#" method="post">


<div style="display : none" id="components_window">
<table class="comptable">
<tbody>
<tr>
	<td><b>#application.GSAPI.i18n("title")#</b> <input type="text" class="text newtitle" name="new_title" value="" style="width : 100px" /></td>
	<td></td>
</tr>
</tbody>
</table>

<textarea name="components_new" class="code" style="height : 120px;"></textarea>

	<br />

	<button type="submit" name="submit">#application.GSAPI.i18n("save_components")#</button> 

</div>
	<p></p>



<cfloop index="i" list="#ArrayToList(rc.arComponents)#">

<cfset ii = listrest(i, "_")>


	<input type="hidden" name="title" value="#ii#" />

<table class="comptable">
<tbody>
<tr>
	<td><b>#lcase(ii)#</b></td>
	<td style="text-align:right;"><code>##application.GSAPI.get_component(<span class="compslugcode">'#lcase(ii)#'</span>)##</code></td>
	<td class="delete">
		<a href="#buildURL(action = '.delcomponents', querystring = 'pref=#lcase(ii)#')#"
			title="#application.GSAPI.i18n('delete_component')#: #lcase(ii)#?" class="delcomponent" rel="1" id="del_#ii#">&times;</a>
	</td>
</tr>
</tbody>
</table>

 
 	<textarea name="components_#ii#" class="code" style="height : 120px;">#htmleditformat(evaluate('rc.stComponents.#i#'))#</textarea>

	<br />

	<button type="submit" name="submit">#application.GSAPI.i18n("save_components")#</button> 

	<p></p>


</cfloop>
</form>


<p><b>Note:</b> The <code>application.GSAPI.get_component()</code> replaces <b>~</b> with site root.<br />
	The current site root is: <code>#application.GSAPI.get_site_root()#</code></p>
</cfoutput>

</div>



