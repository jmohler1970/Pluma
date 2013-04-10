
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

