
<master src="doc-master">
<property name=title>Installation Guide</property>
<center>
<a href="introduction">Back: Introduction</a>
<a href="installation">Next: Jabber Client Installation</a>
</center>

<p>
Download the jabber-1.4.2 server to your tmp directory.
and do the same with mod_acs-0.0.8.x.tar.gz
</p>
<p>
Now unzip and untar the archive.
</p>
<ul>
<LI>>gzip -d jabber-1.4.2.tar.gz</LI>
<LI>>tar -xvf jabber-1.4.2.tar</LI>
</UL>
<p>
now copy the mod_acs-0.0.8.x.tar.gz into the jabber-1.4.2 dir.
</p>
<p>
>mv mod_acs-0.0.8.x.tar.gz jabber-1.4.2
</p>
<p>
Now configure and make the binaries.
</p>

<UL>
<LI>>cd jabber-1.4.2</LI>
<LI>>gzip -d mod_acs-0.0.8.x.tar.gz</LI>
<LI>>tar -xvf mod_acs-0.0.8.x.tar</LI>
<LI>>./configure</LI>
</UL>
edit the make files.

<p>
>make
</p>
<p>
If no errors occured you can now configure your jabber server.
</p>
<p>
>emacs jabber.xml
</p>
<p>
now replace the all "localhost" appearences with "your.domain.name"
</p>

<p>
(In emacs the easiest way in emacs todo this is:
 M-x replace-string (hit enter)
 localhost (enter)
 your.domain.com (enter)
<br>
 emacs will tell you how many times it replaces "localhost" with "your.domain.name"
  ) 
</p>

<p>
Quit emacs C-x C-c, and start the server vor the first time.
</q>
<p>
>jabberd/jabberd -D
</p>
<p>
Now try to connect to your Jabber Server with your Jabber Client , and register a account, if it worecked 
, register an acount for your aolserver.  
</p>
<p>
Now install the jabberd server to /usr/local/jabber
</p>
<UL>
<LI>>su root</LI>
<LI>>cd /usr/local</LI>
<LI>>mkdir jabber</LI>
<LI>>chown nsadmin jabber</LI>
<LI>>chown web jabber</LI>
<LI>>exit</LI>
</UL>
<p>
As nsadmin go back to the /tmp/jabber-1.4.2/  dir. and copy the following files.
</p>
<UL>
<LI>&gt;cd /tmp/jabber-1.4.2</LI>
<LI>&gt;mkdir /usr/local/jabber/jabberd</LI>
<LI>&gt;cp jabberd/jabberd /usr/local/jabber/jabberd</LI>
<LI>&gt;mkdir /usr/local/jabber/</LI>
<LI>&gt;cp jsm/*.so  /usr/local/jabber/jsm</LI>
<LI>&gt;cp pthsock/*.so  /usr/local/jabber/</LI>
<LI>&gt;cp dnsrv/*.so  /usr/local/jabber/</LI>
<LI>&gt;cp xdb_file/*.so  /usr/local/jabber/</LI>
<LI>&gt;cp -r spool   /usr/local/jabber/</LI>
<LI>&gt;cp dialback/*.so  /usr/local/jabber</LI>
<LI>&gt;rm -r cygin</LI>
</UL>


<p>
Now download the transports (aim , yahoo , etc.) and install them.
</p>
<p>
Download the aim-transport-0.x.x.tar.gz to the folder /tmp/jabber-1.4.1
</p>
<UL>
<LI>>gzip -d aim-transport-0.x.x.tar.gz</LI>
<LI>>tar -xvf aim-transport-0.x.x.tar</LI>
<LI>>cd aim-transport-0.x.x </LI>
<LI>>emacs README</LI>
</UL>

<p>
In the README file you find everything you have to know to compile an configure the transport,
compilation an configuration can vary from transport to transport, this is what it mostly locks like.
</P>

<UL>
<LI>&gt;cd aim-transport-0.x.x</LI>
<LI>&gt; ./configure</LI>
<LI>&gt;make</LI>
<LI>&gt;mkdir /usr/local/jabber/aim</LI>
<LI>&gt;cp src/*.so /usr/local/jabber/aim</LI>
<LI>&gt;emacs /usr/local/jabber/jabber.xml</LI>
</UL>

<p>
Inserting a &lt;browes&gt; and a &lt;service&gt; section, into the jabber.xml file.
 </p>
<table bgcolor=grey>

<tr><td>&lt;jabber&gt;</td></tr>
<tr><td>  ...</td></tr>
<tr><td>   &gt;jsm&gt;</td></tr>
 <tr><td>    ...</td></tr>
 <tr><td>     &lt;browes&gt;</td></tr>

<tr><td>       &lt;!-- The Browes section is only important if you want to let users use 
             your transporst, this is no technical configuration of the Server or
             it's Transports, it's just to information Jabber Client Aplication's
             what Transports are available.
        --&gt;    
</td></tr>
  <tr><td>       &lt;service type="aim" jid="aim.intranet.sussdorff-roy.com" name="AIM Transport"&gt; </td></tr>
<tr><td>          &lt;ns&gt;jabber:iq:gateway&lt;/ns&gt; </td></tr>
     <tr><td>     &lt;ns&gt;jabber:iq:register&lt;/ns&gt; </td></tr>
<tr><td>        &lt;/service&gt; </td></tr>
      
     <tr><td>  .....</td></tr>
     <tr><td>  &lt;/browes&gt; </td></tr>
   <tr><td>  &lt;/jsm&gt;</td></tr>

     

  
<tr><td>

       &lt;!-- The Service section is very important, it tells jabberd wich Transports (lib's) to use,
            their two ways to use a Transport 1. load/run it in the main jabberd proccess.
            2.  load/run a Transport in a own jabberd proccess, and let the main jabberd proccess
                connect to it via the network (prefered way )  
        
            As well the service Section configures the Transports (wich url they use etc.) --&gt;
   
</td></tr>
<tr><td>
       &lt;!-- 1. To load/run a Transport in the main jabberd proccess,  put a &lt;service&gt;-xml (like the example A.) 
            into the jabber.xml file to let the main jabberd proccess load/configure/run the Transport. 
            After you entered this Section you can restart your server with:
            <br>
            &gt;jabberd/jabberd -c /usr/local/jabber/jabber.xml 
            <br>
            and the Transport will be available to your users.   
             --&gt;
</td></tr>  

</table>

 Example A. :
<table bgcolor=grey>
<tr><td>       &lt;service id='aim.intranet.sussdorff-roy.com'&gt;</td></tr>
<tr><td>	   &lt;aimtrans xmlns='jabber:config:aimtrans'&gt;</td></tr>
<tr><td>	   &lt;aimbinarydir&lt;/home/bkiesbye/jabber/jabber-1.4.1/aim-transport-0.9.23/aim3.5.1670&gt;/aimbinarydir&lt;</td></tr>
        <tr><td>   &lt;vCard&gt;</td></tr>
<tr><td>	    &lt;FN&gt;AIM Transport&lt;/FN&gt;</td></tr>
<tr><td>	    &lt;DESC&gt;An AIM Transport!&lt;/DESC&gt;</td></tr>
<tr><td>	    &lt;URL&gt;http://aim.intranet.sussdorff-roy.com/&lt;/URL&gt;</td></tr>
<tr><td>	   &lt;/vCard&gt;</td></tr>
<tr><td>	  &lt;/aimtrans&gt;</td></tr>
<tr><td>	  &lt;load&gt;</td></tr>
<tr><td>	   &lt;aim_transport&gt;./aim-transport-0.9.24c/src/aimtrans.so&lt;/aim_transport&gt;</td></tr>
<tr><td>	  &lt;/load&gt;</td></tr>
<tr><td>     &lt;t/service&gt; </td></tr>
<tr><td></td></tr>

<tr><td>      

       &lt;!-- 2. To let the main jabberd proccess connect to a Transport that runs in a seperate proccess. 
               you need a different styled <service> sektion in your jabber.xml file (Example B) to let the main jabberd
               know how to connect to a  Transport that runs in a seperate proccess (may even on a seperate server)  
               , and a seperate Transport-jabber.xml (Example C.) file, to let the seperate jabberd proccess 
               load/configure/run The transport.   
--&gt;
</td></tr>

</table>
     
   Example B.:     
<table bgcolor=grey>

<tr><td></td></tr>
<tr><td>         &lt;service id="yahoo-linker"&gt;</td></tr>
<tr><td>           &lt;host&gt;yahoo.intranet.sussdorff-roy.com&lt;/host&gt;</td></tr>
<tr><td>           &lt;accept&gt;</td></tr>
<tr><td>            &lt;ip&gt;127.0.0.1&lt;/ip&gt;         &lt;!-- Server IP the Transport runs on &gt;</td></tr>
<tr><td>            &lt;port&gt;5237&lt;/port&gt;          &lt;!-- the port to connect to (same as in Example C.) &gt;</td></tr>
<tr><td>            &lt;secret&gt;passwd&lt;/secret&gt;</td></tr>
<tr><td>          &lt;/accept&gt;</td></tr>
<tr><td>       &lt;/service&gt;</td></tr>
     
   
<tr><td></td></tr>
<tr><td>&lt;/jabber&gt;</td></tr>
</table>

<p>
    The conntent of the extra file should look like this (yahoo-jabber.xml)
</p>
   
<table bgcolor=grey>
<tr><td>    &lt;!-- Example yahoo-jabber.xml configuration file --&gt;</td></tr>
<tr><td></td></tr>
<tr><td>    &lt;jabber&gt;</td></tr>
<tr><td></td></tr>
<tr><td>       &lt;!-- This section is to let this proccess know how to connect to the main jabberd proccess --&gt;</td></tr>
<tr><td></td></tr>
<tr><td>       &lt;service id="yahoo-linker"&gt;</td></tr>
<tr><td>         &lt;connect&gt;</td></tr>
<tr><td>            &lt;ip&gt;127.0.0.1&lt;/ip&gt;</td></tr>
<tr><td>            &lt;port&gt;5237&lt;/port&gt;</td></tr>
<tr><td>            &lt;secret&gt;passwd&lt;/secret&gt;</td></tr>
<tr><td>        &lt;/connect&gt;</td></tr>
<tr><td>        &lt;uplink/&gt;</td></tr>
<tr><td>     &lt;/service&gt;</td></tr>
<tr><td>  &lt;pidfile&gt;./yahoo-jabber.pid&lt;/pidfile&gt;</td></tr>
<tr><td></td></tr>
<tr><td></td></tr>

<tr><td>       &lt;!-- This section is to load/configure the Transport it self. --&gt;</td></tr>
<tr><td></td></tr>
<tr><td>      &lt;service id="yahoo.intranet.sussdorff-roy.com"&gt;</td></tr>
<tr><td>       &lt;load&gt;&lt;yahoo_transport&gt;./yahoo-transport.so&lt;/yahoo_transport&gt;&lt;/load&gt;</td></tr>
<tr><td>        &lt;config xmlns="jabber:config:yahoo"&gt;</td></tr>
<tr><td>        &lt;vCard&gt;</td></tr>
<tr><td>         &lt;NAME&gt;Yahoo Transport&lt;/NAME&gt;</td></tr>
<tr><td>        &lt;/vCard&gt;</td></tr>
<tr><td>        &lt;server&gt;scs.yahoo.com&lt;/server&gt;</td></tr>
<tr><td>        &lt;port&gt;5050&lt;/port&gt;</td></tr>
<tr><td>        &lt;charmap&gt;CP1252&lt;/charmap&gt;</td></tr>
<tr><td>      &lt;/config&gt;</td></tr>
<tr><td>     &lt;/service&gt;</td></tr>
<tr><td></td></tr>
<tr><td>&lt;/jabber&gt;</td></tr>
</table>

<p>
You can now start your main jabberd proccess with:
</p>
<p>
&gt;jabberd/jabberd -c /usr/local/jabber/jabber.xml
</p>
<p>
and to start the Transport in it's own proccess type:
</p>
<p>
&gt;jabberd/jabberd -c /usr/local/jabber/yahoo-jabber.xml
</p>
<p>
It will atomaticly try to connect to the main jabberd proccess via the network,
you can start/stop/crash  the seperate Transport proccess without harming the main jabberd proccess.
In case you run your Transport on a seperate Server you need a Jabber instalation on this Server as well.
 </p>


<center>
<a href="introduction">Back: Introduction</a>
<a href="installation">Next: Jabber Client Installation</a>
</center>



    