<cfsavecontent variable="a">
<cfoutput>#cgi.SERVER_NAME##cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#</cfoutput>
</cfsavecontent>
<cfif isdefined('form.SendToFriendManager')>
	<cfif len(form.sendtoname) IS 0>
    <cfset msg = "Error! Recipients Name is required">
    <cfelseif len(form.sentfromname) IS 0>
    <cfset msg = "Error! Sender's Name is required">
    <cfelseif NOT REFindnocase("^[-_!a-z0-9\.]+@([-_a-z0-9]+\.)+[a-z]{2,6}$", sendtoemail)>
    <cfset msg = "Error! Recipients email address is invalid">
    <cfelseif NOT REFindnocase("^[-_!a-z0-9\.]+@([-_a-z0-9]+\.)+[a-z]{2,6}$", sentfromemail)>
    <cfset msg = "Error! Sender's email address is invalid">
    <cfelse>
    <cfif len(form.messagesubject) IS "">
    <cfset form.messagesubject = "A Blog Link is recieved">
    <cfelse>
    <cfset form.messagesubject = "#form.messagesubject#">
    </cfif>
    <cfmail to="#form.sendtoemail#" from="#w#" bcc="#w#" username="#MailUser#" password="#Mailpass#" port="#MPort#" 
    type="html" subject="#form.messagesubject#" server="#MServer#" failto="#Mfailto#">
	   Your Friend has send you this Blog Link: <br />
        <br />
        Here is Blog Link:<br />
        <br />
        http://#form.url#<br />
        <hr />
        <br />
        Regards,<br />
        <br />
        <strong>#Request.siteURL#</strong><br />
      </cfmail>
      <cfset msg = "Cool! Email Send Successfully">
    </cfif>
</cfif>
<cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" name="SendToFriend" id="SendToFriend">
<table width="100%" border="0" cellpadding="0" cellspacing="3">
<cfif isdefined('msg')>
    <tr>
      <td height="76" colspan="2">
          <h3 align="center"><cfoutput>#trim(msg)#</cfoutput></h3>
</td>
    </tr>
    </cfif>
  <tr>
      <td height="27" colspan="2"><h3>Send to Friend </h3></td>
  </tr>
    <tr>
      <td height="27" colspan="2">Use the form below to send a private email message to the author.</td>
    </tr>
    <tr>
      <td width="200" height="26" nowrap><div align="right"><span class="important">*</span>Recipients
      email address:</div></td>
      <td width="0"><cfinput type="text" name="sendtoemail" 
      message="Error! Provide Recipients Valid Email Address" validate="email" required="yes" class="textfield_effect" id="sendtoemail" size="50"></td>
    </tr>
    <tr>
      <td width="200" nowrap ><div align="right"><span class="important">*</span>Recipients
      name:</div></td>
      <td width="0"><cfinput type="text" name="sendtoname" message="Error! Provide Recipients Name" required="yes" class="textfield_effect" id="sendtoname" size="50"></td>
    </tr>
    <tr>
      <td width="200" nowrap ><div align="right"><span class="important">*</span>Senders
      name:</div></td>
      <td width="0"><cfinput type="text" name="sentfromname" message="Error! Provide Your Name" required="yes" class="textfield_effect" id="sentfromname" size="50"></td>
    </tr>
    <tr>
      <td width="200" nowrap ><div align="right"><span class="important">*</span>Senders
      email address:</div></td>
      <td width="0"><cfinput type="text" name="sentfromemail" message="Error! Provide Valid Email address" validate="email" required="yes" class="textfield_effect" id="sentfromemail" size="50">
      </td>
    </tr>
    <tr>
      <td width="200" nowrap ><div align="right"><span class="important">*</span>Email
      subject:</div></td>
      <td width="0">
		<input name="messagesubject" type="text" class="textfield_effect" id="messagesubject" value="Check out this <cfoutput>#showConfig.General_AppItem#</cfoutput>" size="50">
      </td>
    </tr>
    <tr>
      <td width="200" valign="top" nowrap ><div align="right"><span class="important">*</span>Email
      message:</div></td>
      <td width="0"><textarea name="messagebody" cols="37" rows="6" class="textfield_area" id="messagebody">Your friend has sent you this email and thought you would should check out this <cfoutput>#showConfig.General_AppItem#</cfoutput>.</textarea>
      </td>
  </tr>
    <tr>
      <td width="200" height="34" ><div align="right"><span class="important">(*required)</span></div></td>
      <td width="0"><input name="SendToFriendManager" type="submit" class="submit" value="Send">&nbsp;&nbsp;
      <cfoutput><input type="hidden" name="url" value="#trim(a)#"></cfoutput>
	  </td>
    </tr>
    
</table>
</cfform>
