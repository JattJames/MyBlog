<cfif session.blog eq 'logged'>
<cfinvoke component="blogcfc.blog" method="listAllcategories" returnvariable="lists"/>
<cfinvoke component="blogcfc.blog" method="myFunction" all="show" returnvariable="adminvars">
<cfparam name="title" default="">
<cfparam name="CCategoryID" default="">
<cfparam name="txtContent" default="">
<cfinclude template="blog.cfm">
<cfif isdefined('form.save_newpost')>
	<cfif len(form.itemName) IS 0>
    	<cfset msg = "Error! Provide Title name before adding">
    <cfelse>
    	<cfinvoke component="blogcfc.blog" method="addnewpost" argumentcollection="#form#"/>
        <cfset msg = "Cool! New Post Created Successfully">
    </cfif>    
</cfif>

  <form ACTION="<cfoutput>#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#</cfoutput>" METHOD="POST">
    <table width="100%"  border="0" cellpadding="1" cellspacing="2">
      <cfif isdefined('msg')>
    <tr>
      <td height="76" colspan="3">
          <h3 align="center"><cfoutput>#trim(msg)#</cfoutput></h3>
</td>
    </tr>
    </cfif>
      <tr>
        <td width="23%" nowrap><strong>Title:</strong></td>
        <td colspan="2"><input name="ItemName" type="text" class="textfield_effect" id="ItemName" size="65" value="<cfoutput>#title#</cfoutput>"></td>
      </tr>
      <tr>
        <td width="23%" nowrap><strong>Section:</strong></td>
        <td colspan="2">
          <select name="CategoryID" class="textfield_effect" id="CategoryID" style="height:20px;">
          <cfoutput query="lists">
          	<option value="#CategoryID#" <cfif #CategoryID# eq #CCategoryID#>selected="selected"</cfif>>#ParentCategoryValue# - #CategoryValue#</option>
          </cfoutput>
          </select>&nbsp;
          <a href="javascript:void(0);" onClick="WinOpen('admin.cfm','600','400');">[Add/Edit Categories]</a></td>
      </tr>
      
      <tr>
        <td nowrap><strong>Date Added:</strong></td>
        <td width="20%" nowrap><cfoutput>#DateFormat(Now(), 'dddd, mmm dd, yyyy')#</cfoutput>
        </td>
        <td width="57%" nowrap>&nbsp;</td>
      </tr>
      <tr>
        <td nowrap><strong>Published Status:</strong></td>
        <td colspan="2" nowrap><input name="Activated" type="radio" value="True" checked>
          Public
          <input type="radio" name="Activated" value="False">
          Private </td>
      </tr>
      <tr>
        <td nowrap>
        <cfoutput>
          <input name="SortOrder" type="hidden" id="SortOrder" value="0">
          <input name="EmailAddress" type="hidden" id="EmailAddress" value="#adminvars.General_OwnerEmailAddress#">
          <input name="FirstName" type="hidden" id="FirstName" value="#adminvars.General_OwnerFirstName#">
          <input name="LastName" type="hidden" id="LastName" value="#adminvars.General_OwnerLastName#">
          </cfoutput>
          </td>
        <td colspan="2" nowrap><textarea name="txtContent" cols=30 rows=4 class="textfield_area" id="txtContent"><cfoutput>#txtContent#</cfoutput></textarea></td>
      </tr>
      <tr>
        <td nowrap>&nbsp;</td>
        <td colspan="2">
            <input name="save_newpost" type="submit" class="submit" value="Insert New Post">
        </td>
      </tr>
    </table>
  </form>
  <br><br>
  <div align="left"><a href="javascript:history.back(-1);">Go back</a></div>
  <cfelse>
  <h1>Invalid page</h1>
</cfif>
