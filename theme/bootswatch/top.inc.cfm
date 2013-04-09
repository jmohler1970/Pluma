<!---
Copyright © 2012 James Mohler

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
<!--- Customer Specific items go here --->
<!-- top -->



<div class="navbar navbar-inverse navbar-fixed-top">



	<div class="navbar-inner">
		<div class="container">
		<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</a>
		
		<cfoutput>	
		
		<a class="brand" href="#application.GSAPI.get_site_root()#">888 266 6486 - Web World Inc.</a>
			<div class="nav-collapse">

			<ul class="nav">
				
				<cfset baseclass = (getSection() EQ "main" AND getItem() EQ "page") ? "active" : "">
				
				
				<li class="#baseclass#"><a href="#application.GSAPI.get_site_root()#" target="_top"><i class="icon-home icon-white"></i> Home</a></li>
				


				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#application.GSAPI.get_site_root()#" target="_top">Quick Links <b class="caret"></b></a>
					<ul class="dropdown-menu">
						#application.GSAPI.get_navigation()#
						
					<li class="#baseclass#"><a href="http://www.webworldinc.com/usersonly/index.htm" target="_top">Users Only</a></li>	
				
						
						<li class="#baseclass#"><a href="#application.GSAPI.get_site_root()#index.cfm/login" target="_top">Login</a></li>
					</ul>
				</li>

				<li class="#baseclass#"><a href="http://mail.webworldinc.com" target="_top"><i class="icon-envelope icon-white"></i> Webmail</a></li>

				
			</ul>


			</cfoutput>

			</div><!-- /.nav-collapse -->
		</div>
	</div><!-- /navbar-inner -->
</div><!-- /navbar -->
