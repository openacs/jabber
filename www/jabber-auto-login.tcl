
set  HTML {
    <html><head>
    <script language="JavaScript">
    timerID = null;
    var maxmove = 100;
    var moved = 0;
    var xmove = 3;
    var ymove = 3;

    function StartPositioning() {
	timerID = window.setInterval("jabberpos()" , 30 );
    }
    function jabberpos() {
	moved = moved + 1;
	if( moved > maxmove) {window.clearInterval(timerID);return;} 
	if(window.screenX  == screen.width) {xmove = 0;}
	if(window.screenY  == 0) {ymove = 0;}
	
	window.moveBy(3 , 1);
	moved = moved + 1;
	if((xmove == 0 && ymove == 0) ) {window.clearInterval(timerID);return;} 
    }

    </script>
    </head>
    <body >}



set user_id [ad_conn user_id]
ad_maybe_redirect_for_registration



if {[db_0or1row name_pass ""]}   {

#ns_returnredirect "http://aiesec-dev.sussdorff-roy.com:8004/jabber-auto-login.tcl?j_screen=$jabber_screen&j_password=$jabber_passwd"



   append HTML "
    <APPLET code=org/jabber/applet/JabberApplet.class height=200 name=JabberApplet 
    width=180 VIEWASTEXT ARCHIVE='JabberApplet.jar'>
    <PARAM NAME='xmlhostname' VALUE='[jb_get_transport_url_from_id 1]'>
    <PARAM NAME='conferenceserver' VALUE='conference.[jb_get_transport_url_from_id 1]'>
    <PARAM NAME='grpVersion' VALUE='1'>
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
    </APPLET>"
#ad_script_abort
} else {
    append HTML "you are not registert!"
}

append HTML "</body></html>"
doc_return  200 text/html $HTML
