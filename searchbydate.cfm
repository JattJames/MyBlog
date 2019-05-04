<cfinvoke component="blogcfc.blog" method="getbyDate" returnvariable="showbyDate"/>
<script language="JavaScript" type="text/JavaScript">
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
</script>
<form action="" method="post" name="search" id="search">
<h2>Search by Date</h2>
<select name="date" onChange="MM_jumpMenu('parent',this,0)" class="textfield_effect" style="width:150px; height:20px;">
<option value="0">Select One...</option>
<option value="index.cfm">Show All</option>
<cfoutput query="showbyDate">
<option value="index.cfm?date=#Dateformat(DateAdded,'dddd, mmmm dd, yyyy')#">#Dateformat(DateAdded,'ddd, mmm dd, yyyy')#</option>
</cfoutput>
</select>
</form>
