


<cffunction name="getSessionCount" returntype="numeric" output="false">
   <cfset var oSession = createObject("java","coldfusion.runtime.SessionTracker")>
   <cfreturn oSession.getSessionCount()>
</cffunction>


<cffunction name="getApplicationSessionCount"  returntype="numeric" output="false">
   <cfargument name="appName" type="string" required="true">
   <cfscript>
   var oSession = createObject("java","coldfusion.runtime.SessionTracker");
   var mySessions= oSession.getSessionCollection(arguments.appName);
   return StructCount(mySessions);
   </cfscript>
</cffunction>

<cffunction name="getRunningApplications"  returntype="array" output="false">
   <cfscript>
      var oApp = createObject("java","coldfusion.runtime.ApplicationScopeTracker");
      var applications = oApp.getApplicationKeys();   
      var availApps = ArrayNew(1);
   </cfscript>
   <cfloop condition="#applications.hasNext()#">
      <cfset arrayAppend(availApps,applications.next())>
   </cfloop>
   <cfreturn availApps>
</cffunction>





<cfset sessioncount = getSessionCount()>
<cfset runningApps = getRunningApplications()>

<div class="main">

<h3>Pluma Version</h3>


<table class="highlight healthcheck">
<tbody>
<tr>
	<td style="width : 450px;">Pluma Version</td>
	<td><span class="OKmsg"><b><cfoutput>#application.GSAPI.get_site_version()#</cfoutput></b></td>
</tr>
</tbody>
</table>


<h3>Server Setup</h3>


<table class="highlight healthcheck">
<tbody>
<cfoutput>
	<cfloop index="i" list="#structKeyList(rc.stSiteInfo)#">
	<tr>
		<td style="width : 450px; text-transform : capitalize;">#lcase(i)#</td>
		<td>#rc.stSiteInfo[i]#</td>
	</tr>
	</cfloop>
</cfoutput>
</tbody>
</table>


<h3>Data Usage</h3>

<table class="highlight healthcheck">
<tbody>
<cfoutput query="rc.qryKind" group="Section">
<tr>
	<th style="width : 250px;">#Section#</th>
	<th style="text-align : right;">Data Size</th>
	<!---
	<th style="text-align : right;">All Time</th>
	--->
	<th style="text-align : right;">Active</th>
	
	<!---
	<th style="text-align : right;">Completed</th>
	--->
</tr>

	<cfoutput>
		<cfif SectionSort EQ 10>
  			<cfset masteractivekind = activekindcount>
  		</cfif>
	
		<cfif SectionSort EQ 10>
  			<cfset mastercompletedkind = completedkindcount>
  		</cfif>
	
		
	
		<cfset kSize = datasize \ 1024>
	
		<tr>
			<td>#kind#</td>
			
			<td style="text-align : right;">#LSNumberFormat(ksize)#KB</td>
			
			<!---
			<td style="text-align : right;">#LSNumberFormat(kindcount)#</td>
			--->
			
			<td style="text-align : right; width : 80px;">
				<cfset width = masteractivekind EQ 0 ? 0 : (100 * activekindcount) \ masteractivekind>
			
			  	<div style="position:relative;"> &nbsp;
      				<div style="position:absolute;left:0;top:0;z-index:2;width:100%;">#LSNumberFormat(activekindcount)#</div>
      				<div style="position:absolute;left:0;top:0.7em; width : #width#%; height:0.3em;background-color:##eec6b9;z-index:1"></div>
    			</div>
			</td>
			
			<!---
			<td style="text-align : right; width : 80px;">
				<cfset width = mastercompletedkind EQ 0 ? 0 : (100 * completedkindcount) \ mastercompletedkind>
			
			
			    <div style="position:relative;"> &nbsp;
      				<div style="position:absolute;left:0;top:0;z-index:2;width:100%;">#LSNumberFormat(completedkindcount)#</div>
      				<div style="position:absolute;left:0;top:0.7em; width : #width#%; height:0.3em;background-color:##eec6b9;z-index:1"></div>
    			</div>
			</td>
			--->
		</tr>
	
	</cfoutput>
</cfoutput>
</tbody>
</table>




<h3>Memory</h3>


<cfscript> 
/** 
* Pass in a value in bytes, and this function converts it to a human-readable format of bytes, KB, MB, or GB. 
* Updated from Nat Papovich's version. 
* 01/2002 - Optional Units added by Sierra Bufe (sierra@brighterfusion.com) 
* 
* @param size     Size to convert. 
* @param unit     Unit to return results in. Valid options are bytes,KB,MB,GB. 
* @return Returns a string. 
* @author Paul Mone (sierra@brighterfusion.compaul@ninthlink.com) 
* @version 2.1, January 7, 2002 
*/ 
function byteConvert(num) { 
    var result = 0; 
    var unit = ""; 
    // Set unit variables for convenience 
    var bytes = 1; 
    var kb = 1024; 
    var mb = 1048576; 
    var gb = 1073741824; 
    // Check for non-numeric or negative num argument 
    if (not isNumeric(num) OR num LT 0) 
        return "Invalid size argument"; 
    // Check to see if unit was passed in, and if it is valid 
    if ((ArrayLen(Arguments) GT 1) 
        AND ("bytes,KB,MB,GB" contains Arguments[2])) 
    { 
        unit = Arguments[2]; 
    // If not, set unit depending on the size of num 
    } else { 
         if     (num lt kb) {    unit ="bytes"; 
        } else if (num lt mb) {    unit ="KB"; 
        } else if (num lt gb) {    unit ="MB"; 
        } else                {    unit ="GB"; 
        }        
    } 
    // Find the result by dividing num by the number represented by the unit 
    result = num / Evaluate(unit); 
    // Format the result 
    if (result lt 10) 
    { 
        result = NumberFormat(Round(result * 100) / 100,"0.00"); 
    } else if (result lt 100) { 
        result = NumberFormat(Round(result * 10) / 10,"90.0"); 
    } else { 
        result = Round(result); 
    } 
    // Concatenate result and unit together for the return value 
    return (result & " " & unit); 
} 
function formatMB(num){
	return num \ 1024 \ 1024;
	 
    //return byteConvert(num, "MB"); 
} 
// Create Java object instances needed for creating memory charts 
runtime = createobject("java", "java.lang.Runtime"); 
mgmtFactory = createobject("java", "java.lang.management.ManagementFactory"); 
pools = mgmtFactory.getMemoryPoolMXBeans(); 
heap = mgmtFactory.getMemoryMXBean(); 
jvm = structNew(); 
jvm["JVM_Used"] = formatMB(runtime.getRuntime().maxMemory()-runtime.getRuntime().freeMemory()); 
jvm["JVM_Max"] = formatMB(runtime.getRuntime().maxMemory()); 
jvm["JVM_Free"] = formatMB(runtime.getRuntime().freeMemory()); 
jvm["JVM_Total"] = formatMB(runtime.getRuntime().totalMemory()); 


jvm["Pool"] = 0;
for( i=1; i lte arrayLen(pools); i=i+1 ) 	{
	jvm["Pools_#pools[i].getName()#_Used"] = formatMB(pools[i].getUsage().getUsed());
	jvm["Pool"] = jvm["Pool"] + formatMB(pools[i].getUsage().getUsed());
	} 

</cfscript>

<cfoutput>
<form action="#buildurl(action = '.')###memory" method="post">
</cfoutput>

<table class="edittable highlight paginate">
<thead>
<tr>
	<th>Category</th>
	<th style="text-align : right;">Memory (MB)</th>
	<th style="text-align : center;">Status</th>
</tr>
</thead>
<cfloop list="#structkeylist(jvm)#" index="i">
	<tr>
	
	<cfset amount = jvm[i]>
	<cfset baramount = amount \ 10>
	<cfoutput>
		<td style="width : 400px;">#i#</td>
	
		<td style="text-align : right;">#amount#</td>
		
				
		<td style="text-align : center;">
		<cfif i EQ "JVM_Free">
			<cfif amount GTE 200>
				<span class="OKmsg"><b>#application.GSAPI.i18n("OK")#</b></span>
			<cfelseif amount GTE 100>
				Warning
			<cfelse>	
				Alert!
			</cfif>
		</cfif>
		&nbsp;		
		</td>
		
	</cfoutput>
	</tr>
</cfloop>
</table>

	<input type="submit" name="submit" class="submit" value="Garbage Collect" />
	
	<input type="submit" name="submit" class="submit" value="Update" />

</form>

<p></p>

<h3>Search Index</h3>
<p>Rebuild Text search index. You may want do this after making lots of changes</p>

<cfoutput>
<form action="#buildURL(action = 'settings.reindex')#" method="post">
</cfoutput>
	<button type="submit" name="submit">Reindex</button>
</form>


<cfset application.GSAPI.exec_action("healthcheck-extras", "", rc)>

</div>

