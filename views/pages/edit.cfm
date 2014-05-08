



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
		<cfif slug NEQ "">  
    	<a href="#application.GSAPI.find_url(slug)#" target="_blank" accesskey="v">#application.GSAPI.i18n("view")#</a>
		</cfif>
    
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
		<label class="control-label" for="pstatus">#application.GSAPI.i18n("keep_private")#</label>
	   
	       	<select name="private"  class="text autowidth">
			<cfloop index="ii" list="#application.stSettings.Node.lstprivate#">
				<option value="#ii#" <cfif ii EQ private>selected="selected"</cfif>>#ii#</option>
			</cfloop>
			</select>
	</p>



	<p class="inline clearfix">
		<label class="control-label" for="ParentNodeID">#application.GSAPI.i18n("parent_page")#</label>

</cfoutput>

		<select name="parent"  class="text autowidth">
			<option value="top">Top Level</option>
			
			<cfoutput query="rc.qryPageParent">
				<option value="#parent#"  
					<cfif parent EQ rc.qryNode.Parent>selected="selected"</cfif>>
					
					 #xmlformat(Title)#</option>
			</cfoutput>
			
		</select>
	    
	    <!--- If you link to yourself, then an error will be returned --->
	</p>
	
	

<cfoutput query="rc.qryNode">	
	<!--- Theme --->
	<p class="inline clearfix">
		<label class="control-label" for="theme_template">Theme Template:</label>

	
		
		<select name="template" class="text autowidth">
		
			<option value="">Default Template</option>
			
			<cfloop index="i" list="#rc.lstTheme_template#">
				<cfif i NEQ "template.cfm" AND i CONTAINS ".cfm">
				
					<option value="#i#" <cfif i EQ template>selected="selected"</cfif>>
						#listFirst(i, '.')#
					</option>
				
				</cfif>
			</cfloop>
		</select>
	</p>
	

<p class="inline post-menu clearfix">
		<input type="checkbox" id="post-menu-enable" name="menustatus"
			<cfif menustatus EQ "Y">checked="checked"</cfif> value="Y"
			>&nbsp;&nbsp;&nbsp;<label for="post-menu-enable">#application.GSAPI.i18n("add_to_menu")#</label>
</p>

	<div id="menu-items" <cfif menustatus NEQ 1> style="display : none;" </cfif>>
		<img src="#application.GSAPI.get_site_root()#layouts/css/images/tick.png" id="tick" alt="tick" />
		<span style="float:left;width:81%;"><label for="post-menu">Menu Text</label></span>
		<span style="float:left;width:10%;"><label for="post-menu-order">Priority</label></span>
		<div class="clear"></div>
		<input class="text" style="width:73%;" id="post-menu" name="menu" type="text" value="#xmlformat(menu)#" />
		
		&nbsp;&nbsp;&nbsp;&nbsp;
		
		<select class="text" style="width:16%" id="post-menu-order" name="menuorder">
			<option value="">-</option>
			
			<cfloop from="1" to="20" index="i">
				<option value="#i#" <cfif menuOrder EQ i>selected="selected"</cfif>>#i#</option>	
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

	<!---
	<cfoutput>
	<p class="inline clearfix">
		<label class="control-label" for="tags">#application.GSAPI.i18n("tag_keywords")#</label>	

	

		<input type="text" name="tags" value="#rc.qryNode.Tags#" class="text"  />
 	</p>
	</cfoutput>
	--->


	
	
<p class="inline clearfix">
	<label class="control-label" for="redirect">Redirect Page</label>
	
		<select name="redirect" class="text autowidth">
			<option></option>
			<cfoutput query="rc.qryPageParent">
				<option value="#Slug#"  
					<cfif Slug EQ rc.qryNode.Redirect>selected="selected"</cfif>>
					
					 #xmlformat(Title)#</option>
			</cfoutput>
		</select>	

</p>	


<cfoutput query="rc.qryNode">



	</div>
	
	<div class="clear"></div>
	
	#application.GSAPI.exec_action("edit-extras")#
</div>



	<cfif session.LOGINAPI.adhocSecurity("system")>
		<cftextarea name="content" richtext="true" height="500" width="740">#content#</cftextarea>
	<cfelse>
		<cftextarea name="content" richtext="true" toolbar="Enhanced"  height="500" width="740">#content#</cftextarea>
	</cfif>
	
	#application.GSAPI.exec_action("edit-content")#
	
	



<div id="link_window" style="display : none;">	
	<cfinclude template="links.cfi">
</div>






<h3 class="floated" style="margin-top :0;" id="submit_line">
	
		<cfif deleted EQ 1>
			<button type="submit" name="submit">#application.GSAPI.i18n("ask_restore")#</button>
		<cfelse>
				
			<span>	
				<button type="submit" name="submit" class="save" value="Save"><img src="brk.png">#application.GSAPI.i18n("BTN_SAVECHANGES")#</button>
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

