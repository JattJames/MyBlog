<cfparam name="sentfromname" default="">
<cfparam name="sentfromemail" default="">
<cfparam name="messagebody" default="">
<cfsavecontent variable="a">
<cfoutput>#cgi.SERVER_NAME##cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#</cfoutput>
</cfsavecontent>
<cfset rsValue = "999999">
<cfif isdefined('itemID') and itemID neq "">
  <cfset rsValue = #itemID#>
</cfif>
<cfinvoke component="blogcfc.blog" method="getTablesConfis" Solidvalue="#trim(rsValue)#" returnvariable="sConfig"/>
<cfif isdefined('form.SendReplyManager')>
  <cfif len(form.sentfromname) IS 0>
    <cfset msg = "Error! Sender's Name is required">
    <cfelseif NOT REFindnocase("^[-_!a-z0-9\.]+@([-_a-z0-9]+\.)+[a-z]{2,6}$", sentfromemail)>
    <cfset msg = "Error! Sender's email address is invalid">
    <cfelseif len(form.messagebody) LTE 10>
    <cfset msg = "Error! Message must be more than 10 characters">
    <cfelse>
    <cfif len(form.messagesubject) IS "">
      <cfset form.messagesubject = "A Private Message recieved">
      <cfelse>
      <cfset form.messagesubject = "#form.messagesubject#">
    </cfif>
    <cfmail to="#form.sendtoemail#" from="#w#" bcc="#w#" username="#MailUser#" password="#Mailpass#" port="#MPort#" 
    type="html" subject="#form.messagesubject#" server="#MServer#" failto="#Mfailto#">
      User #form.sentfromname# has send you a Private Message: <br />
      <br />
      Here is the Message:<br />
      <br />
      #form.messagesubject# <br>
      #form.messagebody#<br />
      <hr />
      <br />
      Regards,<br />
      <br />
      <strong>#Request.siteURL#</strong><br />
    </cfmail>
    <cfset msg = "Cool! Email Send Successfully">
  </cfif>
</cfif>
<cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="3" >
    <tr>
      <td height="30" colspan="2"><h3>Send Private Email Message</h3></td>
    </tr>
    <cfif isdefined('msg')>
      <tr>
        <td height="38" colspan="2"><h3 align="center"><cfoutput>#trim(msg)#</cfoutput></h3></td>
      </tr>
    </cfif>
    <tr>
      <td height="19" colspan="2" nowrap >Use the form below to send a private email to <strong><cfoutput>#sConfig.firstname# #sConfig.lastname#</cfoutput></strong></td>
    </tr>
    <tr>
      <td width="200" height="22" nowrap ><div align="right"><span class="important">*</span>Your
          full name: </div></td>
      <td width="0" height="22"><cfinput type="text" name="sentfromname" message="Error! Provide Your Name" required="yes" class="textfield_effect" id="sentfromname" value="#sentfromname#" size="50"></td>
    </tr>
    <tr>
      <td width="200" height="22" nowrap ><div align="right"><span class="important">*</span>Your
          email address:</div></td>
      <td width="0" height="22"><cfinput type="text" name="sentfromemail" message="Error! Provide Your Valid Email Address" validate="email" required="yes" class="textfield_effect" id="sentfromemail" value="#sentfromemail#" size="50"></td>
    </tr>
    <tr>
      <td width="200" height="22" nowrap ><div align="right"><span class="important">*</span>Email
          subject:</div></td>
      <td width="0" height="22"><input name="messagesubject" type="text" class="textfield_effect" id="messagesubject" value="RE: <cfoutput>#showConfig.General_AppItem#: #sConfig.ItemName# - ID## #sConfig.ItemID#</cfoutput>" style="width:300px;"></td>
    </tr>
    <tr>
      <td width="200" height="30" valign="top" nowrap ><div align="right"><span class="important">*</span>Email
          message:</div></td>
      <td width="0" height="30"><textarea name="messagebody" cols="37" rows="6" class="textfield_area" id="messagebody"><cfoutput>#messagebody#</cfoutput></textarea></td>
    </tr>
    <tr>
      <td width="200" height="30" ><div align="right"><span class="important">(*required) </span></div></td>
      <td width="0" height="30"><input name="SendReplyManager" type="submit" class="submit" value="Send Private Message">
        <cfoutput>
          <input type="hidden" name="sendtoname" value="#showConfig.General_OwnerFirstName#">
          <input name="sendtoemail" type="hidden" id="sendtoemail" value="#sConfig.EmailAddress#" size="50">
          <input type="hidden" name="url" value="#a#">
        </cfoutput></td>
    </tr>
    
  </table>
</cfform>
