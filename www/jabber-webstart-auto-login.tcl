
set  JNLP {
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

	<!-- docBase EINGEBEN UND PARAMS SETZEN -->
     <applet-desc documentBase="http://myDocBase" name="JabberApplet" 		main-class="org/jabber/applet/JabberApplet" height="200" width="180">

}



set user_id [ad_conn user_id]
auth::require_login



if {[db_0or1row name_pass ""]}   {

    append JNLP "
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
         </applet-desc>
</jnlp>"

doc_return  200 application/x-java-jnlp-file $JNLP

} else {
    
    set HTML "<html><body><h3>You are not registert!</h3></body></html>"
    doc_return  200 text/html $HTML

}



