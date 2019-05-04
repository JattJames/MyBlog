<cfif session.blog eq 'logged'>
<link href="blogcss.css" rel="stylesheet" type="text/css">
<cfinclude template="blog.cfm">
<cfinvoke component="blogcfc.blog" method="myFunction" all="show" returnvariable="rsSettings"/>

<cfif isdefined('form.saveBlogSettings')>
	<cfif len(form.General_OwnerFirstName) IS 0>
    <cfset msg = "Error! provide First Name Please">
    <cfelseif len(form.General_OwnerLastName) IS 0>
    <cfset msg = "Error! provide Last Name Please">
    <cfelseif len(form.General_AppName) IS 0>
    <cfset msg = "Error! Provide Blog Application Name Please">
    <cfelse>
	<cfinvoke component="blogcfc.blog" method="updatesettings" argumentcollection="#form#"/>
    <cflocation addtoken="no" url="index.cfm?show=settings&msg=Cool! Settings Updated Successfully">
    </cfif>
</cfif>
<cfform ACTION="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" METHOD="POST" name="settings">
  <table border="0" align="center" cellpadding="1" cellspacing="2">
    <tr valign="top">
      <td colspan="2" align="center" valign="middle"><cfif isdefined('msg')><cfoutput>#trim(msg)#</cfoutput></cfif></td>
    </tr>
    <tr valign="top">
      <td colspan="2" valign="middle"><div align="left">
          <h1>Meta Settings</h1>
        </div></td>
    </tr>
    <tr valign="top">
      <td><strong>Blogger's Meta Title:<br />
        </strong><span class="small">Please Enter The Title of the Blog: </span></td>
      <td><div align="right">
        <cfinput name="General_MetaTitle" type="text" class="textfield_effect" value="#rsSettings.General_MetaTitle#" size="30">
      </div></td>
    </tr>
    <tr valign="top">
      <td><strong>Blogger's Meta Description:<br />
        </strong><span class="small">Provide Blog Details for SEO: </span></td>
      <td><div align="right">
        <textarea name="General_MetaDescription" class="textfield_area"><cfoutput>#rsSettings.General_MetaDescription#</cfoutput></textarea></div></td>
    </tr>
    <tr valign="top">
      <td><strong>Blogger's Meta Keywords:<br />
      </strong><span class="small">Provide Keywords Which Finds Your Blog: </span></td>
      <td><div align="right">
        <textarea name="General_MetaKeywords" class="textfield_area"><cfoutput>#rsSettings.General_MetaKeywords#</cfoutput></textarea>
      </div></td>
    </tr>
    
    <tr valign="top">
      <td colspan="2" valign="middle"><div align="left">
          <h1>Define User Settings </h1>
        </div></td>
    </tr>
    <tr valign="top">
      <td><strong>Blogger's First Name:<br>
        </strong><span class="small">The First name of the blogger (as you would like it to appear 
        in your blog): </span></td>
      <td width="0"><div align="right">
          <cfinput name="General_OwnerFirstName" type="text" class="textfield_effect" value="#rsSettings.General_OwnerFirstName#" 
      size="30">
        </div></td>
    </tr>
    <tr valign="top">
      <td><strong>Blogger's Last Name:<br>
        </strong><span class="small">The Last name of the blogger (as you would like it to appear 
        in your blog): </span></td>
      <td><div align="right">
          <cfinput name="General_OwnerLastName" type="text" class="textfield_effect" value="#rsSettings.General_OwnerLastName#" size="30" >
        </div></td>
    </tr>
    
    <tr valign="top">
      <td><strong>Blogger's Email Address:<br>
        </strong><span class="small">The Email Address of the blogger: </span></td>
      <td><div align="right">
          <cfinput name="General_OwnerEmailAddress" type="text" class="textfield_effect" value="#rsSettings.General_OwnerEmailAddress#" size="30" >
        </div></td>
    </tr>
    
    <tr valign="top">
      <td colspan="2"><hr></td>
    </tr>
    <tr valign="top">
      <td colspan="2"><h1>Define Web Blog Settings </h1></td>
    </tr>
    <tr valign="top">
      <td><strong>Web Blog Title: </strong><br>
        <span class="small">The Title will be displayed in the header of all pages. If your title 
        is in your Header Image/Logo, leave blank. </span><br></td>
      <td width="0"><div align="right">
          <cfinput name="General_AppName" type="text" class="textfield_effect" value="#rsSettings.General_AppName#" size="30" >
        </div></td>
    </tr>
    <tr valign="top" class="body">
      <td><strong>Blog Posting Categories:</strong><br>
        <span class="small">Organize your blog topics into separate categories (optional). Click button 
        to set up categories at any time. </span></td>
      <td width="0"><div align="right"> <a href="javascript:void(0);" onClick="WinOpen('admin.cfm','600','400');">[Click to Add/Edit Categories]</a> </div></td>
    </tr>
    <tr valign="top">
      <td><p><strong>Footer: </strong> <cfoutput>
            <input name="General_AppItemID" type="hidden" value="#rsSettings.General_AppItemID#">
          </cfoutput> <span class="small"><br>
          Add your own company info to the footer of every blog page.</span></p></td>
      <td><div align="right">
          <textarea name="General_AppFooter" cols="23" rows="5" class="textfield_area"><cfoutput>#rsSettings.General_AppFooter#</cfoutput></textarea>
        </div></td>
    </tr>
    <tr valign="top">
      <td><strong>Header Image/Logo: </strong><br>
        <span class="small">Click &quot;Add Image&quot; link (right) to upload
        image OR enter URL to external Image e.g. http://www.yourdomain.com/images/image.gif </span></td>
      <td width="0"><div align="right">
          <cfinput name="General_AppLogo" type="text" class="textfield_effect" value="#rsSettings.General_AppLogo#" size="30" >
          <br>
          <p align="right"><a href="javascript:void(0);" onClick="WinOpen('images.cfm','600','600');">[Click to Add Image]</a> </p>
        </div></td>
    </tr>
    <tr valign="top">
      <td><strong>Allow User Comments : </strong><br>
        <span class="small">Use this setting to allow users to post comments about individual blog 
        entries.</span></td>
      <td><div align="right">
          <input name="Display_ShowButton_PostComment" type="radio" value="True" <cfif #rsSettings.Display_ShowButton_PostComment# eq True> CHECKED="checked"<cfelse></cfif>> Yes
          <input type="radio" name="Display_ShowButton_PostComment" value="False" <cfif #rsSettings.Display_ShowButton_PostComment# eq False> CHECKED="checked"<cfelse></cfif>> No </div></td>
    </tr>
    <tr valign="top">
      <td><strong>Comment Viewing : </strong><br>
        <span class="small">Use this setting to control whether your readers can view posted comments.</span></td>
      <td><div align="right">
          <input name="Display_ShowButton_ViewComment" type="radio" value="True"<cfif #rsSettings.Display_ShowButton_ViewComment# eq True> CHECKED="checked"<cfelse></cfif>>
          Public
          <input type="radio" name="Display_ShowButton_ViewComment" value="False"<cfif #rsSettings.Display_ShowButton_ViewComment# eq False> CHECKED="checked"<cfelse></cfif>>
          Private</div></td>
    </tr>
    <tr valign="top">
      <td><strong>Comment Approval : </strong><br>
      <span class="small">Use this setting to control whether you need to approve comments before published.</span></td>
      <td><div align="right">
        <input <cfif #rsSettings.Extra_ConfigText1# eq True> CHECKED="checked"<cfelse></cfif> name="Extra_ConfigText1" value="True" type="radio">On
      <input <cfif #rsSettings.Extra_ConfigText1# eq false> CHECKED="checked"<cfelse></cfif> name="Extra_ConfigText1" value="False" type="radio">
Off</div></td>
    </tr>
    <tr valign="top">
      <td><strong>Comment Management : </strong><br>
      <span class="small">Manage all comments you receive in this blog</span></td>
      <td align="right"><a href="index.cfm?show=comments">[Manage Comments]</a></td>
    </tr>
    <tr valign="top">
      <td colspan="2"><strong>Bio Page:</strong><br>
        <span class="small">Use this WYSIWYG editor to create a Information, your pic, etc. </span><br>
      <textarea name="txtContent" cols=30 rows=4 class="textfield_area" id="txtContent"><cfoutput>#rsSettings.General_AppWelcomePage#</cfoutput></textarea></td>
    </tr>
    <tr valign="top">
      <td colspan="2" valign="top"><div align="right">
          <input name="saveBlogSettings" type="submit" class="submit" value="Save Changes">
        </div></td>
    </tr>
  </table>
  <br>
  <cfoutput><input type="hidden" name="MM_recordId" value="#rsSettings.ConfigID#"></cfoutput>
</cfform>
<cfelse>
<h1>Invalid Page</h1>
</cfif>