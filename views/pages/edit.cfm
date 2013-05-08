



<cfscript>
myNodeID = isnumeric(rc.NodeID) ? "NodeID=#rc.NodeID#" : "";


</cfscript>

<cfparam name="rc.fa" default="">

<div class="main">




<cfoutput>
<cfif rc.NodeID EQ "">
	<h3 class="floated">#application.GSAPI.i18n("Create_New_Page")#</h3>
<cfelse>
	<h3 class="floated">#application.GSAPI.i18n("Page_edit_mode")#</h3>
</cfif>
</cfoutput>

    <div class="edit-nav clearfix">	
    
	<cfoutput query="rc.qryNode">   
    	<a href="#application.GSAPI.find_url(slug)#" target="_blank" accesskey="v">#application.GSAPI.i18n("view")#</a>
    
    	<a href="##" id="metadata_toggle" accesskey="n">#application.GSAPI.i18n("page_options")#</a>
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
    	<input type="text" name="title" value="#xmlformat(title)#" class="text title"
    		placeholder="#application.GSAPI.i18n("Page_title")#" />
	</p>  
	
<div id="metadata_window" style="display : none;">



<div class="leftopt">	
	

	<p class="inline clearfix">
		<label class="control-label" for="firstname">#application.GSAPI.i18n("plumacms/Page_subtitle")#</label>
	   
	    <input type="text" name="subtitle" value="#xmlformat(subtitle)#" maxlength="75"  class="text autowidth" />
	    
	</p>    


	<p class="inline clearfix">
		<label class="control-label" for="pstatus">#application.GSAPI.i18n("keep_private")#</label>
	   
	       	<select name="pstatus"  class="text autowidth">
			<cfloop index="ii" list="#application.stSettings.Node.lstpstatus#">
				<option value="#ii#" <cfif ii EQ pStatus>selected</cfif>>#ii#</option>
			</cfloop>
			</select>
	</p>



	<p class="inline clearfix">
		<label class="control-label" for="firstname">#application.GSAPI.i18n("parent_page")#</label>

</cfoutput>

		<select name="ParentNodeID"  class="text autowidth">
			<option value="top">Top Level</option>
			
			<cfoutput query="request.qryPageParent">
				<option value="#NodeID#"  
					<cfif NodeID EQ rc.qryNode.ParentNodeID>selected="selected"</cfif>>
					<cfloop from="1" to="#level#" index="i">
							<span>&nbsp; &mdash; &nbsp;</span>
					</cfloop>
					
					 #xmlformat(Title)#</option>
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
			>&nbsp;&nbsp;&nbsp;<label for="post-menu-enable">#application.GSAPI.i18n("add_to_menu")#</label>
</p>

	<div id="menu-items" <cfif menustatus NEQ 1> style="display : none;" </cfif>>
		<img src="#application.GSAPI.get_site_root()#admin/layouts/images/tick.png" id="tick">
		<span style="float:left;width:81%;"><label for="post-menu">Menu Text</label></span>
		<span style="float:left;width:10%;"><label for="post-menu-order">Priority</label></span>
		<div class="clear"></div>
		<input class="text" style="width:73%;" id="post-menu" name="menu" type="text" value="#xmlformat(menu)#" />
		
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
		<label class="control-label">#application.GSAPI.i18n("SLUG_URL")#</label>
	
		<!--- This does not submit anything --->	
		<input class="text short" type="text" value="#slug#" readonly="readonly" disabled="disabled" />
		
		<input type="hidden" name="slug" value="#slug#" />
	
</p>
</cfoutput>



</cfif>

	<cfoutput>
	<p class="inline clearfix">
		<label class="control-label" for="tags">#application.GSAPI.i18n("tag_keywords")#</label>	

	

	<input type="text" name="tags" value="#rc.qryNode.Tags#" class="text"  />
 	</p>
	</cfoutput>



	
	
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
					
					 #xmlformat(Title)#</option>
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
		<cfinclude template="links.cfi">
			
		<cfinclude template="data.cfi">
</div>






<h3 class="floated" id="submit_line">
	
		<cfif deleted EQ 1>
			<button type="submit" name="submit">#application.GSAPI.i18n("ask_restore")#</button>
		<cfelse>
				
			<span>	
				<button name="submit" type="submit" value="Save">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
			</span>

			<cfif isnumeric(rc.NodeID)>	
				<button type="submit" name="submit" value="clone">#application.GSAPI.i18n("CLONE")#</button>
			</cfif>	
		</cfif>
		
</h3>		

			
			<cfif isnumeric(rc.NodeID)>
				<div class="edit-nav clearfix" id="alertme">
									
					<a href="#buildURL(action='pages.delete', querystring = 'nodeid=#rc.nodeid#')#"> #application.GSAPI.i18n("deletepage_title")#</a>
				</div>
			</cfif>
			

	</cfoutput>

</cfform>	

<cfif isnumeric(rc.nodeID)>
<cfoutput query="rc.qryNode"> 
	<p class="backuplink" >
		#application.GSAPI.i18n("LAST_SAVED", [modifyby])# #application.IOAPI.std_date(modifyDate)#
		
		&nbsp;&nbsp;
		&bull;
		&nbsp;&nbsp; 

  		<a href="#buildURL(action = 'backups.home', querystring='nodeID=#NodeID#')#"  accesskey="a">#application.GSAPI.i18n("BACKUP_AVAILABLE")#</a>
  	</p>
</cfoutput>
</cfif>

	<div class="clear"></div>
	


</div>

