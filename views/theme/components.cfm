


<cfoutput>
<div class="main">



<h3 class="floated">#application.GSAPI.i18n("side_components")#</h3>

<div class="edit-nav">
	<a href="##" id="addcomponent" accesskey="a">#application.GSAPI.i18n("add_component")#</a>

</div>

<div class="clear"></div>

<form action="#buildURL(action = '.components')#" method="post">


<div style="display : none" id="components_window">
<table class="comptable">
<tbody>
<tr>
	<td><b>#application.GSAPI.i18n("title")#</b> <input type="text" class="text newtitle" name="components.new_title" value="" style="width : 100px" /></td>
	<td></td>
</tr>
</tbody>
</table>

<textarea name="components.new" class="code" style="height : 120px;"></textarea>

	<br />

	<button type="submit" class="save" name="submit">#application.GSAPI.i18n("save_components")#</button> 

</div>


<p></p>





<cfloop index="i" list="#StructKeyList(rc.Components)#">



<table class="comptable">
<tbody>
<tr>
	<td><b>#lcase(i)#</b></td>
	<td style="text-align:right;"><code>##application.GSAPI.get_component(<span class="compslugcode">'#lcase(i)#'</span>)##</code></td>
	<td class="delete">
		<a class="delconfirm" href="#buildURL(action = '.delcomponents', querystring = 'pref=#lcase(i)#')#"
			title="#application.GSAPI.i18n('delete_component')#: #lcase(i)#?" class="delcomponent" rel="1" id="del_#i#">&times;</a>
	</td>
</tr>
</tbody>
</table>

 
 	<textarea name="components.#i#" class="code" style="height : 120px;">#xmlformat(rc.components[i])#</textarea>



	<p></p>


</cfloop>

	<br />

<h3 id="submit_line">
	<span>
		<button type="submit" class="save" name="submit">#application.GSAPI.i18n("save_components")#</button> 
	</span>	
</h3>

</form>

<br />

<p><b>Note:</b> The <code>application.GSAPI.get_component()</code> replaces <b>~</b> with site root.<br />
	The current site root is: <code>#application.GSAPI.get_site_root()#</code></p>
</cfoutput>

</div>



