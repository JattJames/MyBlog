<cfparam name="CategoryID" default="">
<cfparam name="ItemID" default="">
<cfset urlvalue = "?categoryID=#categoryID#&itemID=#itemID#">
<cfinvoke component="blogcfc.blog" method="myFunction" all="show" returnvariable="showConfig"/>
<cfset valueShow = "999999">
<cfif isdefined('itemID') and itemID neq "">
	<cfset valueShow = #itemID#>
</cfif>  
<cfinvoke component="blogcfc.blog" method="getConfigValue" valueCount="#trim(valueshow)#" returnvariable="showMe"/>
<script language="JavaScript" type="text/javascript">
  function confirmDelete(anchor)
  {
    if (confirm('Are you sure?'))
    {
      anchor.href += '&confirm=1';
      return true;
    }
    return false;
  }
</script>
<cfoutput>
<div id="menu_actions_user">
<a href="#CGI.SCRIPT_NAME##urlvalue#&action=refer">Send to friend</a> | <a href="#CGI.SCRIPT_NAME##urlvalue#&action=email">Send Private Message</a> | <a href="Javascript:self.print()">Print post</a>
<cfif showConfig.Display_ShowButton_PostComment EQ True> | <a href="#CGI.SCRIPT_NAME##urlvalue#&action=post">Post Comment</a></cfif><cfif isdefined('session.blog') and session.blog IS 'logged' AND showConfig.Display_ShowButton_PostComment EQ False> | <a href="#CGI.SCRIPT_NAME##urlvalue#&action=post">Post Comment</a></cfif>
<cfif showConfig.Display_ShowButton_ViewComment EQ True> | <a href="#CGI.SCRIPT_NAME##urlvalue#&action=view">View <cfoutput>#showme.CountOfComments#</cfoutput> Comments</a></cfif><cfif isdefined('session.blog') and session.blog IS 'logged' AND showConfig.Display_ShowButton_ViewComment EQ False> | <a href="#CGI.SCRIPT_NAME##urlvalue#&action=view">View <cfoutput>#showme.CountOfComments#</cfoutput> Comments</a>
</cfif>
</div>
<cfif isdefined('session.blog') and session.blog eq 'logged'>
<div id="menu_actions_admin">
<a href="index.cfm#urlvalue#&show=insert">New Post</a> | <a href="index.cfm#urlvalue#&show=update">Edit Post</a>
<cfif ismod><cfelse> | <a href="index.cfm#urlvalue#&action=delete" onClick="return confirmDelete(this)">Delete Post </a></cfif>
</ul>
</div>
</cfif>
</cfoutput>
