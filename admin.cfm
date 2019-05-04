<cfif session.blog eq 'logged'>
  <cfparam name="categoryName" default="">
  <cfif isdefined('form.submitNewCategory')>
    <cfif len(form.CategoryValue) IS 0>
      <cfset msg1 = "Error! Provide Category Name">
      <cfelse>
      <cfinvoke component="blogcfc.blog" method="addcategory" argumentcollection="#form#"/>
      <cfset msg1 = "Cool! New Category Addded">
    </cfif>
  </cfif>
  <cfif isDefined('form.submitSubCategory')>
    <cfif len(form.CategoryValue) IS 0>
      <cfset msg = "Error! Sub Category Name Missing">
      <cfelse>
      <cfinvoke component="blogcfc.blog" method="addcategory" argumentcollection="#form#"/>
      <cfset msg = "Cool! New Sub Category Addded">
    </cfif>
  </cfif>
  <cfinvoke component="blogcfc.blog" method="getAllCats" returnvariable="showallcategories"/>
  <cfinvoke component="blogcfc.blog" method="seewhatweget" returnvariable="showthis"/>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Add/Edit Categories</title>
  <link href="blogcss.css" rel="stylesheet" type="text/css" />
  <script language="JavaScript" type="text/JavaScript">
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
</script>
 </head>
  <body>
  <table width="100%" border="0" cellpadding="5" cellspacing="0" class="header_box">
  <tr>
    <td width="51%">Category Manager</td>
    <td width="49%"><div align="right">
<a href="javascript:self.close(0);">Close Window</a></div></td>
  </tr>
</table>

  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="header_box">
    <tr>
      <td class="subheader_box"><strong>STEP 1</strong> - <strong>Create Category </strong><br>
        Enter the name of the Category and press the &quot;Create&quot; button.</td>
    </tr>
  </table>
  <table width="100%"  border="0" cellpadding="3" cellspacing="0" class="subheader2_box">
  <cfif isdefined('msg1')>
      <tr>
        <td colspan="2" align="center"><cfoutput>#trim(msg1)#</cfoutput></td>
      </tr>
    </cfif>
    <tr>
      <td><cfform ACTION="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" METHOD="POST" name="ParentCategory" id="ParentCategory" >
          <strong>Enter Category Name:</strong>
          <cfinput type="text" name="CategoryValue" message="Error! Provide category Name Please" required="yes" class="textfield_effect" id="CategoryValue" value="#categoryName#" size="25" maxlength="255">
          <input name="submitNewCategory" type="submit" class="submit" value="Create" />
          <input type="hidden" name="ParentCategoryID" value="0">
        </cfform></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <cfoutput query="showallcategories">
      <tr>
        <td width="50%" height="28" align="left">&raquo; #CategoryValue#</td>
        <td width="20%"><div align="center"> <a href="admin.cfm?CategoryID=#showallcategories.CategoryID#">Edit Details </a> </div></td>
        <td width="15%"><div align="center">
            <cfif CategoryImageFile IS "">
              <a href="javascript:;" onClick="MM_openBrWindow('uploadimage.cfm?CategoryID=#showallcategories.CategoryID#&cat=#CategoryValue#','image','width=300,height=100')">Add Image</a>
              <cfelse>
              <img src="#request.siteURL#CategoryImages/#CategoryImageFile#" border="0" />
            </cfif>
          </div></td>
        <td width="15%"><div align="center"> <a href="index.cfm?CategoryID=#CategoryID#&action=delete" onClick="return confirmDelete(this)">Delete</a> </div></td>
      </tr>
    </cfoutput>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="header_box">
    <tr>
      <td class="subheader_box"><a name="step2"></a><strong>STEP
        2 - Create SubCategory</strong> <br>
        Select the Category, enter the
        name of the Sub Category and press the &quot;Create&quot; button. </td>
    </tr>
  </table>
  <table width="100%"  border="0" cellpadding="3" cellspacing="0" class="subheader2_box">
    <cfif isdefined('msg')>
      <tr>
        <td colspan="2" align="center"><cfoutput>#trim(msg)#</cfoutput></td>
      </tr>
    </cfif>
    <tr>
      <td><cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="POST" name="Category" id="Category">
          <strong>Enter Sub Category Name:</strong>
          <select name="ParentCategoryID" class="textfield_effect" id="ParentCategoryID" style="width:140px;height:18px;">
            <cfoutput query="showallcategories">
              <option value="#CategoryID#">#CategoryValue#</option>
            </cfoutput>
          </select>
          <cfinput name="CategoryValue" type="text" class="textfield_effect" id="CategoryValue" size="25" required="yes" message="Error! Provide Sub category Name" maxlength="255">
          <input name="submitSubCategory" type="submit" class="submit" id="submit" value="Create">
        </cfform></td>
    </tr>
  </table>
    <table width="100%" border="0" cellpadding="3" cellspacing="0">
     <cfoutput query="showthis">
       <tr>
        <th width="50%">
        <div align="left">
        <cfset TFM_nest = "#showthis.ParentCategoryValue#">
        <cfparam name="LastTFM_nest" default="">
        <cfif LastTFM_nest NEQ TFM_nest>
        	<cfset lastTFM_nest = TFM_nest>&nbsp;&nbsp;&##8250;&nbsp;&nbsp;<strong>#ParentCategoryValue# </strong>
        </cfif>    
         </div></th>
      </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="28" align="left" style="padding-left:50px;">&raquo;#CategoryValue#</td>
      <td width="20%"><div align="left"> <a href="admin.cfm?CategoryID=#CategoryID#">Edit Details </a> </div></td>
      <td width="15%"><cfif CategoryImageFile IS "">
          <a href="javascript:;" onClick="MM_openBrWindow('uploadimage.cfm?CategoryID=#showthis.CategoryID#&cat=#CategoryValue#','image','width=300,height=100')">Add Image</a>
          <cfelse>
          <img src="#request.siteURL#CategoryImages/#CategoryImageFile#" border="0" />
        </cfif></td>
      <td width="15%"><div align="center"> <a href="admin.cfm?CategoryID=#CategoryID#&action=delete" onClick="return confirmDelete(this)">Delete</a> </div></td>
    </tr>
  </cfoutput>
  </table>
  <table width="100%"  border="0" cellpadding="0" cellspacing="0" class="footer">
    <tr>
      <td>(* Create a New Subcategory of the New Created Category and It will appear below as links)</td>
    </tr>
  </table>
  </body>
  </html>
  <cfelse>
  <h1>Invalid page</h1>
</cfif>