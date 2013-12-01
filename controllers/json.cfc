<cfcomponent extends="base">

<cfscript>

	function init(fw) { variables.fw = fw; }


	void function before()	{
		
		request.layout=false;	
		}



	

	void function pref(rc)	{
		param rc.pref = "";
		
		rc.response = application.IOAPI.get_pref(rc.pref);
		}	



	void function sitemap(rc)	{
		var NodeK = {NodeID = "max", Kind = "Sitemap"};
	
	
		
		rc.response = this.queryToArray(application.IOAPI.get_site_map(NodeK, 50)); 

		}	



	void function systemAdmins(rc)	{
		
		rc.response = this.queryToArray(application.USERAPI.get_system_admin());
		}
	


</cfscript>

</cfcomponent>

