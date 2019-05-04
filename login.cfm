<link href="blogcss.css" rel="stylesheet" type="text/css" />
<cfif IsDefined('form.submitlogin')>
	<cfif len(form.username) IS 0>
    	<cfset msg = "Error! Please provide Username">
    <cfelseif len(form.pwd) IS 0>
    	<cfset msg = "Error! Provide Password Please">
    <cfelse>
    	<cfinvoke component="blogcfc.blog" method="checklogin" argumentcollection="#form#" returnvariable="showlogin"/>
        <cfif showlogin.recordcount>
        	<cfset session.blog = 'logged'>
            <cfset session.loggedIn = True>
            <cfset session.isRole = #showlogin.role#>
            <cfset session.uname = #showlogin.username#>
            <cfset session.mm_userauthorization = #showlogin.email#>
        <cflocation addtoken="no" url="index.cfm">
        <cfelse>
        <cfset msg = "Error! Invalid Login Information">    
        </cfif>
</cfif>
</cfif>
<div id="subcontent">
<cfform method="post" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
<table width="100%" border="0" cellspacing="2" cellpadding="1">
<tr>
      <td height="30" colspan="2"><h3>Enter Into Blog</h3></td>
    </tr>
  <cfif isdefined('msg')>
      <tr>
        <td height="38" colspan="2"><h3 align="center"><cfoutput>#trim(msg)#</cfoutput></h3></td>
      </tr>
    </cfif>
  <tr>
    <td width="25%"><div align="right"><span class="important">*</span>Username: </div></td>
    <td width="75%"><cfinput name="username" type="text" tabindex="1" class="textfield_effect" id="username" required="yes" message="Error! Provide username" /></td>
  </tr>
  <tr>
    <td><div align="right"><span class="important">*</span>Password: </div></td>
    <td><cfinput name="pwd" type="password" class="textfield_effect" id="pwd" tabindex="2" required="yes" message="Error! Provide Password" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input name="submitlogin" type="submit" class="submit" id="submitlogin" tabindex="3" value="Login" /></td>
  </tr>
</table>
</cfform>
</div>