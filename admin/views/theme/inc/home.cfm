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




<cfoutput>
<form action="#buildURL(action='menu.home', querystring='extra=#rc.extra#')#" method="post" name="myFrm" class="form-horizontal">
	<input type="hidden" name="MenuID" value="#rc.MenuID#" />
</cfoutput>




	<legend>Update Links</legend>

<cfoutput query="rc.qryNode"> 

	<div class="control-group error">
      	<label class="control-label" for="value">Title</label>
        <div class="controls">
        	<input type="text" name="title" value="#htmleditformat(title)#" /> 
        </div>
	</div>

</cfoutput>




	<cfinclude template="../page/ui/links.cfm">



	<div class="form-actions">
		
		<cfoutput>
			<a class="btn btn-danger" href="#buildURL(action='menu.delete', querystring = 'menuid=#rc.menuid#')#"><i class="icon-trash icon-white"></i> Delete All</a>
		</cfoutput>
		
<button type="submit">#application.GSAPI.get_string("BTN_SAVECHANGES")#</button>
	</div>	






<cfif isnumeric(rc.menuID) and  rc.qryLink.recordcount EQ 0>

	<div class="alert">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
  		<strong>Warning!</strong> Most of this menu has been removed. You can either add new items or remove unused data
	</div>


</cfif>
	
	

		<cfinclude template="../page/ui/linksadd.cfm">
	
	<div class="form-actions">
		<button type="submit" name="submit" value="Add" class="btn btn-primary"><i class="icon-plus icon-white"></i> Add</button>
	</div>	
</form>	

	