
<cfcomponent extends="base">

<cfscript>
void function init(fw) { variables.fw = fw; }




void function before(required struct rc)	{

	param rc.plugin = "";
	// This is managed over there
	if (rc.plugin != "" and fw.getItem() != "settings")	{
	
		variables.fw.redirect("settings.settings", "all");
		}
	
	
	param rc.path   = "";
	rc.uploadspath 	= "data/uploads/";
	rc.thumbspath 	= "data/thumbs/";
	}

	
void function home(required struct rc)	{

	param rc.imagefilter = "Show_All";
	rc.totalsize 		= 0;
	rc.qryDirectory		= QueryNew("Empty");
	
	rc.path = replace(rc.path, '|', '/', 'all');
	
	
	if (not DirectoryExists(application.GSDATAUPLOADPATH & rc.path))	{
		this.addInfo("NOT_FOUND", [rc.path]);
		
		return;
		}	
	
	rc.qryDirectory = DirectoryList(application.GSDATAUPLOADPATH & rc.path, 
		false, "query", "", "type,name");
	
	
	
	for (var j = 1; j <= rc.qryDirectory.recordcount; j++)	{
		rc.totalsize += rc.qryDirectory.size[j];
		}
	
	rc.totalsize = rc.totalsize \ 1024; 

	}


void function createfolder(required struct rc)	{

	rc.foldername = ReplaceList(rc.foldername,"/,\,<,[,^,>,],*,>,. ","");
	
	rc.foldername = Replace(rc.foldername, ",", "", "all");
	
	var target 		= application.GSDATAUPLOADPATH & rc.path & '/' & rc.foldername;
	var targetThumb = application.GSTHUMBNAILPATH & rc.path & '/' & rc.foldername;
	
	
	if (not DirectoryExists(target))	{
	
		directoryCreate(target);
		
		this.addInfo("FOLDER_CREATED", [rc.foldername]);
	
		}
	else	{
		this.addError("ERROR_FOLDER_EXISTS");
		}	
		
	
	if (not DirectoryExists(targetThumb))	{
	
		directoryCreate(targetThumb);
		}

	
	
	variables.fw.redirect("files.home", "all");
	}
</cfscript>


<cffunction name="process">
	<cfargument name="rc" required="true" type="struct">

	
		

<cfscript>


rc.nameconflict = "overwrite";


preResize = 200;


targetpath = "#application.GSDATAUPLOADPATH##rc.path#/";
thumbpath = "#application.GSTHUMBNAILPATH##rc.path#/";
</cfscript>





	<cftry>
		<cffile action="UPLOAD" filefield="csv1" destination="#targetpath#" nameconflict="#rc.nameconflict#">
	
		
		
		<cfscript>
			variables.targetname = cffile.serverfile;
			
				
			variables.targetname = replace(targetname,",","_","all");	// files with commas are problematic
				
				
			FileMove("#targetpath#\#cffile.serverfile#", "#targetpath#\#targetname#");
			
			if (cffile.serverFileExt == "jpg")	{
				myImage = ImageNew("#targetpath#\#targetname#"); 
				ImageResize(myImage, preResize, "");
				ImageWrite(myImage, "#thumbpath#\#targetname#");
				}	
		</cfscript>
	<cfcatch>
	
		
						
				
		<cfif NOT cfcatch.message CONTAINS "did not contain a file">
			<cfset this.addError("ERROR_UPLOAD")>
		</cfif>
		
		
		
	</cfcatch>
	</cftry>
	
	<cfset this.addInfo("PLUMACMS/FILE_SUC", [targetname])>
	
	<cfset variables.fw.redirect("files.home", "all")>
</cffunction>




<cffunction name="delete">
	<cfargument name="rc" required="true" type="struct">

	<cfscript>
	param rc.folder = "";
	
	if (rc.folder != "")	{
		var target 		= application.GSDATAUPLOADPATH & rc.path & '/' & rc.folder;
		var targetThumb = application.GSTHUMBNAILPATH & rc.path & '/' & rc.folder;
	
	
		if (DirectoryExists(target))	{
	
			directoryDelete(target);
			}
	
		if (DirectoryExists(targetThumb))	{
	
			directoryDelete(targetThumb);
			}
	
		this.addInfo("plumacms/folder_deleted", [rc.folder]);
	
		variables.fw.redirect("files.home", "all");
		
		return;
		}

	// must be working files
	
	
	var target 		= application.GSDATAUPLOADPATH & rc.path & '/' & rc.name;
	var targetThumb = application.GSTHUMBNAILPATH & rc.path & '/' & rc.name;
	
	
	if (FileExists(target))	{
	
			FileDelete(target);
			
			this.addInfo("ER_FILE_DEL_SUC", [target]);
	
			}
	
	if (FileExists(targetThumb))	{
	
		FileDelete(targetThumb);
		
		//this.AddInfo("plumacms/THUMB_DEL_SEC"");
		}

	</cfscript>

	<cfset variables.fw.redirect("files.home", "all")>
</cffunction>


<cfscript>
void function details(required struct rc)	{
	
	param rc.name = "";
	
	if (rc.name == "")	{

		this.addInfo("NOT_FOUND", [rc.name]);
		
		variables.fw.redirect("files.home", "all");
		}
	
	
	var target 		= application.GSDATAUPLOADPATH & rc.path & '/' & rc.name;
	var targetThumb = application.GSTHUMBNAILPATH & rc.path & '/' & rc.name;
	
	
	rc.info = {width = 0, height = 0, imageFolder = target};
	rc.info.exists = FileExists(rc.info.imageFolder);

	if (rc.info.exists)	{
		if (isImageFile(rc.info.imageFolder))	{
			img = ImageRead(rc.info.imageFolder);	
			StructAppend(rc.info, ImageInfo(img));
			//rc.exif = ImageGetEXIFMetaData(img);
			}
		}

	
	rc.infothumb = {width = 0, height = 0, imageFolder = targetThumb};
	rc.infothumb.exists = FileExists(rc.infothumb.imageFolder);

	if (rc.infothumb.exists)	{
		if (isImageFile(rc.infothumb.imageFolder))	{
			img = ImageRead(rc.infothumb.imageFolder);	
			StructAppend(rc.infothumb, ImageInfo(img));
			//rc.exif = ImageGetEXIFMetaData(img);
			}
		}
	
	
	
	}
</cfscript>


</cfcomponent>








