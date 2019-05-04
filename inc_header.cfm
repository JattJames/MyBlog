<table width="100%" align="center" cellpadding="1" cellspacing="2">
<tr><td width="33%"><a href="index.cfm?show=welcome">Bio</a></td>

<cfif IsDefined('session.blog') AND session.blog IS 'logged'>
<td width="34%"><a href="index.cfm?show=insert">New Post</a></td>
<td width="33%"><a href="index.cfm?show=settings">Settings</a></td>
<cfelse>
</cfif></td></tr></table>
