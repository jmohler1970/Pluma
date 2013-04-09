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




<cfscript>
param rc.kind ="All";
param rc.taxonomy = true;
param rc.summary = "";

param rc.category 	= "";
param rc.facetType 	= "";
param rc.facet 		= "";
param rc.tag 		= "";


param rc.archiveyear = "";
param rc.archivemonth = "";


param rc.search = "";
param rc.random = 0;
param rc.href = "?";


param rc.StartAt = "1";
if (rc.startAt <= 0 OR NOT isnumeric(rc.startAt))	{
	rc.StartAt = 1;
	}


if (rc.startAt <= 0 OR NOT isnumeric(rc.startAt))	{
	rc.StartAt = 1;
	}


else if (isnumeric(rc.archiveyear))	{
	qryPage		= application.IOAPI.get_by_archive(rc.archiveyear, rc.archivemonth, rc.Kind);
	}
else if (rc.facetType != "")	{
	qryPage		= application.IOAPI.get_by_facet(rc.FacetType, rc.Facet, rc.Kind);
	}
else if (rc.tag != "")	{
	qryPage		= application.IOAPI.get_by_tag(rc.Tag, rc.Kind);
	}
else if (rc.search != "")	{
	qryPage		= application.IOAPI.get_by_search(rc.Search, rc.Kind);
	}
else if (rc.random == 1)	{
	qryPage		= application.IOAPI.get_by_random(rc.Kind);
	}
else	{
	qryPage 	= QueryNew("Empty");
	}	




</cfscript>




<cfif qryPage.recordcount EQ 0>

	<cfswitch expression="#rc.summary#">
		<cfcase value="Facet:conditional">
		<cfset qryFacet	= application.IOAPI.get_All_Facet()>	
	
		
		<div class="row">
		<cfoutput query="qryFacet" group="FacetType">
			<div class="span3">
				<h3>#FacetType#</h3>
				<cfoutput>
					<p><a href="/index.cfm/facet/#facetType#/#facet#">#FacetType# : #Facet#</a> (#FacetCount#)</p>
				</cfoutput>
			</div>
		</cfoutput>
		</div>
	</cfcase>

	<cfcase value="Archive:conditional">
		<cfset qryArchive	= application.IOAPI.getArchive()>	
	
		
		<div class="row">
		<cfoutput query="qryArchive" group="ArchiveYear">
			<div class="span2">
				<cfoutput>
					<p><a href="/index.cfm/archive/#archiveyear#/#archivemonth#">#MonthAsString(ArchiveMonth)# #ArchiveYear#</a> (#ArchiveCount#)</p>
				</cfoutput>
			</div>
		</cfoutput>
		</div>
	</cfcase>
	

	
	<cfcase value="Tag:conditional">
		<cfscript>
		variables.qryTags = cacheGet("AsideTags");
		if (isNull (variables.qryTags))	{
			cachePut("AsideTags", application.IOAPI.getAllTags());
			variables.qryTags = cacheGet("AsideTags");
			} 	
		</cfscript>


		<cfoutput query="qryTags">
			<cfset size = 5 + 2 * TagLevel>
			<cfif size GT 7>
				<a href="/index.cfm/tag/#urlencodedformat(Tags)#" style="font-size : #size#pt; white-space:nowrap;" >#Tags#</a> &nbsp; &nbsp;  &nbsp;
			</cfif>	
		</cfoutput>
	</cfcase>
	</cfswitch>


	<cfexit>
</cfif>





<cfif isnumeric(rc.archiveyear)>
	<cfoutput><p>Archives for: 
		<cfif isnumeric(rc.archivemonth)>
		#MonthAsString(rc.ArchiveMonth)#
		</cfif>
	 #rc.ArchiveYear#</p></cfoutput>
</cfif>

<ul class="thumbnails">
<cfoutput query="qryPage" startRow="#rc.startat#">
	
	
	<cfif ListFindNoCase(tags, "cool") NEQ 0>
		<li class="span6">
	<cfelse>
		<li class="span3">	
	</cfif>
	


	<div class="thumbnail">
	<cfif isnumeric(rank)>
	<div class="date">
		<div class="month">Rank</div>
		<div class="rank">#LSNumberFormat(Rank, '99.0')#%</div>
	</div>
	</cfif>	
	
	
		<h3>
		<cfswitch expression="#kind#">
		<cfcase value="Category">
			<a href="/index.cfm/category/#urlencodedformat(Title)#">#Title#</a> 
		</cfcase>
		<cfcase value="Blog">
			<a href="#buildURL(action = 'main.blog', querystring = 'BlogID=#NodeID#')#">#Title#</a> 
		</cfcase>
		<cfcase value="Photo">
			<a href="#buildURL(action = 'main.photo', querystring = 'PhotoID=#NodeID#')#">#Title#</a> 
		</cfcase>
		<cfcase value="Page">
			<a href="#buildURL(action = 'main.home', querystring = 'ID=#NodeID#')#">#Title#</a> 
		</cfcase>
		<cfdefaultcase>
			#Title#
		</cfdefaultcase> 
		</cfswitch>
		
		<span style="font-weight : normal;">(#Kind#)</span></h3>
		<h6>#application.GSAPI.stdDate(CreateDate)# by #CreateBy#</h6>
		
		<cfif Src NEQ "">
			<img src="#src#" title="#src#" /><br />
		</cfif>
		
		<cfif rc.taxonomy>
			<cfif strData CONTAINS "<p>">
				#application.IOAPI.stripHTML(strData, 200)#
			<cfelse>
				#paragraphformat(strData)#
			</cfif>
			
	
			<p>
			Parent Page: <a href="/index.cfm/category/#urlencodedformat(ParentTitle)#">#htmlEditFormat(ParentTitle)#</a> Tags: 	
			
			
			
			<cfloop index="i" list="#tags#">
				<a href="/index.cfm/tag/#URLEncodedFormat(i)#" style="white-space:nowrap;" 
					>#htmleditformat(i)#</a><cfif i NEQ ListLast(tags)>,</cfif>
			</cfloop>
			</p>
		</cfif>
	</div>	
	</li>
</cfoutput>
</ul>







