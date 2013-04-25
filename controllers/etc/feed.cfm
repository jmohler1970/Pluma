



 
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



