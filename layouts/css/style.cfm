

<cfcontent type="text/css">
<cfsetting showDebugOutput="No">


<cfscript>
fileToRead = expandpath("./css.properties");





beforeCSS = "<?php echo $primary_0; ?>,<?php echo $primary_1; ?>,<?php echo $primary_2; ?>,<?php echo $primary_3; ?>,<?php echo $primary_4; ?>,<?php echo $primary_5; ?>,<?php echo $primary_6; ?>,<?php echo $secondary_0; ?>,<?php echo $secondary_1; ?>";

afterCSS = "##0E1316,##182227,##283840,##415A66,##618899,##E8EDF0,##AFC5CF,##9F2C04,##CF3805";


if (fileExists(expandpath("../../theme/admin.xml")))	{
	theFile = expandpath("../../theme/admin.xml");

	rawData 	= fileread(theFile);

	xmlData = xmlParse(rawData).item;
	
	
	afterCSS = 	"#xmlData.primary.darkest.xmlText#,#xmlData.primary.darker.xmlText#,#xmlData.primary.dark.xmlText#," &
				"#xmlData.primary.middle.xmlText#,#xmlData.primary.light.xmlText#,#xmlData.primary.lighter.xmlText#," &
				"#xmlData.primary.lightest.xmlText#,#xmlData.secondary.darkest.xmlText#, #xmlData.secondary.lightest.xmlText#";

	

	}


</cfscript>

<cffile action="read" file="#fileToRead#" variable="cssText" charset="utf-8">



<cfset cssText = replacelist(cssText, beforeCSS, afterCSS)>

<cfoutput>#cssText#</cfoutput>


