<cfparam name="valid" default="false">
<cfif isdefined('form.uploadsubmit')>
  <cftry>
    <cfif isdefined('form.CategoryImageFile') AND form.CategoryImageFile NEQ "">
      <cffile action="upload" destination="#request.file_path#blog\CategoryImages" accept="image/*" 
    nameconflict="makeunique" filefield="CategoryImageFile">
      <cfset resizeFile = "#cffile.ServerFile#">
      <cfset imageCFC = createObject("component","cfmllinks.core.cfc.image")/>
      <cfset imageCFC.resize('','#request.file_path#blog\CategoryImages\#resizefile#','#request.file_path#blog\CategoryImages\rr_#resizefile#',100,40) />
      <cfif fileexists('#request.file_path#blog\CategoryImages\#resizefile#')>
        <cffile action="delete" file="#request.file_path#blog\CategoryImages\#resizefile#">
      </cfif>
      <cfset form.CategoryImageFile = "rr_#resizefile#">
      <cfinvoke component="blogcfc.blog" method="updateimage" argumentcollection="#form#"/>
      <cfset msg = "Cool! Image Added and Updated">
      <cfset valid = True>
      <cfelse>
      <cfset msg = "Error! Please Provide Image File to Upload">
    </cfif>
    <cfcatch type="any">
      <cfset msg = "#cfcatch.Detail# #cfcatch.Message#">
    </cfcatch>
  </cftry>
</cfif>
<link href="blogcss.css" rel="stylesheet" type="text/css">
<title>Upload Image</title>
<cfform ACTION="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" METHOD="post" enctype="multipart/form-data">
  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
    <tr>
      <th height="28"><div align="left">Upload Category Image: <cfoutput>#url.cat#</cfoutput></div></th>
    </tr>
    <cfif isdefined('msg')><tr><td align="left"><cfoutput>#trim(msg)#</cfoutput></td></tr></cfif>
    <tr>
      <td nowrap><cfif valid eq True>File Uploaded & Updated<cfelse><input name="CategoryImageFile" type="file" class="textfield_effect" style="height:20px;"></cfif></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td nowrap><input name="uploadsubmit" type="submit" class="submit" value="Upload Image">
        <input type="button" class="submit" onClick="javascript:self.close();" value="Close Window"></td>
    </tr>
  </table>
  <cfoutput>
    <input type="hidden" name="MM_recordId" value="#url.CategoryID#">
  </cfoutput>
</cfform>
