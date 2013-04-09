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



 
<!--- Set the feed metadata. ---> 
<cfscript>
	qryBlog = application.IOAPI.get_feed("Blog");





	p = {};
	p.version = "atom_1.0";
	
	p.title = {};
	p.title.type = "text";
	p.title.value = "Atom Title";


	p.subtitle = {};
	p.subtitle.type = "text";
	p.subtitle.value = "My Sub Title";
	
	p.category = [];
	p.category[1] = {};
	p.category[1].term = "Fun Stuff";
	
	p.author = [];
	p.author[1] = {};
	p.author[1].name = "Raymond Camden";
	p.author[1].uri = "http://www.coldfusionjedi.com";
	p.author[1].email = "ray@camdenfamily.com";
	
	p.updated = now();


	meta.title 		= stPref.rss_title; 
	meta.link 		= stPref.rss_link; 
	meta.description = stPref.rss_description;
	meta.version 	= stPref.rss_version; 


</cfscript>

 
<!--- Create the feed. ---> 
<cffeed action	="create"  
    query		="#qryBlog#"  
    properties	="#p#" 
    xmlvar		="rc.rssXML"> 
 
<cfdump var="#XMLParse(rssXML)#">



