<cfinvoke component="blogcfc.blog" method="myFunction" returnvariable="showheader"/>
<h1>
<cfif showheader.General_AppLogo IS "">
<cfoutput>#showheader.General_AppName#</cfoutput>
<cfelse>
<cfset imgFile = createObject("java","javax.swing.ImageIcon").init(expandPath('#showheader.General_AppLogo#'))>
<cfset imgFile.getImage()>
<cfset imgWidth = imgFile.getIconWidth()>
<cfset imgHeight = imgFile.getIconHeight()>
<cfif imgWidth eq 100 and imgHeight eq 30>
<cfoutput><img src="#showheader.General_AppLogo#" border="0"></cfoutput>
<cfelse>
<cfoutput><img src="#showheader.General_AppLogo#" border="0" width="100" height="30"></cfoutput>
</cfif>
<cfoutput>#showheader.General_AppName#</cfoutput>
</cfif>
</h1>