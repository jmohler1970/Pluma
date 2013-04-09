


<!---
	Coded by Fabien Meghazi a.k.a AMIGrAve (http://www.amigrave.com)
	The phonetic friendly mode was inspired from a javascript made by Michel Hoffmann (http://users.swing.be/michel.hoffmann)
--->
<!--- ************************** VALIDITE DES ARGUMENTS ************************************ --->


<cfcomponent hint="Creates Passwords. This is a stand alone component">

<cffunction name="GeneratePassword" hint="Generates Passwords" output="false" returntype="string">
	<cfargument name="attr" required="false" type="struct" hint="All the various password options">

<cfscript>
param attr.mode = "phon";
param attr.case = "lower";
param attr.length = 10;
</cfscript>

<cfif not(listcontainsnocase("alpha,num,mixed,phon", attr.mode)) or not(listcontainsnocase("upper,lower,mixed",attr.case))>
	<cfoutput>error in syntax:<br>#usage#</cfoutput>
	<cfreturn>
</cfif>

<cfif isnumeric(attr.length)>
	<cfset start=attr.length>
	<cfset stop=attr.length>
<cfelse>
	<cfif refind("([^0123456789,])|(,.+,)|,,|.+,$",attr.length)><cfoutput>error in length argument:<br>#usage#</cfoutput><cfabort></cfif>
	<cfset leng=listtoarray(attr.length)><cfset start=leng[1]><cfset stop=leng[2]>
</cfif>

<cfset pwd="">

<cfif attr.mode is "phon">

<cfscript>
voy	= [];
voy[1]="a,e,i,o";
voy[2]="u,ou,eu,an";
voy[3]="a,e,y";
voyf="17,4,1";

con = [];
con[1]="d,f,g,l,m,n,p,r,s,t";
con[2]="b,c,br,cr,str,ch";
con[3]="h,j,k,w,z,v,ss";
conf="5,4,1";


if (not(randrange(0,3)))	{
	phon	= "voy";
	tmp		= listtoarray(evaluate("#phon#f"));
	freq	= arraysum(tmp);
	i=randrange(0,freq-1);
	if (i < tmp[1])
		pwd &= listgetat(evaluate("#phon#[1]"), randrange(1,listlen(evaluate("#phon#[1]"))));
	else if (evaluate(i-tmp[1]+1) < tmp[2])
		pwd &= listgetat(evaluate("#phon#[2]"), randrange(1,listlen(evaluate("#phon#[2]"))));
	else
		pwd &= listgetat(evaluate("#phon#[3]"), randrange(1,listlen(evaluate("#phon#[3]"))));
	}
	
	
lengphon=randrange(start,stop);


while (len(pwd) < lengphon) {
	phon	= "con";
	tmp		= listtoarray(evaluate("#phon#f"));
	freq	= arraysum(tmp);
	i=randrange(0,freq-1);
	if (i < tmp[1])
		pwd &= listgetat(evaluate("#phon#[1]"), randrange(1,listlen(evaluate("#phon#[1]"))));
	else if (evaluate(i-tmp[1]+1) < tmp[2])
		pwd &= listgetat(evaluate("#phon#[2]"), randrange(1,listlen(evaluate("#phon#[2]"))));
	else
		pwd &= listgetat(evaluate("#phon#[3]"), randrange(1,listlen(evaluate("#phon#[3]"))));
	

	phon="voy";
	tmp=listtoarray(evaluate("#phon#f"));
	freq=arraysum(tmp);
	i=randrange(0,freq-1);
	if (i < tmp[1])
		pwd &= listgetat(evaluate("#phon#[1]"), randrange(1,listlen(evaluate("#phon#[1]"))));
	else if (evaluate(i-tmp[1]+1) < tmp[2])
		pwd &= listgetat(evaluate("#phon#[2]"), randrange(1,listlen(evaluate("#phon#[2]"))));
	else
		pwd &= listgetat(evaluate("#phon#[3]"), randrange(1,listlen(evaluate("#phon#[3]"))));
			
	}
</cfscript>


<!--- ********************************* Other Modes ************************************ --->
<cfelseif attr.mode is "num">
	<cfloop from="1" to="#randrange(start,stop)#" index="none">
		<cfset pwd &= chr(randrange(48,57))>
	</cfloop>
<cfelseif attr.mode is "alpha">
	<cfloop from="1" to="#randrange(start,stop)#" index="none">
		<cfset pwd &= chr(randrange(97,122))>
	</cfloop>
<cfelse>
	<cfloop from="1" to="#randrange(start,stop)#" index="none">
		<cfif randrange(0,2)>
			<cfset pwd &=  chr(randrange(97,122))>
		<cfelse>
			<cfset pwd &= chr(randrange(48,57))>
		</cfif>
	</cfloop>
</cfif>

<cfscript>

if (attr.case == "upper" and attr.mode != "num")
	pwd = ucase(pwd);
else if (attr.case == "mixed" and attr.mode != "num")	{
	rand = pwd;
	pwd = "";
	
	for(none = 1; none <= len(rand); none++)	{
		cr = left(rand,1);
		
		if (len(rand) - 1)	{ rand = right(rand,len(rand)-1); }
		
		if (not(randrange(0,3)))	{cr = ucase(cr); }
		
		pwd &= cr;
		}
	}	
</cfscript>


	<cfreturn pwd>
</cffunction>


</cfcomponent>