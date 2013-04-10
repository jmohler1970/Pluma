


<cfimport prefix="ui" taglib="ui"> 

<div class="main">

<h3>Add Contact</h3>


<cfoutput>
<cfform action="#BuildURL(action = 'users.edit')#" method="post" id="rForm" class="anondata">


<p class="clearfix">
	<label>First Name <em>*</em></label>
	<cfinput type="text" name="firstname" class="text" required="yes" value="" maxLength="50" message="First name is required" />
</p>


<p>
	<label>Last Name <em>*</em></label>
    <cfinput type="text" name="lastname" class="text" required="yes" value="" maxLength="50" message="Last name is required" />
</p>

<div class="clear"></div>

<p>
	<label>Email <em>*</em></label>
    <cfinput type="text" name="email" class="text" value="" required="yes" maxLength="80" message="Email address is required" />
</p>

<div class="clear"></div>

<p>
	<label>Stars</label>
  	<cfmodule template="ui/stars.cfm" />
</p>

<h2>Business Info</h2>


<ui:contact formonly="true" />


<input type="submit" class="submit" value="Add" />

	



</cfform>
</cfoutput>


</div>
