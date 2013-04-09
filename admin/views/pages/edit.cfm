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
myNodeID = isnumeric(rc.NodeID) ? "NodeID=#rc.NodeID#" : "";


</cfscript>

<cfparam name="rc.fa" default="">

<div class="main">




<cfoutput>
<cfif rc.NodeID EQ "">
	<h3 class="floated">#application.GSAPI.get_string("Create_New_Page")#</h3>
<cfelse>
	<h3 class="floated">#application.GSAPI.get_string("Page_edit_mode")#</h3>
</cfif>
</cfoutput>

	    <div class="edit-nav clearfix">	
	    
		<cfoutput query="rc.qryNode">   
	    	<a href="/index.cfm/main/#slug#" target="_blank" accesskey="v">#application.GSAPI.get_string("view")#</a>
	    
	    	<a href="##" id="metadata_toggle" accesskey="n">#application.GSAPI.get_string("page_options")#</a>
	    	
	    	<cfif isnumeric(rc.nodeID)>
	    		<a href="#buildURL(action = 'backups.history', querystring='nodeID=#NodeID#')#" onclick="doAdvanced()" accesskey="a">#application.GSAPI.get_string("page_backups")#</a>
	    	</cfif>
	    </cfoutput>
	    	
		</div>	 




<cfif rc.myPath NEQ "">
<div class="h5 clearfix">
	<div class="crumbs"><cfoutput>#rc.myPath#</cfoutput></div>
</div>	
</cfif>	


<cfform action="#buildurl(action = '.edit', querystring = myNodeID)#" name="myFrm">
	


<cfoutput query="rc.qryNode">    




	<p>
    	<input type="text" name="title" value="#htmleditFormat(title)#" class="text title" />
	</p>  
	
<div id="metadata_window" style="display : none;">



<div class="leftopt">	
	

	<p class="inline clearfix">
		<label class="control-label" for="firstname">Sub Title:</label>
	   
	    <input type="text" name="subtitle" value="#htmleditFormat(subtitle)#" maxlength="75"  class="text autowidth" />
	    
	</p>    


	<p class="inline clearfix">
		<label class="control-label" for="pstatus">#application.GSAPI.get_string("keep_private")#</label>
	   
	       	<select name="pstatus"  class="text autowidth">
			<cfloop index="ii" list="#application.stAdminSetting.Node.lstpstatus#">
				<option value="#ii#" <cfif ii EQ pStatus>selected</cfif>>#ii#</option>
			</cfloop>
			</select>
	</p>



	<p class="inline clearfix">
		<label class="control-label" for="firstname">#application.GSAPI.get_string("parent_page")#</label>

</cfoutput>

		<select name="ParentNodeID"  class="text autowidth">
			<option value="top">Top Level</option>
			
			<cfoutput query="request.qryPageParent">
				<option value="#NodeID#"  
					<cfif NodeID EQ rc.qryNode.ParentNodeID>selected="selected"</cfif>>
					<cfloop from="1" to="#level#" index="i">
							<span>&nbsp; &mdash; &nbsp;</span>
					</cfloop>
					
					 #htmleditformat(Title)#</option>
			</cfoutput>
			
		</select>
	    
	    <!--- If you link to yourself, then an error will be returned --->
	</p>
	
	
	<!--- Plugin --->
	<p class="inline clearfix">
		<label class="control-label" for="firstname">Plugin Content:</label>

		<select name="plugin_content"  class="text autowidth">
		
			<option value="">Default Content</option>
			
			<cfset application.GSAPI.exec_action("plugin_content", rc.qryNode.plugin_content)>
		</select>
	    

	</p>

<cfoutput query="rc.qryNode">	
	<!--- Theme --->
	<p class="inline clearfix">
		<label class="control-label" for="theme_template">Theme Template:</label>

	
		
		<select name="theme_template" class="text autowidth">
		
			<option value="">Default Template</option>
			
			<cfloop index="i" list="#rc.lstTheme_template#">
				<cfif i NEQ "template.cfm" AND i CONTAINS ".cfm">
				
					<option value="#i#" <cfif i EQ theme_template>selected="selected"</cfif>>
						#listFirst(i, '.')#
					</option>
				
				</cfif>
			</cfloop>
		</select>
	</p>
	

<p class="inline post-menu clearfix">
		<input type="checkbox" id="post-menu-enable" name="menustatus"
			<cfif menustatus EQ 1>checked="checked"</cfif> value="1"
			>&nbsp;&nbsp;&nbsp;<label for="post-menu-enable">Add this page to the menu</label>
</p>

	<div id="menu-items" <cfif menustatus NEQ 1> style="display : none;" </cfif>>
		<img src="#application.GSAPI.get_site_root()#admin/layouts/images/tick.png" id="tick">
		<span style="float:left;width:81%;"><label for="post-menu">Menu Text</label></span>
		<span style="float:left;width:10%;"><label for="post-menu-order">Priority</label></span>
		<div class="clear"></div>
		<input class="text" style="width:73%;" id="post-menu" name="menu" type="text" value="#htmleditformat(menu)#" />
		
		&nbsp;&nbsp;&nbsp;&nbsp;
		
		<select class="text" style="width:16%" id="post-menu-order" name="menuorder">
			<option value="">-</option>
			
			<cfloop from="1" to="20" index="i">
				<option value="#i#" <cfif menusort EQ i>selected="selected"</cfif>>#i#</option>	
			</cfloop>
		</select>
	</div>
</cfoutput>	
</div><!--- end of leftopt --->


<div class="rightopt">

<cfif isnumeric(rc.nodeid)>
<cfoutput query="rc.qryNode">
<p class="inline clearfix">
		<label class="control-label" for="firstname">Custom URL (Slug):</label>
		
		<input class="text short" type="text"name="slug" value="#slug#" readonly="readonly" disabled="disabled" />
 	
		
</p>
</cfoutput>



</cfif>

	<cfoutput>
	<p class="inline clearfix">
		<label class="control-label" for="tags">#application.GSAPI.get_string("tag_keywords")#</label>	

	

	<input type="text" name="tags" value="#rc.qryNode.Tags#" class="text"  />
 	</p>
	</cfoutput>

<!---
<p>
	<label for="post-metad" class="clearfix">Meta Description: <span id="countdownwrap"><strong id="countdown">155</strong> characters remaining</span></label>
	<textarea class="text" id="post-metad" name="post-metad">#htmledito#</textarea>
</p>
--->



	
	
<p class="inline clearfix">
	<label class="control-label" for="firstname">Redirect Page</label>
	
		<select name="redirect" class="text autowidth">
			<option></option>
			<cfoutput query="request.qryPageParent">
				<option value="#Slug#"  
					<cfif Slug EQ rc.qryNode.Redirect>selected="selected"</cfif>>
					<cfloop from="1" to="#level#" index="i">
							<span>&nbsp; &mdash; &nbsp;</span>
					</cfloop>
					
					 #htmleditformat(Title)#</option>
			</cfoutput>
		</select>	

</p>	


<cfoutput query="rc.qryNode">


<p class="inline clearfix">
	<label class="control-label" for="firstname">Thumbnail</label>
	
		<input type="text" name="src" value="#src#" maxlength="45" class="text" />
</p>	


	</div>
	
	<div class="clear"></div>
	
</div>


<table class="table">
<tr>
	<td colspan="5" style="width : 740px; height : 500px; text-align : center;">
	<cfif session.LOGINAPI.adhocSecurity("system")>
		<cftextarea name="strData" richtext="true" height="500" width="740">#strData#</cftextarea>
	<cfelse>
		<cftextarea name="strData" richtext="true" toolbar="Enhanced"  height="500" width="740">#strData#</cftextarea>
	</cfif>
	
	<cfif Len(strData) LT 10 and isnumeric(rc.nodeid)>
		<div class="updated">
			<strong>Warning!</strong> Page does not appear to have content
		</div>
	
	
	</cfif>
	
	</td>
</tr>
</table>



<div id="link_window" style="display : none;">	
		<cfinclude template="inc/links.cfm">
			
		<cfinclude template="inc/linksadd.cfm">

		<cfinclude template="inc/data.cfm">
</div>		
		



<h3 class="floated">
	
		<cfif deleted EQ 1>
			<button type="submit" name="submit">#application.GSAPI.get_string("ask_restore")#</button>
	
		<cfelse>
				
			<button type="submit" name="submit" value="save updates">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
			

		
			<button type="submit" name="submit" value="clone">#application.GSAPI.get_string("clone")#</button>
				
		</cfif>
		
</h3>		

			
			<cfif isnumeric(rc.NodeID)>
				<div class="edit-nav clearfix">
									
					<a href="#buildURL(action='pages.delete', querystring = 'nodeid=#rc.nodeid#')#"> #application.GSAPI.get_string("deletepage_title")#</a>
				</div>
			</cfif>
			

	</cfoutput>

</cfform>	


	<div class="clear"></div>
	


</div>

