
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
auth::require_login



if {[db_0or1row name_pass ""]}   {

    append HTML "
<applet ARCHIVE='E4.jar' code='E4' width='300' height='400' name='E4'>
<PARAM name='server' value='[jb_get_transport_url_from_id 1]'>
<param name='port' value='5222'>
<param name='username' value='$jabber_screen'>
<param name='password' value='$jabber_passwd'>
<param name='autologin' value='true'>
<param name='conferenceserver' value='conference.[jb_get_transport_url_from_id 1]'>
<param name='embed' value='false'>
If you see this text, the scrolls say your browser does not support java applets.
</applet>
"
} else {
    append HTML "you are not registert!"
}

append HTML "</body></html>"
doc_return  200 text/html $HTML
