<cfset isAdmin = IsDefined('session.blog') AND session.blog EQ 'logged' AND session.isRole EQ 1>
<cfset isMod = IsDefined('session.blog') AND session.blog EQ 'logged' AND session.isRole EQ 2>
<cfset isLog = IsDefined('session.blog') AND session.blog EQ 'logged'>