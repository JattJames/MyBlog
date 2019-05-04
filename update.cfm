<cfif session.blog eq 'logged'>
<cfset UpdateItem = "%">
<cfif url.itemID IS NOt "">
  <cfset UpdateItem = "#url.itemID#">
</cfif>

<cfif isdefined('form.save_UpdatePost')>
	<cfif len(form.itemName) IS 0>
    	<cfset msg = "Error! Provide Title name before adding">
    <cfelse>
    	<cfinvoke component="blogcfc.blog" method="updateoldpost" argumentcollection="#form#"/>
        <cfset msg = "Cool! Post Updated Successfully">
    </cfif>    
</cfif>

<cfinvoke component="blogcfc.blog" method="getItem" UpdateItem = "#trim(UpdateItem)#" returnvariable="showItems"/>
<cfinvoke component="blogcfc.blog" method="listAllcategories" returnvariable="allcats"/>
<cfinclude template="blog.cfm">
<cfform ACTION="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" METHOD="POST" name="update" id="update">
  <h1> <cfoutput> <a href="index.cfm?ItemID=#showItems.ItemID#&CategoryID=#showItems.CategoryID#"><strong>#showItems.ItemName#</strong></a></cfoutput> </h1>
  <table width="100%"  border="0" cellspacing="2" cellpadding="1">
  <cfif isdefined('msg')>
    <tr>
      <td height="76" colspan="3">
          <h3 align="center"><cfoutput>#trim(msg)#</cfoutput></h3>
</td>
    </tr>
    </cfif>
    <tr>
      <td width="0" nowrap><strong>Title:</strong></td>
      <td><cfinput name="ItemName" type="text" id="ItemName" value="#showItems.ItemName#" size="65" required="yes" message="Error! Provide Title Please">
        <cfoutput>
          <input type="hidden" name="MM_recordId" value="#ShowItems.ItemID#">
        </cfoutput></td>
    </tr>
    <tr>
      <td width="0" nowrap><strong>Section:</strong></td>
      <td><select name="CategoryID" id="CategoryID">
          <cfoutput query="allcats">
            <option value="#categoryID#" <cfif #url.categoryID# eq #categoryID#>selected="selected"</cfif>>#ParentCategoryValue# - #CategoryValue#</option>
          </cfoutput>
        </select>
        &nbsp; <a href="javascript:void(0);" onClick="WinOpen('admin.cfm','600','400');">[Add/Edit Categories]</a></td>
    </tr>
    <tr>
      <td width="0" nowrap><strong>Date Added</strong>:</td>
      <td><cfoutput>#DateFormat(showItems.DateAdded, 'dddd, mmm dd, yyyy')#</cfoutput></td>
    </tr>
    <tr>
      <td width="0" nowrap><strong>Last Edit Date</strong>:</td>
      <td><cfif showItems.LastEditDate IS "">
          <em>First Time Editing</em>
          <cfelse>
          <cfoutput>#DateFormat(showItems.LastEditDate, 'dddd, mmm dd, yyyy')#</cfoutput>
        </cfif></td>
    </tr>
    <tr>
      <td width="0" nowrap><strong>Published Status</strong>:</td>
      <td><input type="radio" name="Activated" value="True" <cfif #showItems.Activated# EQ true>checked="checked"<cfelse></cfif>>
        Public
        <input <cfif #showItems.Activated# EQ false>checked="checked"<cfelse></cfif> type="radio" name="Activated" value="False">
        Private</td>
    </tr>
    <tr>
      <td nowrap>&nbsp;</td>
      <td nowrap><textarea id="txtContent" name="txtContent" rows=4 cols=30><cfoutput>#ShowItems.ItemMemo#</cfoutput></textarea></td>
    </tr>
    <tr>
      <td nowrap>&nbsp;</td>
      <td nowrap><input name="save_UpdatePost" type="submit" class="submit" value="Update Post" ></td>
    </tr>
  </table>
</cfform>
<cfelse>
<h1>Invalid Page</h1>
</cfif>