proc auto-login-1 { destination } {


set HTML {
<html>
<head>
   <meta name="Author" content="björn Kiesbye">
   <title>Jabber Client</title>
<script Language="JavaScript">
function openjabberwin(redirect) {
  para = "alwaysRaised=1,height=500,width=500,screenX=400,screenY=400,titlebar=0,status=0" 
  window.open("jabber-auto-login-greenthumb-neu.tcl" , "jabber" , para);
  //var next = window.location.protocol + window.location.host + window.location.port  + "//" + redirect;
 
 window.location.href = redirect; 
}
</script>
</head>
}

append HTML "
<body onload=openjabberwin(\"$destination\");>
<p>If no new small window has opened please click <a href='jabber-auto-login-greenthumb.tcl' target='Jabber'>this Link</A> to open a new window for the Jabber client,
resize it yourself and then click <a href='$destination'>this Link</A> to proceed.
</p>
<p>If you have your own Jabber Client, you can visit the Jabber preference page and disable the Jabber Applet.</P>
</body>
</html>"

doc_return 200 text/html  $HTML
}

set_the_usual_form_variables
auto-login-1 "$return_url"

