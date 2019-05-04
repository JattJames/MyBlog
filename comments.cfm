<cfif session.blog eq 'logged'>
<cfif isDefined('url.delete')>
	<cfinvoke component="blogcfc.blog" method="deleteBlogComment" blogID="#trim(url.delete)#"/>
    <cflocation addtoken="no" url="index.cfm?show=comments&msg=1">
</cfif>
  <cfinvoke component="blogcfc.blog" method="getAllComments" returnvariable="showAll"/>
  <table width="100%" border="0" cellspacing="2" cellpadding="1">
    <tr>
      <td colspan="3"><h2>Manage Comments</h2></td>
    </tr>
    <cfif isdefined('msg')><tr><td colspan="4" align="center"><h3 align="center"><cfif msg is 1>Cool! Comment Deleted</cfif></h3></td></tr></cfif>
    <tr align="left">
      <th width="86%">Comments</th>
      <th width="7%">Status</th>
      <th width="7%" align="center">Action</th>
    </tr>
    <cfif showall.recordcount>
      <cfoutput query="showAll">
        <tr align="left">
          <td><strong>#currentRow# - #itemName#</strong><br>
            <em>#DateFormat(DateAdded,'dddd, mmm dd, yyyy')#</em><br>
            #ItemExtraDetailMemo#</td>
          <td><cfif #Activated# eq True>
              Public
              <cfelse>
              Private
            </cfif></td>
          <td><ul>
              <li><a href="index.cfm?show=comments&edit=#ItemExtraDetailID#">Edit</a></li>
              <cfif ismod><cfelse><li><a href="index.cfm?show=comments&delete=#ItemExtraDetailID#" onclick="return confirm('Are you Sure to delete');">Delete</a></li></cfif>
              </li>
            </ul></td>
        </tr>
      </cfoutput>
      <cfelse>
      <tr><td colspan="2" align="center">&nbsp;</td></tr>
      <tr><td colspan="2" align="center">No Comment Found Yet!</td></tr>
      <tr><td colspan="2" align="center">&nbsp;</td></tr>
      
    </cfif>
  </table>

  <cfif IsDefined('url.edit')>
  <cfinvoke component="blogcfc.blog" method="getAllComments" iID="#trim(url.edit)#" returnvariable="getDetails"/>
  <cfif isdefined('form.editcomment')>
  	<cfif len(form.mode) is 0>
    	<cfset msg = "Error! Please provide comments">
    <cfelse>
    	<cfinvoke component="blogcfc.blog" method="updatecomment" argumentcollection="#form#"/>
        <cfset msg = "Cool! Comment Updated Successfully">
    </cfif> 
    <cfif isDefined('form.notify') AND form.notify IS 1>
    <cfmail to="getDetails.PostedBy <#getDetails.SendToEmailAddress#>" from="#w#" bcc="#w#" 
    username="#MailUser#" password="#Mailpass#" port="#MPort#" type="html" subject="#form.messagesubject#" server="#MServer#" 
    failto="#Mfailto#" query="getDetails">
	   Admin Has Edited Your Comment.<br />
        <br />
        Your Comment has been modified as :<br />
        <br />
        #scrrenformat(form.mode)#<br />
        <hr />
        <br />
        Regards,<br />
        <br />
        <strong>#Request.siteURL#</strong><br />
      </cfmail>
    </cfif>   
    <cflocation addtoken="no" url="index.cfm?show=comments&edit=#form.cID#&msg=#msg#">
  </cfif>
    <div id="subcontent">
    <cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
      <cfoutput query="getDetails">
        <table width="100%" border="0" cellpadding="0" cellspacing="3">
          <cfif isdefined('msg')>
            <tr>
              <td height="76" colspan="2"><h3 align="center"><cfoutput>#trim(msg)#</cfoutput></h3></td>
            </tr>
          </cfif>
          <tr>
            <td height="27" colspan="2"><h3>Edit Comment </h3></td>
          </tr>
          <tr>
            <td height="27" colspan="2">Use the form below to edit Comment.</td>
          </tr>
          <tr>
            <td width="30%">ItemName:</td>
            <td width="70%">#itemName#</td>
          </tr>
          <tr>
            <td valign="top">Details:</td>
            <td><textarea class="textfield_area" name="mode">#ItemExtraDetailMemo#</textarea></td>
          </tr>
          <cfif LastEditDate NEQ "">
          <tr>
          	<td>Last Edit date:</td>
            <td><cfoutput>#DateFormat(LastEditDate,'dddd, mmm dd, yyyy')#</cfoutput></td>
          </cfif>
          <tr>
            <td valign="top">Notify Comment User:</td>
            <td><input type="radio" name="notify" value="1" checked="checked" />Notify User
            <input type="radio" name="notify" value="0" />Do Not Notify</td>
          </tr>
          <tr>
            <td valign="top"><input type="hidden" name="cID" value="#ItemExtraDetailID#" /></td>
            <td><input type="submit" name="editcomment" value="Edit Comment" class="submit" /></td>
          </tr>
        </table>
      </cfoutput>
    </cfform></div>
  </cfif>

  <cfelse>
  <h1>Invalid Page</h1>
</cfif>
