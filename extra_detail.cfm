<cfset valueitemID = "999999">
<cfif isdefined('url.itemID') AND url.itemID NEQ "">
  <cfset valueitemID = "#url.itemID#">
</cfif>
<cfinvoke component="blogcfc.blog" method="getComments" itemID="#trim(valueitemID)#" returnvariable="showComments"/>
<cfinvoke component="blogcfc.blog" method="myFunction" all="show" returnvariable="sComments"/>

<a name="topc"></a>
<cfif sComments.Extra_ConfigText1 EQ False>
  <p>Comments are under Moderation, will be posted soon and Notified to you</p>
  <h2 align="right"><a href="#topc">Top</a></h2>
      <hr>
      <br>
  <cfabort>
  <cfelse>
  <cfif showComments.recordcount>
    <cfoutput query="showComments">
      <h3>Comment</h3>
      <p><img src="../images/avatar.jpg" width="32" height="32" alt="Avatar" />&nbsp;Posted By:&nbsp;#postedby#</p>
      #ItemExtraDetailMemo#
      <p>Posted On:&nbsp;#dateFormat(DateAdded,'dddd, mmm dd, yyyy')#</p>
      <h2 align="right"><a href="##topc">Top</a></h2>
      <hr>
      <br>
    </cfoutput>
    <cfelse>
    <p align="center">No Comment</p>
  </cfif>
</cfif>
