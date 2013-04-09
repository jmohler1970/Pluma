<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->

<cfset mypath = rc.path EQ "" ? "" : rc.path & "/">

<div class="main">

	<h3>Image Control Panel</h3>

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
	<b>Original Image</b> <tt>#rc.info.width#&times;#rc.info.height#</tt> &nbsp;  | &nbsp;
	<b>Current Thumbnail</b> <tt>#rc.infothumb.height#&times;#rc.infothumb.height#</tt>
</p>

<form name="myFrm">
	<select id="img_info" class="input-xxlarge" onchange="doCode();">
		<option selected="selected" value="code-img-link" >Original Image Link</option>
		<option value="code-img-html" >Original Image HTML</option>
		<option value="code-thumb-html" >Thumbnail HTML</option>
		<option value="code-thumb-link" >Thumbnail Link</option>
		<option value="code-imgthumb-html" >Thumbnail-to-Image HTML</option>
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



<p>
	<img src="#application.GSAPI.get_site_root()##rc.uploadspath##rc.path#/#rc.name#" />
</p>
</cfoutput>

</div>


