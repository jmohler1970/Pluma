
<!--- custom functions go here --->


<cfscript>
array function getTitle2(required string section, required string item) output="false"	{

	var arResult = ["",""];
		
	var keyTitle = 'request.stTitle.#arguments.section#["#arguments.item#"]';

	try	{
		arResult = ListToArray(evaluate(keyTitle), "|");
	
	}
	catch(any e) {}
	
		

	return arResult;
	}

	
request.getTitle = getTitle2;
</cfscript>	
	