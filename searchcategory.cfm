<cfinvoke component="blogcfc.blog" method="getbyCategory" returnvariable="showCats"/>
<script language="JavaScript" type="text/JavaScript">
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
</script>
    <h2>Search by Category </h2>
    <cfoutput query="showCats" group="ParentCategoryID">
     <a href="#cgi.script_name#?ParentCategoryID=#ParentCategoryID#">#ParentCategoryValue#</a> &raquo;<br>
     <cfoutput>
     <li style="padding-left:10px;"><cfif showCats.CategoryImageFile IS NOT "">
     <img src="#request.siteURL#CategoryImages/#CategoryImageFile#" border="0" title="#CategoryValue#" /><br /><cfelse></cfif>
     <a href="#cgi.script_name#?CategoryID=#CategoryID#">#CategoryValue#</a> (#CountOfItemID#)<br /></li>
    </cfoutput>
</cfoutput>
<div align="right"><a href="index.cfm">Show All</a></div>