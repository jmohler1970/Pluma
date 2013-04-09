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


<html>
<head>
	<title>FW/1 Smoke Test</title>
</head>

<body>
<h1>Get links</h1>

<p>Make sure you do this after logging in.</p>

<cfsavecontent variable="lstLink">
archive,
archive/2011,
archive/2011/12,
archive/2002,
archive/2002/12,
tag,
tag/Arizona,

id,
id/259,
id/2987,
id/7858,
id/2987,
profile,
profile/James,
profile/Ben,

search,
search/cat,

main/404,
main/click,
main/error,
main/home,
main/privacy,
main/toc,
main/hosting,
main/development,
main/support,

login,
admin:backups/home,
admin:backups/history,
admin:backups/importdata,
admin:backups/exportdata,

admin:files/process,
admin:files/details,

admin:login/email,
admin:login/email?email=whw,
admin:login/email?email=w@hw,
admin:login/email?email=fake@fake.com,
admin:login/email?email=expired@fake.com,
admin:login/email?email=suspended@fake.com,
admin:login/email?email=nologin@fake.com,
admin:login/suspended,

admin:pages/home,
admin:pages/edit,
admin:pages/delete,
admin:pages/find,
admin:pages/find/search/cat,
admin:pages/tags,

admin:pages/settings?plugin=banner,
admin:pages/settings?plugin=banner&plx=edit,
admin:pages/settings?plugin=banner&plx=delete,
admin:pages/settings?plugin=blog,
admin:pages/settings?plugin=blog&plx=edit,
admin:pages/settings?plugin=blog&plx=delete,
admin:pages/settings?plugin=event,
admin:pages/settings?plugin=event&plx=delete,

admin:pages/settings?plugin=photo,
admin:pages/settings?plugin=photo&plx=add,
admin:pages/settings?plugin=photo&plx=edit&NodeID=352,
admin:pages/settings?plugin=photo&plx=edit&NodeID=7430,
admin:pages/settings?plugin=photo&plx=preview&NodeID=352,

admin:pages/settings?plugin=traffic,
admin:pages/settings?plugin=traffic&plx=referer,
admin:pages/settings?plugin=traffic&plx=search,
admin:pages/settings?plugin=traffic&plx=os,
admin:pages/settings?plugin=traffic&plx=country,





admin:plugins/home,
admin:plugins/home/activate/fake,
admin:plugins/home/deactivate/fake,
admin:plugins/home?plugin=profile,

admin:settings/home,

admin:support/home,
admin:support/item,
admin:support/security,
admin:support/contact,
admin:support/health,
admin:support/register,
admin:support/preview,


admin:theme/home/plugin/profile,
admin:theme/home,
admin:theme/components,
admin:theme/delcomponents,
admin:theme/home/plugin/profile,

admin:users/home,
admin:users/contact,
admin:users/edit,
admin:users/edit/userid/1,
admin:users/delete,
admin:users/home/plugin/profile
</cfsavecontent>




<cfoutput>
<cfloop index="i" list="#lstLink#">
	<cfif i EQ "">
		<hr />
	<cfelse>
		<h1><a href="/Pluma/index.cfm/#trim(i)#"> #i#</a></h1>
		<iframe height="350" width="95%" src="/Pluma/index.cfm/#trim(i)###bottom"></iframe>	
	</cfif>
</cfloop>
</cfoutput>
