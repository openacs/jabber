
set  HTML {
<?xml version="1.0" encoding="utf-8"?> 
<!-- APPLET CODEBASE EINGEBEN UND REFERENZ AUF JNLP FILE --> 
<jnlp
  codebase="http://myCodeBase.com/jnlp/" 
  href="Applet.jnlp">
    <information> 
	<!-- Produktinformationen -->
       <title>Jabber Applet</title> 
       <vendor>SourceForge</vendor>
       <homepage>http://jabberapplet.sourceforge.net</homepage>
       <description>JabberApplet</description> 
       <description kind="short">JabberApplet is a lighweight jabber chat client!</description>  
     </information> 
   
	
  <resources> 
       <j2se version="1.4"/> 
	<jar href="JabberApplet.jar"/>
     </resources> 
}

set user_id [ad_conn user_id]
auth::require_login



if {[db_0or1row name_pass "Select (jb_screens.im_screen_name) as jabber_screen , jb_user_jabber_information.jabber_passwd 
                           from jb_user_jabber_information, jb_screens 
                           where jb_user_jabber_information.user_id = :user_id 
                           and jb_screens.user_id = :user_id and jb_screens.service = 'jabber'"]}   {

    append HTML "
    <APPLET-DESC main-class=org/jabber/applet/JabberApplet.class documentbase='JabberApplet.jar' height=200 name=JabberApplet 
    width=180 VIEWASTEXT ARCHIVE='JabberApplet.jar'>
    <PARAM NAME='xmlhostname' VALUE='intranet.sussdorff-roy.com'>
    <PARAM NAME='xmlhostnamex' VALUE='jabber.org'>
    <PARAM NAME='defaultColor' VALUE='100,149,237'>
    <PARAM NAME='code' VALUE='org/jabber/applet/JabberApplet.class'>
    <PARAM NAME='height' VALUE='200'>
    <PARAM NAME='name' VALUE='JabberApplet'>
    <PARAM NAME='width' VALUE='180'>
    <PARAM NAME='VIEWASTEXT' VALUE=''>
    <PARAM NAME='ARCHIVE' VALUE='JabberApplet.jar'>
    <PARAM NAME='user' VALUE='$jabber_screen'>
    <PARAM NAME='pwd' VALUE='$jabber_passwd'>
    </APPLET-DESC>"
} else {
    append HTML "you are not registert!"
}

append HTML "</jnlp>"
doc_return  200 application/x-java-jnlp-file $HTML
