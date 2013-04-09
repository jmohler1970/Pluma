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


<cfcomponent>

<cfset this.initStatus = "">


<cfscript>
string function stripHTML(required string str, numeric trimTo=100000) output="false" {
	return left(REReplaceNoCase(arguments.str,"<[^>]*>","","ALL"), arguments.trimTo);
	}
</cfscript>
	

<cffunction name="loadini" output="false" returnType="struct">
	<cfargument name="configfile" required="true" type="string" hint="reads from currentTemplate">


	<cfscript>
	var stResult = {};
	
	var iniFilePath = "#GetDirectoryFromPath(GetBaseTemplatePath())##arguments.configfile#";
	var stSection = getProfileSections(iniFilePath);
  
     
	for(var section in stSection)	{
      
      	var CurrentSection = evaluate("stSection.#section#");	
               
	 	var stData = {};
	  	
	  	for(var i = 1; i <= ListLen(CurrentSection); i++)	{
	  		var key = ListGetAt(CurrentSection, i);
	  
	       	stData[key] = getProfileString(iniFilePath, section, key);
	       	
	       	}
      
     	setvariable("stResult.#section#", stData);
     	}
     	
   
    return stResult;	
	</cfscript>
</cffunction>




<cffunction name="readPropertiesFile" returnType="Struct" hint="Read a properties file and return a structure">
    <cfargument name="propertiesFile" type="string" required="true" hint="path to properties file">

	
	<cfscript>
    VAR stProperties = {};
    VAR phpText = "";
    VAR key = "";
    VAR value = "";
    VAR line = "";
    
    var propertiesFilePath = "#GetDirectoryFromPath(GetBaseTemplatePath())##arguments.propertiesfile#";
    
    
    if (NOT FileExists(propertiesFilePath))
    
     	return stProperties;
        
    </cfscript>
 
 
    

    <!--- read props file --->
    <cffile action="read" file="#propertiesFilePath#" variable="phpText">
    
    

    <!--- remove any whitespace at top and tail --->
    <cfset phpText = trim(phpText)>

    <!--- remove comments and blank lines --->
    <cfset phpText = ReReplace(phpText,"(?m)\##.*?$", "","all")>
    <cfset phpText = ReReplace(phpText,"[#Chr(10)#]{2,}", "#Chr(10)#","all")>
    <cfset phpText = ReplaceList(phpText, '",', '"')>
 	
    

    <!--- loop over each line, ignore comments (#...) and insert keys/values into return struct --->
    <cfloop list="#phpText#" index="line" delimiters="#CHR(10)#">
        <cfscript>
        
        line = trim(line);
        splitAt = Find("=>", line);
        CommentAt = Find("//", line);
            
        if (splitAt != 0)	{
                           
            key =  replacelist(trim(Left(line, splitAt - 1)), '"', "");
            
            if (CommentAt == 0)
				value = replacelist(trim(Mid(line, splitAt + 2, 1000)), '"', '');
			else
            	value = replacelist(trim(Mid(line, splitAt + 2, CommentAt - (splitAt + 2))), '"', '');
			
			//  Remove trailing , 
			if (right(value, 1) == ",")
				value = mid(value, 1, len(value) - 1);
			
            
			if (right(value, 1) == "'")
				value = mid(value, 1, len(value) - 1);
			

			if (left(value, 1) == "'")
				value = mid(value, 2, 1000);
			


            stProperties[key] = value;
          	}
        </cfscript>
    </cfloop>

    <cfreturn stProperties>
</cffunction>



</cfcomponent>
