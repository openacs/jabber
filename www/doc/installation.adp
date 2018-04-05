
<master src="doc-master">
<property name=title>Installation Guide</property>

<center>
<a href="jabber-installation">Back: Jabber Server Installation</a>
<a href="user-documentation">Next: General user documentation</a>
</center>

<h1><a name="begin">Installation Guide for Jabber module for OACS</a></h1>


<p>To install the jabber package for OACS adequately you have to
follow these installation instructions. You have to know that the jabber package
is separated in three different installations, which are the C-module for AOLserver, 
C-module for Jabber server and the Jabber APM.
<br>
I you want to go directly to a certain installation guide click on the links:</p>
<a href="#aolserver">AOLServer Installation Guide</a>
&nbsp;
<p>
<a href="#jabber">Jabber Client Installation Guide</a> 

</p>

<p>
All C-Sources you will need to download.
<ul>
<li><a href="http://sussdorff-roy.com/jabber/nsjabber.tar">Source for the Aolserver module (nsjabber.tar)</a></li>
<li><a href="http://sussdorff-roy.com/jabber/mod_acs.tar">Source for the Admin Module for the Jabber Server (mod_acs.tar)</a></li>
<li><a href="http://sussdorff-roy.com/jabber/conference.tar">Source for the Conference Server</a></li>
</ul>
</p>
<p>To install the APM follow the installation instructions for all APMs described 
in the documentation for the package manager.</p>

<h2>1. Installation Requirements for the C-modules</h2>

<p>The C-modules have certain requirements to work correctly. First of all you need an
AOLserver installation with the entire source code (no rpm installation!) and of course 
an Jabber server installation with enteire source code.</p>

<p>Installation instructions for these applications can be found at these urls:
<br>AOLserver installation: <a href="http://www.aolserver.com">http://www.aolserver.com</a>
<br>Jabber server installation: <a href="http://www.jabber.org">http://www.jabber.org</a>
</p>

<h2><a name="aolserver">2. Installation Guide for AOLserver C-module (Jabber-Client)</a></h2>
<a href="#begin">Up</a>

<p>You must have a valid Jabber-ID, so please start a public Jabber Client and register
as a normal Jabber user. This Jabber user is necessary as a parameter for the AOLserver.</p>

<p>Following instructions should be made as "nsadmin", so type in a bash shell:
<br>?- su -nsadmin   (RET)
<br>?- password: *******   (RET)
<br>
<br>
<br>Copy the tar file to "/your/path/to/aolserver/" and untar the file there.
<br>Now you should have a new directory named nsjabber. Next go to "/your/path/to/aolserver/nsjabber/bin" 
and type "make". To see whether everything went right you should find a new file named ns_jabber.so.</p>

<p>You may now type "make install" to install the Jabber_Client in the
directory "/usr/local/aolserver/bin", this is the default installation
directory for AOLServer.<br>
Now you have to configure the client and add following lines to your
aolserver-config.tcl.
<br>  
</p>

<ul>
<li>ns_section ns/server/${server}/module/nsjabber</li>
<li>ns_param jid  aiesec@intranet.sussdorff-roy.com/DEV</li>
<li>ns_param pw  secret</li>
<li>ns_param jabber_server  intranet.sussdorff-roy.com</li>
<li>ns_param aim_transport  aim.intranet.sussdorff-roy.com</li>   
<li>ns_param conference_service  conference.intranet.sussdorff-roy.com</li>
<li>ns_param msn_transport  msn.intranet.sussdorff-roy.com</li>
<li>ns_param yahoo_transport  yahoo.intranet.sussdorff-roy.com</li>
<li>ns_param icq_transport  icq.intranet.sussdorff-roy.com</li>   
<li>ns_param yahoo_transport  yahoo.intranet.sussdorff-roy.com</li> 
</ul>

<p>The "jid" parameter is the jabber id you created already (as described
above). It has to be exactly (case sensetive) the same you
specified (or you will specify) in the jabber.xml config file of your
Jabber Server.
<br>
The "pw" parameter is the password for the above specified jid to
login the Jabber Server.
<br>
The "jabber_server" parameter is the URL of your Jabber Server, the
same that you specified in your jabber.xml config file in the <host/>
 section.    
<br>
<br>
The following param's are the FQN of your transports (aim. icq , etc.).
<br>
The next section has to be below the above one in your config.tcl.
The section probably already exists in your config and you will only
have to add one parameter.
<br>
</p>

<ul> 
<li>ns_section ns/server/${server}/modules</li>
<li>ns_param nsperm nsperm.so</li>
<li>ns_param nssock nssock.so</li>
<li>ns_param nslog nslog.so</li>
<li>ns_param nssha1 nssha1.so</li>
<li>ns_param nscache nscache.so</li>
<li></li>
<li>#-------The parameter to add------</li>
<li>ns_param nsjabber ns_jabber.so</li>
<li>#---------------------------------</li>
</ul>
<br>
This parameter tells the AOLServer to load the Jabber Client module
into the core AOLServer.

<p>The jabber client needs a own Databasehandle pool with 2 handles.
To create the Pool add the following Lines to the existing sections ...
(NOTE: The configuration of the Database may vary,
depending on what driver you are using)
</p>

<ul> 
<li>ns_section "ns/servers" </li>
<li>#-------The parameter to add------</li>
<li>set jabberpoolconn(<i>yourserver</i>) 2</li>
<li>#--------------------------------</li>
<li></li>
<li>ns_section "ns/db/pools"</li>
<li>#-------The parameter to add------------</li>
<li>    ns_param   jabber     "Jabber Pool"</li>
<li>#---------------------------------------</li>
</ul>

<br>... and then add this section to your ini.tcl
<br>
<ul>
<li>ns_section "ns/db/pool/jabber" </li>
<li>    ns_param Driver ora8 </li>
<li>    ns_param Connections $jabberpoolconn(${server}) </li>
<li>    ns_param DataSource  ""</li>
<li>    ns_param User        $dbuser(${server})</li>
<li>    ns_param Password    $dbpw(${server})</li>
<li>    ns_param Verbose on </li>
<li>    ns_param LogSQLErrors On </li>
<li>    ns_param ExtendedTableInfo On</li>
<li>    ns_param MaxOpen 1000000000 </li>
<li>    ns_param MaxIdle 1000000000 </li>
</ul>
<br>
<p>Finally add this line to the mime type section.It is needed to let the Aolserver work together with Java WebStart.</p>
<table>
<tr><td>ns_section ns/mimetypes
<tr><td>ns_param  Default  text/plain</tr></td>
<tr><td>ns_param  NoExtension  text/plain</tr></td>
<tr><td>ns_param  .pcd  image/x-photo-cd</tr></td>
<tr><td>ns_param   .prc               application/x-pilot</tr></td>
<tr><td>ns_param   .xls               application/vnd.ms-excel</tr></td>
<tr><td><i>the line to add \/</i></tr></td>
<tr><td>ns_param   .jnlp              application/x-java-jnlp-file</tr></td>
</table>

<p>Now you may restart your AOLserver to load the nsjabber.so module and
test it. Make sure you have installed the the mod_acs in your Jabber
Server otherwise you won't be able to use the admin functionality.
But if you like you can let aolserver send Messages to any valid jid,
<br>
use the following tcl commands:
<br>
set conn_state [jb_login]  #conn_state will be 0 on succsess -1 on error  
<br>
set succsess   [jb_message "user@server"  "The Message string"]
#will be 0 on succsess -1 when the client isn't logged in
<br>
set conn_state [jb_logout]   
</p>


<h2><a name="jabber">3. Installation Guide for Jabber Client C-module</a></h2>
<a href="#begin">Up</a>


<p>Now follow some installion tasks for the Jabber Client
These tasks have to be accomplished as the user how is in charge for the Jabber Server !</p>
C-module. These C-module enables a jabber admin mod.</p>
<p>Copy the mod_acs.tar file to the head Source directory of your Jabber Server (like /your/path/to/jabber-1.4.x),<br>
   Now type<br>
?- tar -xvf mod_acs.tar to utar the file. 
<br>
The extracted files should be copyed to the directories where they belong atomaticly. 
</p>



<p>Change to the modules directory type:

<br>?- cd jsm/modules
<br>open the file 'Makefile' with your preferred editor,
(type: emacs Makefile )
and put a entry saying 'mod_acs.o'  at the end of the 'jsm_modules_OBJECTS'
section and save it.It should look like this when you are finished :
</p>
<table bgcolor="#C0C0C0">
<tr><td>jsm_modules_OBJECTS=\</td></tr>
<tr><td>	&nbsp;&nbsp; mod_admin.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_agents.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_browse.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_announce.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_auth_plain.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_auth_digest.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_auth_0k.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_echo.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_filter.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_groups.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_presence.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_xml.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_roster.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_time.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_vcard.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_version.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_register.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_log.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_last.o \</td></tr>
<tr><td>	&nbsp;&nbsp; mod_offline.o\     &lt;----------------------------------!</td></tr>
<tr><td>        &nbsp; mod_acs.o    &lt;---- Your edit. Don't forget to put a ' \ ' at the end</td></tr>
<tr><td>                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  of the above line!!! </tr>
</table>   

<p>Don't forget to save your edits.
<br> 
Now close your editor , and go back one directory (type: cd .. ),
you are now in the '/your/path/to/jabber-1.4.x/jsm'  directory.
Open the file 'Makefile' with your preferred editor 
(this is the second and last Makefile you have to edit),
(type: emacs Makefile )
and put a entry saying 'mod_acs.o'  at the end of the 'jsm_EXOBJECTS'
section and save it.It should look like this when your finished : 
</p>

<table bgcolor="#C0C0C0">
<tr>jsm_EXOBJECTS = \</tr>
<tr><td>	&nbsp;&nbsp; modules/mod_admin.o \ </td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_agents.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_browse.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_announce.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_auth_plain.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_auth_digest.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_auth_0k.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_echo.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_filter.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_groups.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_presence.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_xml.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_roster.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_time.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_vcard.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_version.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_register.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_log.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_last.o \</td></tr>
<tr><td>	&nbsp;&nbsp; modules/mod_offline.o\  &lt;----------------------------------!</td></tr>
<tr><td>    &nbsp;&nbsp; modules/mod_acs.o &lt;------ Your edit. Don't forget to put a ' \ ' 
<tr><td>                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  at the end  of the above line!!!</td></tr>
</table>
 
<p>Don't forget to save your edits.
<br>
Close your editor aigan and and move up a nother directory,
do this by typing: 
<br>cd ..   in your shell. Now you schould be in the '/your/path/to/jabber-1.4.x'
directory now type:
<br>
make 
<br>
and may (to install the new binarys)
<br> 
make install
<br>
<br>
in your shell.You will see a debug report if no errors ocure you are done.
If an error ocures (somthing like: `can't find mod_acs.o'),
check if you have done everything right in the above sections,
<br>
<br>
But if everything went right, its now time to configure your Jabber Server
to work with the module.
<br>
In the same dir the '/your/path/to/jabber-1.4.x' open the jabber.xml file 
with your preferred editor, type:
<br>
emacs jabber.xml
<br>
you have probably done this before, now go to the '&lt;service&gt;' section and in 
ther to the '&lt;load&gt;' section
insert a line saying :
</p>

<p>&quot;<i>&lt;mod_acs&gt;./jsm/jsm.so&lt;/mod_acs&gt;&quot;
</i>
</p>

<p>
at the seconed row of the '&lt;load&gt;' section.Make sure you placed your edits in
the first row after the '&lt;jsm&gt;' row , other wise the module wont work.
Save your edits , it should look like this:
</p>

<i>

<table bgcolor="#C0C0C0">
<tr><td> &lt;service&gt;</tr>
<tr><td> ...</tr>
<tr><td>&lt;several services&gt;</tr>
<tr><td>....</tr>
<tr><td>&nbsp;&lt;load main="jsm"&gt;</tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;jsm&gt;./jsm/jsm.so&lt;/jsm&gt;</tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_acs&gt;./jsm/jsm.so&lt;/mod_acs&gt;   &lt;-----enter your row here. </tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_echo&gt;./jsm/jsm.so&lt;/mod_echo&gt;</td></tr>
<tr><td>  &nbsp;&nbsp;&nbsp; &lt;mod_roster&gt;./jsm/jsm.so&lt;/mod_roster&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_time&gt;./jsm/jsm.so&lt;/mod_time&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_vcard&gt;./jsm/jsm.so&lt;/mod_vcard&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_last&gt;./jsm/jsm.so&lt;/mod_last&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_version&gt;./jsm/jsm.so&lt;/mod_version&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_announce&gt;./jsm/jsm.so&lt;/mod_announce&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_agents&gt;./jsm/jsm.so&lt;/mod_agents&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_browse&gt;./jsm/jsm.so&lt;/mod_browse&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_admin&gt;./jsm/jsm.so&lt;/mod_admin&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_filter&gt;./jsm/jsm.so&lt;/mod_filter&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_offline&gt;./jsm/jsm.so&lt;/mod_offline&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_presence&gt;./jsm/jsm.so&lt;/mod_presence&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_auth_plain&gt;./jsm/jsm.so&lt;/mod_auth_plain&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_auth_digest&gt;./jsm/jsm.so&lt;/mod_auth_digest&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_auth_0k&gt;./jsm/jsm.so&lt;/mod_auth_0k&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_log&gt;./jsm/jsm.so&lt;/mod_log&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_register&gt;./jsm/jsm.so&lt;/mod_register&gt;</td></tr>
<tr><td>      &nbsp;&nbsp;&nbsp; &lt;mod_xml&gt;./jsm/jsm.so&lt;/mod_xml&gt;</td></tr>
<tr><td>     &nbsp;&lt;/load&gt;</td></tr>
<tr><td>  &lt;/service&gt;</td></tr>
</table>  

</i>
<p>
Defining a jadmin section in the jabber-configfile (jabber.xml).
The &lt;/jadmin&gt; tag has to be a direct subtag of the &lt;jsm&gt; section of your config file.
</p>

<table bgcolor="#C0C0C0">
<tr> &lt;jsm xmlns="jabber:config:jsm"&gt;</tr>
<tr>   .</tr>
<tr>   .  </tr>
<tr></tr> 
<tr>&lt;jadmin host="localhost"  community_client="xxx@localhost/resource" standard_buddy="buddy_name" standard_group="buddy_group" &gt;&lt;/jadmin&gt;</tr>   
<tr></tr>   
<tr>  .</tr>
<tr>  . </tr>
<tr>  .</tr>
<tr> &lt;/jsm&gt;</tr>
</table>

<p>   &lt;!-- the "host"  attribute has to be of the same  value,that you defined in the &lt;host&gt; section above.<br>
        the "community_client" needs the same value you defined in the configfile of your web server.<br>
                               admin functions will only register to the session of your web server client<br>
                               when the jid you login with, exactily matches this string <br>
                               (user , server and recource)<br>
<br>
        the "standard_buddy"   is the user part of the jid you defined in the "community_client" attribute.<br>
        the "standard_group"   is the name of the default group you wish to add buddys to.<br>
</p>


</i>
<p>
Don't forget to save your edits.(In emacs you do this by typing: C-x C-s)
<br>
<i>
<br>
</i>
Now go to the spool directory of your jabber server,
<br>
<br>
?- cd spool
<br>
<br> 
there you find towe files plain.xml.1 and plain.xml.2 , the number at the end stands for the server you are using i.e. jabber-1.4.1/1.4.2. If you have not installed the jabber server with make install , all you need to do is to move the file in the server directory, type :
<br>
<br>
?- mv plain.xml.x yourserver.com/plain.xml
<br>
<br>
if you have installed the binarys in another directory you have to move the file into the server directory of your installation path.You have to type somthing like this:
<br>
<br>
?- mv plain.xml.x /your/jabber-instalation/spool/yourserver.com/plain.xml
<br>
<br>
default path is
<br>
<br>
?- mv  plain.xml.x /usr/locale/jabber/spool/yourserver.com/plain.xml
<br>
<br>
The mod will work without this file , but you will not be able to register users via the admin client.
<br>
<br>
<br>
<p>Now you should install the Conference Module for the Jabber Server.
   If you have already installed the commen Conference Module you schould change to our one,
   it is usaly named like the oficial releas with an '+'  at the end,
   it offers additional features witch make it more usefull for OpenACS.
   The extra features are:<br> 
    Limit the creation of Rooms with a specific prefix (like 'offical_xyz') to Admins<br>
    Get the Remote (real) JID's of the Members in a Room. This way we know to wich OpenACS User belongs a Message. <br>
<br>
   The nsjabber module for Aolserver will work with the normal Conference Module, 
   but it's recommended to use the '+' version.  
  </p>

<p>Download the conference-0.4.1+.tar to your server copy it to your Jabber Server directory and untar it.
<br>?- tar -xvf conference-0.4.1+.tar 
<br>know change to the confererence directory and build the binarys. Type:
<br>?- cd conference-0.4.1+
<br>?- make
<br>
<br> if the build was successfull you can now configure the Conference Module.


<p>
   Conference can be configured as a public or private chatroom server,  users from other Jabber Servers will only
   be able to access your Conference Server if the URL it uses is fully qualified :
</p>

<p>
   Open the jabber.xml configuration file again with your preferred Editor and enter the following section to the &lt;service&gt; section; 
</p>
<table bgcolor="#C0c0c0">
<tr><td><pre>&lt;service id='conference.localhost'&gt;</pre></tr></td>
<tr><td><pre>     &lt;load&gt;&lt;conference&gt;/your/path/to/conference/conference.so&lt;/conference&gt;&lt;/load&gt;</pre></tr></td>
<tr><td><pre>  &lt;conference xmlns="jabber:config:conference"&gt;</tr></td>
<tr><td><pre>    &lt;public/&gt;</tr></td>
<tr><td><I>The  below admins section defines admins that are allowed to create Rooms with a specific prefix! </I></tr></td>
<tr><td><I>One of the admins schould be the jid your Aolserver uses, together with the prefix(s) you want to limit to your Comunity</I> </tr></td>
<tr><td><tt><pre>   &lt;admins&gt;</pre></tr></td>
<tr><td><pre>       &lt;admin jid="admin@sussdorff-roy.com"&gt;</pre></tr></td>
<tr><td><pre>        &lt;room&gt;room_name&lt;/room&gt;</pre></tr></td>
<tr><td><pre>        &lt;room&gt;room_prefix&lt;/room&gt;</pre></tr></td>
<tr><td><pre>       &lt;/admin&gt;</pre></tr></td>
<tr><td><pre>    &lt;/admins&gt;</pre></tr></td>
<tr><td><pre>    &lt;vCard&gt;</pre></tr></td>
<tr><td><pre>      &lt;FN&gt;Public Chatrooms&lt;/FN&gt;</pre></tr></td>
<tr><td><pre>      &lt;DESC&gt;This service is for public chatrooms.&lt;/DESC&gt;</pre></tr></td>
<tr><td><pre>      &lt;URL&gt;http://foo.bar/&lt;/URL&gt;</pre></tr></td>
<tr><td><pre>    &lt;/vCard&gt;</pre></tr></td>
<tr><td><pre>    &lt;history&gt;20&lt;/history&gt;</pre></tr></td>
<tr><td><pre>    &lt;notice&gt;</pre></tr></td>
<tr><td><pre>      &lt;join&gt; has become available&lt;/join&gt;</pre></tr></td>
<tr><td><pre>      &lt;leave&gt; has left&lt;/leave&gt;</pre></tr></td>
<tr><td><pre>      &lt;rename&gt; is now known as &lt;/rename&gt;</pre></tr></td>
<tr><td><pre>    &lt;/notice&gt;</pre></tr></td>
<tr><td><pre>    &lt;room jid="help@conference.localhost"&gt;</pre></tr></td>
<tr><td><pre>      &lt;name&gt;Assistance Zone&lt;/name&gt;</pre></tr></td>
<tr><td><pre>      &lt;privacy/&gt;</pre></tr></td>
<tr><td><pre>    &lt;/room&gt;</pre></tr></td>
<tr><td><pre>    &lt;room jid="admin@conference.localhost"&gt;</pre></tr></td>
<tr><td><pre>      &lt;name&gt;Adminz only&lt;/name&gt;</pre></tr></td>
<tr><td><pre>      &lt;secret&gt;con0r&lt;/secret&gt;</pre></tr></td>
<tr><td><pre>      &lt;notice&gt;</pre></tr></td>
<tr><td><pre>        &lt;join&gt; just rocks!&lt;/join&gt;</pre></tr></td>
<tr><td><pre>         &lt;leave&gt; gets lost&lt;/leave&gt;</pre></tr></td>
<tr><td><pre>        &lt;rename&gt; feels it is more important to be known as &lt;/rename&gt;</pre></tr></td>
<tr><td><pre>      &lt;/notice&gt;</pre></tr></td>
<tr><td><pre>    &lt;/room&gt;</pre></tr></td>
<tr><td><pre>  &lt;/conference&gt;</pre></tr></td>
<tr><td><pre>&lt;/service&gt;</pre></tr></td>
</table>

<p>
Add this section to the &lt;browse&gt; area  to advertise it to your users:

<br><br>    &lt;conference type="public" jid="conference.localhost" name="Public Chatrooms"/&gt;

</p>
<br>
<br>
<p>
If you have done this, and no error ocured you are throug with the 
instalation.Check if you have doene everything right by restarting your
server.Type :
</p>


?- cd ../jabberd
<br>
?- jabberd -D
<br>
<br>
Debug output will show errors if any occurred.
</p>
<a href="#begin">Up</a>

<center>
<a href="jabber-installation">Back: Jabber Server Installation</a>
<a href="user-documentation">Next: General user documentation</a>
</center>

<hr>
<ul>
<li>Author: <a href=mailto:bkiesbye@sussdorff-roy.com>  Bjoern Kiesbye</a></li>
<li>Author: <a href=mailto:lmosteiro@sussdorff-roy.com> Luis Mosteiro Fernandez</a></li>
</ul>
