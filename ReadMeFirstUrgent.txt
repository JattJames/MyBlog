Hi. This is attempt to Create a Blog In Coldfusion, So far what i have tried to create, i have success. The Blog is Still in beta Phase and I am Constantly Working on it to make it better and better.

How to make it work:

Two Things you have to do:

1. Open Application.cfm file and Change the database information, you can find them here:

<cfset request.dsn = "myblog">
<cfset request.user = "root">
<cfset request.pass = "">

2. Now Edit the mail settings with your own email settings and to make it work properly.

<!--- Define Mail Settings --->
<cfset w = "My Name <name@domain.com>">
<cfset MailUser = "name@domain.com">
<cfset MailPass = "password">
<cfset MPort = "26">
<cfset MServer = "mail.domain.com">
<cfset Mfailto = "errors@domain.com">
<cfset emailOwner = "name@domain.com">

3. Please Note that it works with MYSQL database yet and Support will be added with Access, MSSQL soon. Works with every Coldfusion engine. Either Coldfusion MX, 6,7,8.Bluedragon, Railo, Etc.

To See Blog in Action:

Visit: http://blog.randhawaworld.com

to Help us Grow: Visit the Blog Forum to notify me Bugs and Errors and Suggestions:

Visit: http://www.randhawaworld.com/forums/


Please Visit My website for New and Updated Applications.

Http://www.randhawaworld.com

If You Do use My Blog Anywhere in your website, Pleae link to my website so i can provide you with better interface and new features.

Regards.

