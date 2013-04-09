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
carousel = application.GSTHEMESPATH & "bootswatch/assets/carousel/";

variables.qryCarousel = DirectoryList(carousel,"false","query", "*.jpg");
</cfscript>





<cfsavecontent variable="splash">
<div class="row">
	<div class="span2">&nbsp;</div>


    <div class="span8">

<div id="myCarousel" class="carousel slide">
	<div class="carousel-inner">
	
		
	
		<cfoutput query="variables.qryCarousel">
			<cfset arSlide = listToArray(evaluate("request.stTitle.Slide.slide#currentrow#"), "|")>
			

		
		<cfif currentrow EQ 1>
		<div class="active item">
		<cfelse>
		<div class="item">
		</cfif>
		    <img src="#application.GSAPI.get_site_root()#theme/bootswatch/assets/carousel/#name#" alt="" />
		    <div class="carousel-caption">
		      <h4>#arSlide[1]#</h4>
		      <p>#arSlide[2]#</p>
		    </div>
		</div>
		</cfoutput>
	</div>
	<a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
	<a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
</div>

	</div>

	<div class="span2">&nbsp;</div>
</div>	
</cfsavecontent>


<cfinclude template="template.cfm">

