

<cfcomponent>

<cfset this.initStatus = "">


<cfscript>
string function strip_tags(required string str, numeric trimTo=100000) output="false" {
	return left(REReplaceNoCase(arguments.str,"<[^>]*>","","ALL"), arguments.trimTo);
	}
</cfscript>
	

<cffunction name="load_ini" output="false" returnType="struct">
	<cfargument name="configfile" required="true" type="string" hint="reads from currentTemplate">


	<cfscript>
	var stResult = {};
	
	var iniFilePath = "#application.GSROOTPATH##arguments.configfile#";
	var stSection = getProfileSections(iniFilePath);
  
     
	for(var section in stSection)	{
      
      	var CurrentSection = stSection[section];	
               
	 	var stData = {};
	  	
	  	for(var i = 1; i <= ListLen(CurrentSection); i++)	{
	  		var key = ListGetAt(CurrentSection, i);
	  
	       	stData[key] = getProfileString(iniFilePath, section, key);
	       	
	       	}
      
     	stResult[section] = stData;
     	}
     	
   
    return stResult;	
	</cfscript>
</cffunction>




<cffunction name="readPropertiesFile" returnType="Struct" hint="Read a properties file and return a structure">
    <cfargument name="propertiesFilePath" type="string" required="true" hint="path to properties file">
	<cfargument name="plugin" type="string" required="true" hint="path to properties file">
	
	<cfscript>
    var stProperties = {};
    var phpText = "";
    var key 	= "";
    var value 	= "";
    var line 	= "";
    
 
    
    
    if (NOT FileExists(arguments.propertiesFilePath))	{
        
     	return stProperties;
        }
    </cfscript>
 
 
    

    <!--- read props file --->
    <cffile action="read" file="#propertiesFilePath#" variable="phpText" charset="utf-8">
    


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
            
            key = replace(key, ',','', 'all');
            key = trim(replace(key, "'","", 'all'));
            
   
            
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
			

			// Plugins get slash separated		
			if (arguments.plugin == "")	{
            	stProperties[key] = value;
            	}
            else	{
	            stProperties["#plugin#/#key#"] = value;	            	
           		}	
            	
          	}
        </cfscript>
    </cfloop>
    


    <cfreturn stProperties>
</cffunction>




</cfcomponent>
