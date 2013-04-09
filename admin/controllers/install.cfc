<!---
Copyright (c) 2012 James Mohler

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

<cfcomponent extends="base">

<cfscript>
function init(fw) { 
	variables.fw = fw; 
	variables.Kind = "Unknown";
	}
</cfscript>	
	


<cffunction name="setup" hint="Does initial settings">
	<cfargument name="rc" required="true" type="struct">



<cfsavecontent variable="page">
<p>	Thank you for using PlumaCMS. This is your homepage, so please change this text to be what you want.</p>

<h2>Header 2</h2>
<p>
	Lorem ipsum <em>dolor sit amet</em>, <strong>consectetur adipiscing elit</strong>. Donec <code>this is code</code> venenatis augue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer vulputate pretium augue.</p>

<h3>Header 3</h3>
<pre>
<code>#header h1 a { 
	display: block; 
	width: 300px; 
	height: 80px; 
}</code></pre>

<h4>Header 4</h4>
<ol>
	<li>Lorem ipsum dolor sit amet</li>
	<li>Consectetur adipiscing elit</li>
	<li>Donec ut est risus, placerat venenatis augue</li>
</ol>

<blockquote>
	A blockquote. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut est risus, placerat venenatis augue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
</blockquote>
</cfsavecontent>

<cfsavecontent variable="anotherpage">
<h2>About</h2>
<p>Grumpy Cat is a nickname given to an angry-looking snowshoe cat that rose to fame online after its pictures were posted to Reddit in late September 2012. The cat is also known as “Tard” which is short for Tardar (Tartar) Sauce.</p>


<h2>Origin</h2>
<p>Grumpy Cat is owned by Arizona resident Tabatha Bundesen. The original photos of Grumpy Cat were posted to the /r/pics subreddit[1] by Bundesen’s brother Bryan on September 23rd, 2012 (shown below).</p>

 

<p>The Reddit post was instantly met with photoshopped parodies and image macros from others, reaching the front page with more than 25,300 up votes in the first 24 hours. Meanwhile, the Imgur page[13] gained nearly 1,030,000 views in the first 48 hours. The same day, three video clips of the cat playing indoors were uploaded to YouTube by Bundesen the same day.</p>



<h2>Precursor</h2>
<p>The name “Grumpy Cat” has been associated with pictures of scornful looking cats prior to this instance, mainly through the LOLcat image macro series X is not amused and Serious Cat.</p>
</cfsavecontent>


	
<cfsavecontent variable="sidebar">
<h2>PlumaCMS Features</h2>
<ul> 
	<li>XML based data storage</li> 
	<li>Easy to learn User Interface</li> 
	<li>'Undo' protection &amp; backups</li> 
	<li>Easy to theme</li> 
	<li>Web Service Enabled</li> 
	<li>One on one support</li> 
</ul>
<p>This is your sidebar text. To change this, go to <em>Theme -> Edit Components</em></p>


<p>To to go to the login page, <a href="/index.cfm/login">click here<a></p>	
</cfsavecontent>


	
	<cfif cgi.request_method EQ "post">
	
		<cfscript>
		if (rc.meta_title == "")	{
			this.AddMessage("Site title is required", "Error");
			
			return;
			}
		
		
		
		
		application.IOAPI.clear_all();

		// Settings
		result = application.IOAPI.set_pref("Meta", 	{meta_title 	= rc.meta_title, meta_root = rc.meta_root, meta_email = rc.meta_email });
		result = application.IOAPI.set_pref("Theme", 	{theme_current 	= "Innovation" });
		result = application.IOAPI.set_pref("Components", {components_sidebar = sidebar});
		
		
		// Login
		application.USERAPI.set("", {login = rc.login, firstname = rc.login, password = "", email = rc.meta_email, group = "System"});

		// Page
		var stResult = application.IOAPI.set({Kind="Page"}, {title = "Welcome to PlumaCMS", pStatus = "Public", strData = Page,
			menustatus = 1, menu = 'Home', menuorder = 1});
		
		// Search
		var stResult = application.IOAPI.set({Kind="Page"}, {title = "Search", pStatus = "Public", theme_template = "search.cfm"});
		
		// Tag	
		var stResult = application.IOAPI.set({Kind="Page"}, {title = "Tag", pStatus = "Public", theme_template = "tag.cfm"});	
		
		
		// Another page
		var stResult = application.IOAPI.set({Kind="Page"}, {title = "Grumpy Cat", pStatus = "Public", strData = anotherPage,
			menustatus = 1, menu = 'Grumpy Cat', menuorder = 2});
		
		if (not stResult.result)	{
			this.AddMessage(stResult.message);
				
			return;
			}
		
		
		var stResult = session.LOGINAPI.dologin(rc.login, "");
		
				
		this.AddMessage("Site has been successfully setup");
		
		if (stResult.result)	{
			variables.fw.redirect("pages.home", "all");
			return;
			}
		else	{
			this.AddMessage(stResult.message, "Error");
			}	
		
		
	
		//variables.fw.redirect("login.home", "all");
		</cfscript>
	</cfif>

</cffunction>


</cfcomponent>
