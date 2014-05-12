

<cfset mypath = rc.path EQ "" ? "" : rc.path & "/">

<div class="main">

<cfoutput>	
	<h3>#application.GSAPI.i18n("IMG_CONTROl_PANEL")#</h3>
</cfoutput>

<script type="text/javascript">
var copyKitTextArea = $('textarea.copykit');

function doCode()	{
		var codetype = myFrm.img_info[myFrm.img_info.selectedIndex].value;;
		var code = $('p#'+ codetype).html();
		
		var copyKitTextArea = $('textarea.copykit');
		copyKitTextArea.html(code);
		}
</script>


<cfoutput>
<p>
	<b>#application.GSAPI.i18n("ORIGINAL_IMG")#</b> <tt>#rc.info.width#&times;#rc.info.height#</tt> &nbsp;  | &nbsp;
	<b>#application.GSAPI.i18n("CURRENT_THUMBNAIL")#</b> <tt>#rc.infothumb.height#&times;#rc.infothumb.height#</tt>
</p>

<form name="myFrm">
	<select id="img_info" class="input-xxlarge" onchange="doCode();">
		<option selected="selected" value="code-img-link"	>#application.GSAPI.i18n("LINK_ORIG_IMG")#</option>
		<option 					value="code-img-html"	>#application.GSAPI.i18n("HTML_ORIG_IMG")#</option>
		<option 					value="code-thumb-html"	>#application.GSAPI.i18n("HTML_THUMBNAIL")#</option>
		<option 					value="code-thumb-link"	>#application.GSAPI.i18n("LINK_THUMBNAIL")#</option>
		<option 					value="code-imgthumb-html">#application.GSAPI.i18n("HTML_THUMB_ORIG")#</option>
	</select><br />
	<textarea class="copykit input-xxlarge" rows="3" >/data/uploads/#mypath##rc.name#</textarea>
</form>

<div class="toggle" style="display : none;">
	<p id="code-img-html">&lt;img src="/data/uploads/#mypath##rc.name#" height="#rc.info.height#" width="#rc.info.width#" alt=""></p>
	<p id="code-img-link">/data/uploads/#mypath##rc.name#</p>
	<p id="code-thumb-html">&lt;img src="/data/thumbs/#mypath##rc.name#" height="#rc.infothumb.height#" width="#rc.infothumb.width#" alt=""></p>
	<p id="code-thumb-link">/data/thumbs/#mypath##rc.name#</p>
	<p id="code-imgthumb-html">&lt;a href="/data/uploads/#mypath##rc.name#">&lt;img src="/data/thumbs/#mypath##rc.name#" height="#rc.infothumb.height#" width="#rc.infothumb.width#" alt="" />&lt;/a></p>
</div>
<p style="color:##666;font-size:11px;margin:-10px 0 0 0"><a href="##" class="select-all" >#application.GSAPI.i18n("CLIPBOARD_INSTR")#</a></p>
			



<p>
	<img src="#application.GSAPI.get_site_root()##rc.uploadspath##rc.path#/#rc.name#" />
</p>
</cfoutput>

</div>


