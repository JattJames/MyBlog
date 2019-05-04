<cfinvoke component="blogcfc.blog" method="myfunction" all="show" returnvariable="metaTags"/>
<cfoutput query="metaTags">
	<cfif metaTags.General_MetaTitle IS "">
    <title>Welcome to Blog!</title>
    <cfelse>
    <title>#General_MetaTitle#</title>
    </cfif>
    <meta name="description" content="#General_MetaDescription#">
	<meta name="keywords" content="#General_MetaKeywords#">
</cfoutput>