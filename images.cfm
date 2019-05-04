<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Logo Images</title>
<link href="blogcss.css" rel="stylesheet" type="text/css" />
<script language="javascript">
function showHide() {
  if (document.getElementById("showdiv").style.display == "none") {
    document.getElementById("showdiv").style.display = '';
        //document.getElementById("t2").style.display = '';
 
  } else {
    document.getElementById("showdiv").style.display = 'none';
        //document.getElementById("t2").style.display = 'none';
 
  }
}
</script>
</head>
<cfif isdefined('form.Create')>
  <cfset NewDirectory = "#form.createDirectory#">
  <cfset NewUploadDir = ExpandPath("headers/#NewDirectory#")>
  <cfset TAB = Chr(9)>
  <cfif NOT DirectoryExists(NewUploadDir)>
    <cfdirectory action="create" directory="#NewUploadDir#" mode="777">
  </cfif>
  <cfset msg = "Directory Created Successfully">
</cfif>
<body>
<form id="form1" name="form1" method="post" action="">
  <table width="100%" border="0" cellspacing="2" cellpadding="1">
    <cfif isdefined('msg')>
      <tr>
        <td colspan="3"><cfoutput>#trim(msg)#</cfoutput></td>
      </tr>
    </cfif>
    <tr>
      <td width="25%">Create New Directory:</td>
      <td width="20%"><input name="createDirectory" type="text" class="textfield_effect" id="createDirectory" tabindex="1" /></td>
      <td width="55%"><label>
          <input name="Create" type="submit" class="submit" id="Create" tabindex="2" value="New Directory" />
        </label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3"><table width="100%" border="0" align="left" cellpadding="1" cellspacing="2">
          <tr>
            <td align="left">List of Directories:</td>
          </tr>
          <tr>
            <td><cfdirectory action="list" directory="#request.file_path#\blog\headers\" recurse="no" name="currentDir" sort="size desc">
              <table align="center" width="80%">
                <tr align="left">
                  <th>Name</th>
                  <th>Size</th>
                  <th>DateLastModified</th>
                  <th>Type</th>
                </tr>
                <cfloop query="currentDir">
                  <cfoutput>
                    <tr align="left">
                      <td><a href="#CGI.SCRIPT_NAME#?dirName=#currentDir.Name#">#currentDir.Name#</a></td>
                      <td>#currentDir.Size#</td>
                      <td>#currentDir.DateLastModified#</td>
                      <td><a href="#CGI.SCRIPT_NAME#?list=files&dir=#currentDir.Name#">#currentDir.Type#</a></td>
                    </tr>
                  </cfoutput>
                </cfloop>
                <tr>
                  <td colspan="4">(* Click on Type to View all Files underneath the Selected Directory)</td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<cfif IsDefined('url.dirName')>
  <br />
  <cfif isdefined('form.UploadPIcture')>
    <cfparam name="form.t2" default="100">
    <cfparam name="form.t1" default="30">
    <cftry>
      <cfif len(form.uploadfile) IS "">
        <cfset msg = "Error! Please Upload Image File First">
        <cfelse>
        <cfif IsDefined('form.resizeit')>
          <cfif len(form.t2) IS 0 AND Not isNumeric(form.t2)>
            <cfset msg = "Error! Provide Width in numbers Only">
            <cfelseif len(form.t1) IS 0 AND Not isNumeric(form.t1)>
            <cfset msg = "Error! Provide Height in numbers Only">
            <cfelse>
            <cffile accept="image/*" action="upload" destination="#request.file_path#blog\headers\#form.dirfile#" filefield="uploadfile" nameconflict="overwrite">
            <cfset resize = "#cffile.ServerFile#">
            <cfset imageCFC = createObject("component","blogcfc.image") />
            <cfset imageCFC.resize('','#request.file_path#blog\headers\#form.dirfile#\#resize#','#request.file_path#blog\headers\#form.dirfile#\rr_#resize#',#form.t2#,#form.t1#) />
            <cfif fileexists('#request.file_path#blog\headers\#form.dirfile#\#resize#')>
              <cffile action="delete" file="#request.file_path#blog\headers\#form.dirfile#\#resize#">
            </cfif>
            <cfset resize = "rr_#resize#">
          </cfif>
          <cfelse>
          <cffile accept="image/*" action="upload" destination="#request.file_path#blog\headers\#form.dirfile#" filefield="uploadfile" nameconflict="overwrite">
          <cfset resize = "#cffile.ServerFile#">
        </cfif>
        <cfset msg = "Cool! File Uploaded Successfully, Upload More">
      </cfif>
      <cfcatch type="any">
        <cfset msg = "#cfcatch.Detail# #cfcatch.Message#">
      </cfcatch>
    </cftry>
  </cfif>
  <cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" enctype="multipart/form-data">
    <table align="left" width="100%">
      <cfif isdefined('msg')>
        <tr>
          <td><cfoutput>#trim(msg)#</cfoutput></td>
        </tr>
      </cfif>
      <tr>
        <td>Upload Image:</td>
      </tr>
      <tr>
        <td><label>
            <input name="uploadfile" type="file" class="textfield_effect" id="uploadfile" style="height:20px;" />
          </label></td>
      </tr>
      <tr>
        <td><label>
            <input type="checkbox" name="resizeit" id="resizeit" onclick='JavaScript: showHide();' />
            Should we Resize</label></td>
      </tr>
      <div id="showdiv" style="display:none"> Height:
        <cfinput type="text" name="t1" value="30" id="t1" maxlength="3" size="4">
        Width:
        <cfinput type="text" name="t2" value="100" id="t2" maxlength="3" size="4">
      </div>
      <tr>
        <td><label>
            <input name="UploadPIcture" type="submit" class="submit" id="UploadPIcture" value="Upload Picture" />
            <cfoutput>
              <input type="hidden" name="dirfile" value="#url.dirName#" />
            </cfoutput> </label></td>
      </tr>
    </table>
  </cfform>
</cfif>
<cfif isdefined('url.list') AND url.list eq 'files'>
  <table align="center" width="80%">
  <tr>
    <td colspan="5" align="left">List All Files</td>
  </tr>
  <tr>
  <td>
  <cfform method="post" name="color">
  <cfdirectory action="list" directory="#request.file_path#blog\headers\#url.dir#" recurse="yes" name="showfiles">
  <table align="center" width="100%" border="0">
    <tr align="left">
      <th>S.No</th>
      <th>Name</th>
      <th>Size</th>
      <th>DateLastModified</th>
      <th>Type</th>
    </tr>
    <cfif showfiles.recordcount>
      <cfloop query="showfiles">
      <cfset myName = rereplacenocase(Name,"([^0-9])","","ALL")>
        <cfoutput>
          <tr align="left">
            <td><cfinput type="radio" name="fileName_#myName#" value="headers/#url.dir#/#showfiles.Name#" onClick="window.opener.document.settings.General_AppLogo.value = document.color.fileName_#myName#.value;javascript:self.close(0);"></td>
            <td><a href="#CGI.SCRIPT_NAME#?view=#showfiles.Name#&d=#url.dir#">#showfiles.Name#</a></td>
            <td>#showfiles.Size#</td>
            <td>#showfiles.DateLastModified#</td>
            <td>#showfiles.Type#</td>
            Use This</a></td>
          </tr>
        </cfoutput>
      </cfloop>
      <cfelse>
      <tr>
        <td colspan="5" align="center">No Files Under this <cfoutput>#url.dir#</cfoutput></td>
      </tr>
    </cfif>
    </td>
    </tr>
    
  </table>
  </cfform>
</cfif>
<cfif isDefined('url.view')>
  <br />
  <cfoutput><img src="#request.siteURL#headers/#url.d#/#view#" /></cfoutput>
</cfif>
</body>
</html>