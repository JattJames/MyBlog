<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<link rel="stylesheet" href="blogcss.css" media="all" />
<script language="javascript1.2" src="jsfile.js"></script>
<cfif isdefined('url.action') AND url.action eq 'delete'>
	<cfinvoke component="blogcfc.blog" method="deletePost" itemID="#Trim(url.itemID)#"/>
	<cflocation addtoken="no" url="index.cfm">   
</cfif>
<cfinclude template="isLog.cfm">
<cfinclude template="meta.cfm">
</head>
<body>
<div id="page_container">
<div id="headers">
	<ul id="menu">
		<li><a href="index.cfm" accesskey="1" title=""> Home</a></li>
		<cfif isLog><li><a href="logout.cfm" accesskey="2" title=""> Logout</a></li>
        <cfelse>
        <li><a href="index.cfm?show=login" accesskey="2" title=""> Login</a></li>
        </cfif>
	</ul>
</div>
<div id="header">
  <cfinclude template="header.cfm">
</div>
<div align="center" class="navigation_global">
  <cfinclude template="inc_header.cfm">
</div>
<div id="content_container">
<div id="content">
<cfif isdefined('url.show') and url.show EQ 'welcome'>
  <cfinclude template="top.cfm">
</cfif>
<cfif not isDefined("show")>
  <cfinclude template="list_details.cfm">
  <cfelseif isdefined('url.show') and url.show eq 'insert'>
  <cfinclude template="insert.cfm">
<cfelseif isdefined('url.show') and url.show eq 'update'>  
  <cfinclude template="update.cfm">
<cfelseif isdefined('url.show') and url.show eq 'settings'>  
  <cfinclude template="settings.cfm">  
<cfelseif isdefined('url.show') and url.show eq 'comments'>  
  <cfinclude template="comments.cfm">
<cfelseif isdefined('url.show') and url.show eq 'login'>  
  <cfinclude template="login.cfm">      
</cfif>  
</div>
<div id="search_container">
  <div id="searchbar">
    <cfinclude template="searchkeys.cfm">
  </div>
  <div id="searchbar">
    <cfinclude template="searchbydate.cfm">
  </div>
  <div id="searchbar">
    <cfinclude template="searchcategory.cfm">
  </div>
</div>
<cfif isdefined('url.action')>
<cfif url.action eq 'view'>
  <div id="subcontent">
    <cfinclude template="extra_detail.cfm">
  </div>
  <cfelseif url.action eq 'post'>
  <div id="subcontent">
    <cfinclude template="inc_post.cfm">
  </div>
  <cfelseif url.action eq 'refer'>
  <div id="subcontent">
    <cfinclude template="sendfriend.cfm">
  </div>
  <cfelseif url.action eq 'email'>
  <div id="subcontent">
    <cfinclude template="send_reply.cfm">
  </div>
</cfif>
</cfif>
<div id="footer" align="center">
  <cfinclude template="footer.cfm">
</div>
</div>
</div>
</body>
</html>
