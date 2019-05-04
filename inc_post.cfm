<cfparam name="messagebody" default="">
<cfparam name="postedbyemail" default="">
<cfparam name="postedbyname" default="">
<cfif isdefined('form.postComment')>
	<cfif len(form.messagebody) LTE 10>
    <cfset msg = "Error! Please Post Message at least 10 Characters">
    <cfelse>
	<cfinvoke component="blogcfc.blog" method="postComment" argumentcollection="#form#"/>
    <cfset msg = "Cool! Comment added Successfully">
    <cflocation addtoken="no" url="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#&msg=#msg#">
    </cfif>
</cfif>
<cfform action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="POST" name="PostComment" id="PostComment">
  <table width="100%" border="0" cellpadding="0" cellspacing="3">
    <tr>
      <td height="27" colspan="2"><h3>Post Comments </h3></td>
    </tr>
    <cfif isdefined('msg')>
    <tr>
      <td height="76" colspan="2"><h3 align="center"><cfoutput>#trim(msg)#</cfoutput></h3></td>
    </tr>
    </cfif>
    <tr>
      <td height="27" colspan="2">Use the form below to post your comments.</td>
    </tr>
    <tr>
      <td width="200" height="26" nowrap><div align="right"><span class="important">*</span>Your
          Email Address:</div></td>
      <td width="0"><cfinput required="yes" message="Error! Provide valid email address" validate="email" name="postedbyemail" type="text" class="textfield_effect" id="postedbyemail" size="50" value="#postedbyemail#"></td>
    </tr>
    <tr>
      <td width="200" nowrap ><div align="right"><span class="important">*</span>Your
          Full 
          Name:</div></td>
      <td width="0"><cfinput required="yes" message="Error! Provide Your Name" name="postedbyname" type="text" class="textfield_effect" id="postedbyname" size="50" value="#postedbyname#"></td>
    </tr>
    <tr>
      <td width="200" valign="top" nowrap ><div align="right"><span class="important">*</span>Message:</div></td>
      <td width="0"><textarea name="messagebody" cols="37" rows="10" class="textfield_area" id="messagebody"><cfoutput>#messagebody#</cfoutput></textarea></td>
    </tr>
    <tr>
      <td width="200" height="34" ><div align="right"><span class="important">(*required)</span></div></td>
      <td width="0"><input name="postComment" type="submit" class="submit" value="Post Comment">
        &nbsp;&nbsp;
        <cfoutput><input name="ItemIDkey" type="hidden" id="ItemIDkey" value="#url.itemID#"></cfoutput>
        <input name="Activated" type="hidden" value="True" ></td>
    </tr>
    
  </table>
</cfform>
