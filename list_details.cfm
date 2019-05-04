<cfset Rules_DaysNew = 3>
<cfset value1 = "%">
<cfif isdefined('url.itemID') AND url.itemID NEQ "">
<cfset value1 = "#trim(url.itemID)#">
</cfif>

<cfset value3 = "%">
<cfif isdefined('url.CategoryID') AND url.CategoryID NEQ "">
<cfset value3 = "#trim(url.CategoryID)#">
</cfif>

<cfset value4 = "%">
<cfif isdefined('url.ParentCategoryID') AND url.ParentCategoryID NEQ "">
<cfset value4 = "#trim(url.ParentCategoryID)#">
</cfif>

<cfset value2 = "%">
<cfif isdefined('url.search') AND url.search NEQ "">
<cfset value2 = "#trim(url.search)#">
</cfif>

<cfset value5 = "%">
<cfif isdefined('url.date') AND url.date NEQ "">
<cfset value5 = "#trim(DateFormat(url.date,'yyyy-mm-dd'))#">
</cfif>

<cfset value6 = "%">
<cfif isdefined('session.blog') and session.blog EQ 'logged'>
<cfset value6 = "">
<cfelse>
<cfset value6 = "">
</cfif>

<cfinvoke component="blogcfc.blog" method="getItems" returnvariable="showLists">
	<cfinvokeargument name="value1" value="#value1#">
    <cfinvokeargument name="value2" value="#value2#">
    <cfinvokeargument name="value3" value="#value3#">
    <cfinvokeargument name="value4" value="#value4#">
    <cfinvokeargument name="value5" value="#value5#">
    <cfinvokeargument name="value6" value="#value6#">
</cfinvoke>    
<div align="right">
<p>
<cfset OnEachPage=10>
<!--- Set the default startrow to 1 if a value was not passed. --->
<!--- Determine whether or not to show the previous or next links. --->
<cfparam name="StartRow" default="1">
<!--- Set the value of endrow to the maxrows + startrow - 1 --->
<cfset EndRow=StartRow + OnEachPage - 1>
<!--- If the end row is greater than the recordcount, determine how many records are left. --->
<cfif EndRow GTE showLists.RecordCount>
  <cfset EndRow=showLists.RecordCount>
  <cfset Next=false>
  <!--- Othereise, set Next to true and determine the next set of records. --->
  <cfelse>
  <cfset Next=true>
  <cfif EndRow + OnEachPage GT showLists.RecordCount>
    <cfset NextNum=showLists.RecordCount - EndRow>
    <cfelse>
    <cfset NextNum= OnEachPage>
  </cfif>
  <cfset NextStart=EndRow + 1>
</cfif>
<!--- If StartRow is 1, set Previous to false. --->
<cfif StartRow IS 1>
  <cfset Previous=false>
  <!--- Othewise, determine the previous set of records. --->
  <cfelse>
  <cfset Previous=true>
  <cfset PreviousStart=StartRow - OnEachPage>
</cfif>
<!--- Determine how many pages will be displayed. --->
<cfset NumPages=Ceiling(showLists.RecordCount / OnEachPage)>
<cfparam name="PageNum" default="1">
<p><cfoutput> Now displaying records #StartRow# to #EndRow# of #showLists.RecordCount#. </cfoutput> <br>
  <cfif Previous>
    <cfoutput> 
    	<cfif isdefined('url.search')>
      <a href="#CGI.SCRIPT_NAME#?search=#url.search#&StartRow=#PreviousStart#&PageNum=#DecrementValue(PageNum)#">&lt;&lt;&nbsp;Previous</a>
      <cfelseif isdefined('url.date')>
      <a href="#CGI.SCRIPT_NAME#?date=#url.date#&StartRow=#PreviousStart#&PageNum=#DecrementValue(PageNum)#">&lt;&lt;&nbsp;Previous</a>
      <cfelseif isdefined('url.CategoryID')>
      <a href="#CGI.SCRIPT_NAME#?CategoryID=#url.CategoryID#&StartRow=#PreviousStart#&PageNum=#DecrementValue(PageNum)#">&lt;&lt;&nbsp;Previous</a>
      <cfelse>
      <a href="#CGI.SCRIPT_NAME#?StartRow=#PreviousStart#&PageNum=#DecrementValue(PageNum)#">&lt;&lt;&nbsp;Previous</a>
      </cfif>
    </cfoutput>
    <cfelse>
    &nbsp;
  </cfif>
  <cfloop from="1" to="#NumPages#" index="ThisPage">
    <cfoutput>
      <cfif ThisPage IS PageNum>
        #ThisPage#
        <cfelse>
        <cfset PageNumStart=(((ThisPage - 1) * OnEachPage) + 1)>
        <cfif isdefined('url.search')>
        <a href="#CGI.SCRIPT_NAME#?search=#url.search#&StartRow=#PageNumStart#&PageNum=#ThisPage#">#ThisPage#</a>
        <cfelseif isdefined('url.date')>
        <a href="#CGI.SCRIPT_NAME#?date=#url.date#&StartRow=#PageNumStart#&PageNum=#ThisPage#">#ThisPage#</a>
        <cfelseif isdefined('url.CategoryID')>
        <a href="#CGI.SCRIPT_NAME#?CategoryID=#url.CategoryID#&StartRow=#PageNumStart#&PageNum=#ThisPage#">#ThisPage#</a>
        <cfelse>
        <a href="#CGI.SCRIPT_NAME#?StartRow=#PageNumStart#&PageNum=#ThisPage#">#ThisPage#</a>
        </cfif>
      </cfif>
    </cfoutput>
  </cfloop>
  <!--- If Next is true, display the previous link. --->
  <cfif Next>
    <cfoutput> 
    <cfif isdefined('url.search')>
      <a href="#CGI.SCRIPT_NAME#?search=#url.search#&StartRow=#NextStart#&PageNum=#IncrementValue(PageNum)#">Next&nbsp;&gt;&gt;</a>
    <cfelseif isdefined('url.date')>
      <a href="#CGI.SCRIPT_NAME#?date=#url.date#&StartRow=#NextStart#&PageNum=#IncrementValue(PageNum)#">Next&nbsp;&gt;&gt;</a>
    <cfelseif isdefined('url.CategoryID')>
      <a href="#CGI.SCRIPT_NAME#?CategoryID=#url.CategryID#&StartRow=#NextStart#&PageNum=#IncrementValue(PageNum)#">Next&nbsp;&gt;&gt;</a>   
      <cfelse>
      <a href="#CGI.SCRIPT_NAME#?StartRow=#NextStart#&PageNum=#IncrementValue(PageNum)#">Next&nbsp;&gt;&gt;</a>  
     </cfif> 
    </cfoutput>
    <cfelse>
    &nbsp;
  </cfif>
  </p></div>
<table width="100%" border="0" cellspacing="2" cellpadding="1">
<cfif showLists.recordcount>
<cfoutput query="showlists" startrow="#StartRow#" maxrows="#endRow#">
  <tr>
    <td width="88%">#DateFormat(DateAdded,'dddd, mmmm,dd yyyy')#</td>
    <td width="12%">&nbsp;</td>
  </tr>
  <cfif showLists.DateAdded GT (DateFormat(now(),'dd/mm/yyyy') - Rules_DaysNew)>
  <tr>
    <td><span style="color:red;">New</span></td>
    <td>&nbsp;</td>
  </tr>
  </cfif>
  <cfif isdefined('session.blog') and session.blog EQ 'logged'>
  <tr>
    <td><span style="color:red;">Viewing Status: <cfif Activated eq True>Public<cfelse>Private</cfif></span></td>
    <td>&nbsp;</td>
  </tr>
  </cfif>
  <tr>
    <td colspan="2"><h2><a href="#CGI.SCRIPT_NAME#?ItemID=#ItemID#&CategoryID=#CategoryID#">#itemName#</a></h2></td>
  </tr>
  <tr>
    <td colspan="2"><cfif isDefined('url.itemID')>#ScreenFormat(itemMemo)#<cfelse>#ScreenFormat(Left(itemMemo,300))#...</cfif></td>
  </tr>
  <tr>
  	<td colspan="2"><em>Posted By: #firstname# #lastname# @ #DateFormat(DateAdded,'dddd, mmm dd, yyyy')#</em> <div align="right"><a href="##top">Top</a></div>
</td>
  </tr> 
  <tr><td><cfinclude template="inc_navigation.cfm"></td></tr> 
</cfoutput>  
<cfelse>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2" align="center"><h1>No Postings Found Yet?</h1></td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
</cfif>    
</table>
