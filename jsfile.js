// JavaScript Document
function validatePassword(form,field,value) {
if (value.length < 6) {
return 0;
}
else {
return 1;
}
}

function checkPasswordsMatch(form,field,value) {
if (value != form.userpass.value) {
return 0;
}
else {
return 1;
}
}

function WinOpen(url,x,y) { 
        var attributes = "toolbar=no,scrollbars=yes,resizable=no,width=" + x + ",height=" + y; 
        msgWindow=window.open(url,"WinOpen",attributes); 
} 
if ( !WinOpen ){ 
    alert('You must disable your popup blocker for this website to allow you to login!'); 
}



var lastDiv = "";
function showDiv(divName) {
	// hide last div
	if (lastDiv) {
		document.getElementById(lastDiv).className = "hiddenDiv";
	}
	//if value of the box is not nothing and an object with that name exists, then change the class
	if (divName && document.getElementById(divName)) {
		document.getElementById(divName).className = "visibleDiv";
		lastDiv = divName;
	}
}
var count = "1000";   //Example: var count = "175";
function limiter(){
var tex = document.myform.description.value;
var len = tex.length;
if(len > count){
        tex = tex.substring(0,count);
        document.myform.description.value =tex;
        return false;
}
document.myform.limit.value = count-len;
}
function showHideComment(onOff){ 
    if (onOff == 1){ 
      document.getElementById('commentArea').style.display = ""; 
    } else { 
      document.getElementById('commentArea').style.display = "none"; 
    } 
  }
  
function checkboxes(theElement) {
var theForm = theElement.form, z = 0;
for(z=0; z<theForm.length;z++){
if(theForm[z].type == 'checkbox' && theForm[z].name != 'checkall'){
theForm[z].checked = theElement.checked;
}
}
}  
  