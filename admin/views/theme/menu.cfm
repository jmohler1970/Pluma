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



		
<cfoutput>
<table class="table table-bordered table-striped">
<tr>
	<td colspan="4" style="text-align : center">
		<a class="btn btn-success btn-small" href="#buildURL(action = 'menu.home', querystring = 'extra=Top')#"
			rel="tooltip" title="Kind: Menu"><span class="count" style="text-transform : capitalize;">Top</span></a>
	</td>
</tr>
<tr>
	<td colspan="3">
		<b>Welcome</b><br />
		<small>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur interdum ornare leo, non accumsan neque sagittis sit amet. Phasellus suscipit eros at ligula viverra gravida. Proin tempus felis sit amet justo malesuada posuere. Nunc congue nibh semper augue accumsan bibendum. Nullam feugiat est ut felis mattis auctor. In congue magna vitae urna accumsan ac dapibus ante sollicitudin. Suspendisse potenti.</small>
	</td>
	<td style="width : 10%">
		<p>
		<a class="btn btn-inverse btn-small" href="#buildURL(action = 'menu.aside')#" 
			rel="tooltip" title="Kind: Preference">Member&nbsp;Login</a>
		</p>
		
		<p>
		<a class="btn btn-success btn-small" href="#buildURL(action = 'menu.home', querystring = 'extra=Global')#" 
			rel="tooltip" title="Kind: Menu">Global</a>
		</p>
		
		<p>
		<a class="btn btn-warning btn-small" href="#buildURL(action = 'banner.home')#" 
			rel="tooltip" title="Kind: Banner">Banner</a>	
		</p>
		
		<p>
		<a class="btn btn-success btn-small" href="#buildURL(action = 'menu.home', querystring = 'extra=Aside')#" 
			rel="tooltip" title="Kind: Menu">Sec&nbsp;Global</a>
		</p>
		
		<p>	
		<button disabled="disabled" class="btn btn-success btn-small" 
			href="#buildURL(action = 'menu.home', querystring = 'extra=Aside')#" 
			rel="tooltip" title="Kind: Menu. Go to page to edit">Page&nbsp;Specific</button>
		</p>
		
		<p>		
		<a class="btn btn-inverse btn-small" href="#buildURL(action = 'menu.aside')#" 
			rel="tooltip" title="Kind: Preference">Search</a>	
		</p>	
			
		<p>		
		<a class="btn btn-inverse btn-small" href="#buildURL(action = 'menu.aside')#" 
			rel="tooltip" title="Kind: Preference">Tags</a>
		</p>	
	</td>
</tr>
<tr>
	<td>
	<a class="btn btn-inverse btn-small" href="#buildURL(action = 'system.home')#" 
			rel="tooltip" title="Kind: Preference">About&nbsp;Us</a>
	
	</td>
	<td style="width : 30%; text-align : right;">
		<a class="btn btn-success btn-small" href="#buildURL(action = 'menu.home', querystring = 'extra=Showcase')#"
			rel="tooltip" title="Kind: Menu"><span class="count" style="text-transform : capitalize;">Showcase</span></a>
	</td>
	
	<td style="width : 30%">
		<a class="btn btn-success btn-small" href="#buildURL(action = 'menu.home', querystring = 'extra=Sitemap')#"
			rel="tooltip" title="Kind: Menu"><span class="count" style="text-transform : capitalize;">Sitemap</span></a>
	</td>
	<td>
	<a class="btn btn-inverse btn-small" href="#buildURL(action = 'system.home')#" 
			rel="tooltip" title="Kind: Preference">Contact Us</a>
	</td>
</tr>
</table>
</cfoutput>