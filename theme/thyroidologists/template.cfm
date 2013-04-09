<!---@ Description: I do site wide layout --->

<!---@ Designer: James Mohler--->
<!---@ Programmer: James Mohler--->

<!---@ Version History: 9 August 2011, Created by James Mohler --->
<!---@ Version History: 15 November 2011, Now with optional no nav by James Mohler --->


<cfparam name="rc.nonav" default="0">


<html>
<head>
	<cfoutput><title>#application.GSAPI.get_site_name()#</title></cfoutput>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	
	
	<style type="text/css">
		@import url(/theme/thyroidologists/assets/css/thyroidstyle.css);
		@import url(/theme/thyroidologists/assets/css/teamtable.css);
		@import url(/theme/thyroidologists/assets/css/calendar.css);
	</style>	
		
</head>


<cfif rc.nonav>
	<body class="body"><cfoutput>#body#</cfoutput></body></html>
	<cfexit>
</cfif>


<body bgcolor="#fefac4" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('/theme/thyroidologists/assets/images/A-over_07.jpg','/theme/thyroidologists/assets/images/A-over_08.jpg','/theme/thyroidologists/assets/images/A-over_09.jpg','/theme/thyroidologists/assets/images/A-over_10.jpg','images/A-over_11.jpg','/theme/thyroidologists/assets/images/A-over_12.jpg','/theme/thyroidologists/assets/images/A-over_13.jpg','/theme/thyroidologists/assets/images/A-over_14.jpg')">
	
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>	
	
	
<!-- ImageReady Slices (index.psd) -->

<table border="0" align="center" cellpadding="0" cellspacing="0" id="Table_01">
<form action="?" method="get"><input type="hidden" name="action" value="main.search" />
<tr>
	<td colspan="4" style="background-image : url(/theme/thyroidologists/assets/index_01.jpg); width : 950px; height : 87px; text-align : right; padding-top : 15px; color : white;">
	<a name="top"></a>
	<cfoutput>
	<span style="font-family : sans-serif;">Welcome - <b>#session.LOGINAPI.getLoginName()#</b></span>
	</cfoutput>
	
	&nbsp; &nbsp; &nbsp; &nbsp;
	<input type="search" name="search" placeholder="search" size="15" maxlength="30"><button type="submit">Search</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	</td>
</tr>
</form>
<tr>
		<td valign="top">
			<img src="/theme/thyroidologists/assets/index_02.jpg" width="25" height="237" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/index_03.jpg" width="575" height="237" alt=""></td>
		<td>
			<img src="http://www.thyroidologists.com/assets/banner/top/Thyroidologists%20Twitter%20lg.jpg" />
			<!--- <ui:banner type="top" height="237" width="325" /> --->
		</td>
		<td>
			<img src="/theme/thyroidologists/assets/index_05.jpg" width="25" height="237" alt=""></td>
</tr>
</table>

<table border="0" align="center" cellpadding="0" cellspacing="0" > 
<tr>
		<td>
			<img src="/theme/thyroidologists/assets/index_06.jpg" width="45" height="59" alt=""></td>
		<td>
			<a href="/index.cfm" onMouseOver="MM_swapImage('Image1','','assets/A-over_07.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_07.jpg" alt="" name="Image1" width="81" height="59" border="0" id="Image1"></a><a 
			href="?action=main.aboutus" onMouseOver="MM_swapImage('Image2','','assets/A-over_08.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_08.jpg" alt="" name="Image2" width="100" height="59" border="0" id="Image2"></a><a 
			href="?action=drintro.home" onMouseOver="MM_swapImage('Image3','','assets/A-over_09.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_09.jpg" alt="" name="Image3" width="117" height="59" border="0" id="Image3"></a><a 
			href="?action=main.patients" onMouseOver="MM_swapImage('Image4','','assets/A-over_10.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_10.jpg" alt="" name="Image4" width="118" height="59" border="0" id="Image4"></a><a 
			href="?action=main.locate" onMouseOver="MM_swapImage('Image5','','assets/A-over_11.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_11.jpg" alt="" name="Image5" width="139" height="59" border="0" id="Image5"></a><a 
			href="/index.cfm/login" onMouseOver="MM_swapImage('Image6','','assets/A-over_12.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_12.jpg" alt="" name="Image6" width="98" height="59" border="0" id="Image6"></a><a 
			href="?action=main.products" onMouseOver="MM_swapImage('Image7','','assets/A-over_13.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_13.jpg" alt="" name="Image7" width="90" height="59" border="0" id="Image7"></a><a 
			href="?action=main.contactus" onMouseOver="MM_swapImage('Image8','','assets/A-over_14.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="/theme/thyroidologists/assets/index_14.jpg" alt="" name="Image8" width="118" height="59" border="0" id="Image8"></a></td>
		<td>
			<img src="/theme/thyroidologists/assets/index_15.jpg" width="44" height="59" alt=""></td>
</tr>


<cfif isnumeric(session.LOGINAPI.UserID)>
<tr>
	<td background="/theme/thyroidologists/assets/index_16.jpg">&nbsp;</td>
	<td><ui:menu2 /></td>
	<td background="/theme/thyroidologists/assets/index_15.jpg">&nbsp;</td>
</tr>
</cfif>

<tr>
	<td background="/theme/thyroidologists/assets/index_16.jpg">
			<img src="/theme/thyroidologists/assets/index_16.jpg" width="44" height="397" alt=""></td>
	<td  bgcolor="white">
	<div align="center">
	
	
	<table width="850" border="0" cellpadding="0" cellspacing="0" class="body">
	<tr>
		<td><!-- InstanceBeginEditable name="EditRegion1" -->
		      
		      
		<cfif listlast(rc.action, '.') NEQ "click">
			<!--- if the page is not editable then it never gets a banner --->
			  <div style="float : right; margin-left : 5px; margin-top : 5px;">
			  	<ui:banner type="right" height="100" width="205" />
			  	
			  	<cfif rc.action EQ 'main.home'>
			  		<div style="width : 205px;"><ui:mainarticle /></div>			  	
			  	</cfif>			  
			  </div>  
		</cfif>      
	          
		      
		 <cfoutput>
		      	
		 <table>
		 <tr>
		 	<td><h1 id="pagetitle">#application.GSAPI.get_page_title()#</h1></td>
		 	<td>
		 	<cfif session.LOGINAPI.adhocSecurity("page") AND structKeyExists(application.stSetting.Page, listfirst(rc.action, '.'))>
		 		<cfif rc.action CONTAINS "main.loca">
		 			<!-- Do nothing -->
		 		<cfelseif isnumeric(rc.ArticleID)>
		 		<button onclick="location='?action=article.edit&ArticleID=#rc.articleID#'" title="Edit this article"><img src="/theme/thyroidologists/assets/icon/txt.png" /> Edit</button>
		 		<cfelse>
		 		<button onclick="location='?action=page.edit&fa=#rc.action#'" title="Edit this page"><img src="/theme/thyroidologists/assets/icon/htm.png" /> Edit</button>
		 		</cfif>
		 	
		
			</cfif>
		 	</td>
		 </tr>
		 </table>
		 
		   	
		      	
<!--- <ui:message /> --->




<cfparam name="rc.message" default="">

<cfif rc.message EQ 400>
	<p class="error"><img src="/theme/thyroidologists/assets/fatal.png" alt="Error" /> <b>400 Bad Request</b>
The request cannot be fulfilled due to bad syntax.</p>

<cfelseif rc.message EQ 404>
	<p class="error"><img src="/theme/thyroidologists/assets/fatal.png" alt="Error" /> <b>404 Error:</b> Missing Page. The original page you requested was missing. </p>
<cfelseif rc.message EQ "login">
	<p class="error"><img src="/theme/thyroidologists/assets/fatal.png" alt="Error" /> <b>Security Error:</b> You may need to login again. <a href="?action=login.home">Click here</a> to login</p>
	
<cfelseif rc.message NEQ "">

<cftry>
	
	<cfoutput>
		<p class="message"><img src="/theme/thyroidologists/assets/warning.png" /> #rc.message#</p>
	</cfoutput>	

<cfcatch></cfcatch>	
</cftry>
</cfif>



<cfoutput>#application.GSAPI.get_page_content()#</cfoutput>	
</cfoutput>
	        
		     <!-- InstanceEndEditable -->
    </td>
</tr>
</table>
		  <p>&nbsp;</p>
		</div></td>
	
	
		<!---
		<td colspan="2" bgcolor="#FFFFFF">
			<img src="/theme/thyroidologists/assets/index_18.jpg" width="208" height="397" alt=""></td>
		--->	
			
			
		<td  background="/theme/thyroidologists/assets/index_19.jpg">
			<img src="/theme/thyroidologists/assets/index_19.jpg" width="44" height="397" alt=""></td>
  </tr>

<tr>
	<td colspan="3">
		<img src="/theme/thyroidologists/assets/index_20.jpg" width="950" height="43" alt=""></td>
</tr>
 </table> 
  
 <table> 	
	<tr>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="25" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="19" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="1" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="81" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="100" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="117" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="118" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="139" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="98" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="90" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="118" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="19" height="1" alt=""></td>
		<td>
			<img src="/theme/thyroidologists/assets/spacer.gif" width="25" height="1" alt=""></td>
	</tr>
</table>


<table width="900" border="0" cellpadding="0" cellspacing="0" class="textlinks" align="center">
<tr>
	<td>

      	<a href="?">Home</a> 								| 
      	<a href="?action=main.aboutus">About Us</a> 		| 
      	<a href="?action=drintro.home">For Doctors</a> 		| 
      	<a href="?action=main.patients">For Patients</a> 	| 
      	<a href="?action=main.locate">Find a Doctor</a> 	| 
      	<a href="?action=login.home">Members</a> 			| 
      	<a href="?action=main.products">Products</a> 		| 
      	<a href="?action=main.aboutus">Contact Us</a>
      	
      	
      	
        <p>&copy;<cfoutput>#year(now())#</cfoutput> Thyroidologists.com. All rights reserved.<br>
          Web design and development by <a href="http://www.webworldinc.com" name="bottom">Web World, Inc.</a></p>
	</td>
</tr>
</table>
  <!-- End ImageReady Slices -->
  



</body>
</html>