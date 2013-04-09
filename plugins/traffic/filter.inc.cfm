<!---
Copyright (c) 2012 James Mohler

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
param showfuseactionfilter =true;
param rc.showpull = 1;

param rc.qryTrafficDetails;
</cfscript>


<cfswitch expression="#rc.dateType#">
<cfcase value="Month">
	<cfset rc.filterDate = "#month(rc.filterdate)#/1/#year(rc.filterdate)#">

</cfcase>
</cfswitch>




<cfoutput>	
<form action="?plugin=traffic&plx=#rc.plx#" method="post">
</cfoutput>

    
    <cfoutput>
	
	<div  class="clearfix inline">
	
   		<label class="control-label" for="startDate">From</label>
		<input type="text" id="startDate" name="startDate" class="text" 
			value="#LSDateFormat( rc.startDate,'mm/dd/yyyy')#" maxlength="12" style = "width : 100px;" />
	
		<label class="control-label" for="endDate">To</label>
		<input type="text" id="endDate" name="endDate" class="text" 
			value="#LSDateFormat(rc.endDate,'mm/dd/yyyy')#" maxlength="12" style = "width : 100px;" />
   
	   <input type="submit" class="submit" value="Filter" />

    </div>
    
	</cfoutput>

	


<cfset masterhit = 0>
<cfset mastervisitor = 0>


<table class="edittable highlight">
<cfoutput query="rc.qryTrafficDetails" group="Area">   
      <tbody>
         <tr>
          <th colspan="2">#Area#</th>
          <th>Hits over Time</th>
          <th>Visits over Time</th>
          <th style="text-align : right;">Hits</th>
          <th style="text-align : right;">Visits</th>
        </tr>
<cfoutput group="Item" >        
     <tr>
          <td class="secondarylink">
            <input type="checkbox" name="data[]" value="total _TOTAL" style="margin-top:3px;">
          </td>
          <td title="">#replacelist(htmleditformat(Item), '&', ' &')#</td>
          <td style="width:130px;">
            <cfset maxhit = 0>
         	<cfset totalhit = 0>
         	<cfset totalday = 0>
         	
         	<cfoutput>
          		<cfif hit GT maxhit>
          			<cfset maxhit = hit>
          		</cfif>
          		
          		<cfset totalday++>
          		<cfset totalhit += hit>
          	</cfoutput>
          	
          	<cfif AreaSort EQ 1>
  				<cfset masterhit = totalhit>
  			</cfif>
  			  				
          	<cfset width = totalday EQ 0 ? 0 : 130 \ totalday>
          	<cfset currentday = 0>
          	
          	<div style="position:relative;width:130px;height:20px;border-bottom:solid 1px ##AFC5CF;">
          		         	
          		<cfoutput>
          			<cfset height = maxhit EQ 0 OR hit EQ 0 ? 0 : ((20 * hit) \ maxhit)> 
          			<cfset leftpos = width * currentday>
          			<cfset currentday++>
          				
          		
          			<div style="position:absolute;left:#leftpos#px;bottom:0px; width:#width#px; height : #height#px; background-color:##AFC5CF;z-index:1" title="2012-11-27: #hit# Hits(s)"></div>
          		
          		</cfoutput>
            </div>
  				
  
          </td>
          <td style="width:130px;">
          	
          	<cfset maxvisitor = 0>
         	<cfset totalvisitor = 0>
         	<cfset totalday = 0>
         	
         	<cfoutput>
          		<cfif visitor GT maxvisitor>
          			<cfset maxvisitor = visitor>
          		</cfif>
          		
          		<cfset totalday++>
          		<cfset totalvisitor += visitor>
          	</cfoutput>
          	
          	<cfif AreaSort EQ 1>
  				<cfset mastervisitor = totalvisitor>
  			</cfif>
  			  				
          	<cfset width = totalday EQ 0 ? 0 : 130 \ totalday>
          	<cfset currentday = 0>
          	
          	<div style="position:relative;width:130px;height:20px;border-bottom:solid 1px ##AFC5CF;">
          		         	
          		<cfoutput>
          			<cfset height = maxvisitor EQ 0 ? 0 : (20 * visitor) \ maxvisitor> 
          			<cfset leftpos = width * currentday>
          			<cfset currentday++>
          				
          		
          			<div style="position:absolute;left:#leftpos#px;bottom:0px; width:#width#px; height : #height#px; background-color:##AFC5CF;z-index:1" title="2012-11-27: #visitor# Visit(s)"></div>
          		
          		</cfoutput>
            </div>
          
          
          </td>
          <td style="width:10%;text-align:right;">
          		<cfset width = masterhit EQ 0 ? 0 : (100 * totalhit) \ masterhit>
          
                <div style="position:relative;"> &nbsp;
      				<div style="position:absolute;left:0;top:0;z-index:2;width:100%;">#totalhit#</div>
      				<div style="position:absolute;left:0;top:0.7em; width : #width#%; height:0.3em;background-color:##eec6b9;z-index:1"></div>
    			</div>
          </td>
          <td style="width:10%;text-align:right;">
          		<cfset width = masterhit EQ 0 ? 0 : (100 * totalvisitor) \ mastervisitor>
          
                <div style="position:relative;"> &nbsp;
      				<div style="position:absolute;left:0;top:0;z-index:2;width:100%;">#totalvisitor#</div>
      				<div style="position:absolute;left:0;top:0.7em; width : #width#%; height:0.3em;background-color:##eec6b9;z-index:1"></div>
    			</div>
          </td>
        </tr>
	</cfoutput>        
</cfoutput>
</tbody>        
</table>


</form>





