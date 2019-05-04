<cfsetting enableCFoutputOnly="yes">
<cfsilent>
<cfapplication name="#Hash(GetCurrentTemplatePath())#" setclientcookies="yes" loginstorage="session" sessionmanagement="yes" clientmanagement="yes" applicationtimeout="#CreateTimeSpan(0,2,0,0)#" sessiontimeout="#CreateTimeSpan(0,0,40,0)#" scriptprotect="all">
<cfif IsDefined("Session.CFID") AND IsDefined("Session.CFTOKEN")>
  <cfset localCFID = Session.CFID>
  <cfset localCFToken = Session.CFTOKEN>
  <cfelseif IsDefined("Cookie.CFID") AND IsDefined("Cookie.CFTOKEN")>
  <cfset localCFID = Cookie.CFID>
  <cfset localCFToken = Cookie.CFTOKEN>
</cfif>
<cfif IsDefined("localCFID") AND IsDefined("localCFToken")>
  <cfcookie name="CFID" value="#localCFID#">
  <cfcookie name="CFTOKEN" value="#localCFToken#">
</cfif>
<cfset request.dsn = "myblog">
<cfset request.user = "root">
<cfset request.pass = "">
<!--- Define Mail Settings --->
<cfset w = "My Name <name@domain.com>">
<cfset MailUser = "name@domain.com">
<cfset MailPass = "password">
<cfset MPort = "26">
<cfset MServer = "mail.domain.com">
<cfset Mfailto = "errors@domain.com">
<cfset emailOwner = "name@domain.com">
<cfif (Not IsDefined("request.siteURL")) OR IsDefined("URL.flush")>
  <cflock scope="request" timeout="#CreateTimeSpan(0,0,20,0)#">
    <cfset request.SiteURL = replace(GetDirectoryFromPath("http://"&cgi.server_name&cgi.path_info),"\","")>
    <cfset request.file_path = GetDirectoryFromPath(GetCurrentTemplatePath())>
  </cflock>
</cfif>
<!--- Manging the Body Format --->
<cffunction name="screenformat" output="false" returntype="string">
  <cfargument name="s" type="string">
  <cfreturn replace(arguments.s,chr(13),"<br/>","all")>
</cffunction>
<!--- Application Addresses --->
<cfset setLocale("English (US)")>
<!--- Set the session page encoding --->
<cfset setencoding("URL", "utf-8")>
<cfset setencoding("Form", "utf-8")>
<cfcontent type="text/html; charset=utf-8">
<!--- Define Session values --->
<cfparam name="session.loggedIn" default="False">
<cfparam name="session.blog" default="">
<cfparam name="session.isRole" default="0">
<cfparam name="session.uname" default="">
<cfset year1 = DateFormat(now(),'yyyy')>
<cfset nextyear = #year1#+1>
</cfsilent>
<cfsetting enableCFoutputOnly="no">
