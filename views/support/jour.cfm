
<cfoutput>
<div class="main">

<h3 class="floated">#application.GSAPI.i18n("VIEWING")#: &lsquo;<em>#rc.Kind#</em>&rsquo;</h3>


<div class="edit-nav clearfix">
	<a href="#buildURL(action='.', querystring="clear=1")#" accesskey="r">#application.GSAPI.i18n("CLEAR_THIS_LOG")#</a>
</div>	
</cfoutput>


<ol class="more">
<cfoutput query="rc.qryRecentLogin">
<li>
	<p style="font-size:11px;line-height:15px;">	
	<b style="line-height:20px;">#application.GSAPI.i18n("LOG_FILE_ENTRY")#</b><br />
	

	<b>Date</b>: #application.IOAPI.std_date(datetime)#<br/>	
	<b>Username</b>: #by#<br/>	
	<b>IP_Address</b>: #ip#<br/>	
	<b>Reason</b>: #message#<br />	
		
	</p>
</li>
</cfoutput>
</ol>



<cfif rc.qryRecentLogin.recordcount EQ 0>
	<cfoutput>
		<p><em>#application.GSAPI.i18n("LOG_FILE_EMPTY")#</em></p>
	</cfoutput>
</cfif>

</div>
