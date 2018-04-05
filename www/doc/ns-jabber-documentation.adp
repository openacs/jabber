<master src="doc-master">
<property name="title">nsjabber procedure documentation</property>


<TABLE width="100%">
<TR>
<H3>Index of all the tcl functions related to the Jabber Client for the AOLServer </H3>
<b>All functions return 0 if the client is connected to the Jabber server,<br>
 and  -1  if the client is not connected to the Jabber Server. 
<br>In the second case no action at all takes places.</b>
<H4>Index</H4>
<P><a href="#jb_getconnstate_doc">jb_getconnstate</A></P>
<P><a href="#jb_addbuddy_doc">jb_addbuddy</A></P>
<P><a href="#jb_addtransbuddy_doc">jb_addtransbuddy</A></P>
<P><a href="#jb_chat_doc">jb_chat</A></P>
<P><a href="#jb_message_doc">jb_message</A></P>
<P><a href="#jb_login_doc">jb_login</A></P>
<P><a href="#jb_logout_doc">jb_logout</A></P>
<P><a href="#jb_remove_doc">jb_remove</A></P>
<P><a href="#jb_removebuddy_doc">jb_removebuddy</A></P>
<P><a href="#jb_removetransbuddy_doc">jb_removetransbuddy</A></P>
<P><a href="#jb_sendxml_doc">jb_sendxml</A></P>
<P><a href="#jb_invite">jb_invite</A></P>
<P><a href="#jb_activeroommembers">jb_activeroommembers</A></P>
<P><a href="#jb_activeconferencerooms">jb_activeconferencerooms</A></P>
<P><a href="#jb_delconferenceroom">jb_delconferenceroom</A></P>
<P><a href="#jb_createconferenceroom">jb_createconferenceroom</A></P>
<P><a href="#jb_new_subject">jb_new_subject</A></P>
<P><a href="#jb_append_subject">jb_append_subject</A></P>
<P><a href="#jb_spellcheck">jb_spellcheck</A></P>
<P><a href="#jb_get_transport_url_from_id">jb_get_transport_url_from_id</A></P>





<br>
<br>
<br>

<a name="jb_getconnstate_doc">

<H3>jb_getconnstate</H3>
<H4>Overview</H4>
<P>Check if the Aolserver is online at the Jabber Server</P>
<H4>Syntax</H4>
<P> <B> jb_addbuddy</B> </P>
<H4>Description</H4>
<P><B>jb_getconnstate </B>Takes no parameters, returns 0 if the Aolserver is online or -1 if not.</P>




<br>
<br>
<br>

<a name="jb_addbuddy_doc">

<H3>jb_addbuddy</H3>
<H4>Overview</H4>
<P>Adding buddy('s) to a user roster.</P>
<H4>Syntax</H4>
<P> <B>[1] jb_addbuddy</B> <I>screenname screenname ...</I></P>
<H4>Description</H4>
<P><B>[1]jb_addbuddy </B> This function is not limited to the amount of parameters,each parameter must be a valid 
    <I><b>sreenname</B></I> (<I>a screenname is a jid with out the Server portion</I>).
    The first parameter has to be the <I>screenname</I> of the user who wants to add someones jid to his roster (e.g. the one who is triggering this function), all other parameters are      the screennames to be added to the firsts roster.   
    If a <I>screenname</I> contains invalid charakters this function returns an error, if a     <I>screenname</I> is spelled corectly  but is not valid the function will not return an error and no action to this specific <I>screenname</I> takes place, but it will still apear in all valid <I>screennames</I> rosters.</P>

<H4>Syntax</H4>
<p> <b>[2]jb_addbuddy</b> <I> list1 list2 .... listn </I></p>
<H4>Description</H4>
<p><b>[2]jb_addbuddy</b> works like <b>[1]jb_addbuddy</b> except that it gets past <I>lists</I> instaed of
simple variables. A list consists of :</p>
<p>
<table align="center" border="1">
       <tr><th>Index</th><th>Value</th><th align="left">Description</th></tr>
       <tr><td>1</td><td>screen</td><td>The screenname of a user</td></tr>
       <tr><td>2</td><td>group</td><td>The (roster)group the jid should be added to.Defaults to "acs"</td></tr>
       <tr><td>3</td><td>name</td><td>The name to be displayed in the roster/chat.Defaults to screen.Requiers a group specified in index 2.</td></tr>
</table>                     
</p>


<br>
<br>
<br>
<hr>

<a name="jb_addtransbuddy_doc">
<H3>jb_addtransbuddy</H3>
<H4>Overview</H4>
<P>Adding buddy from other IM Systems to the Roster of the Web Server Client to track their presence.</P>
<H4>Syntax</H4>
<P> <B>[1] jb_addtransbuddy</B> <I>screenname</I> <I>group</I> <I>Transport id </I></P>
<H4>Description</H4>
<P><B>[1]jb_addtransbuddy </B> This function takes three parameters the first is a Screenname from any IM System that is available, the second is the ID of the IM System (transport) to wich the screenname belongs.You can find out wich ID a transport uses by calling the function <b>jb_get_transport_id_from_symbol $symbol</b>, where symbol is used in the db to identify a service (or transport in jabber terms) (aim ,msn , jabber , etc.)). 
</p>


<br>
<br>
<br>
<hr>

<a name="jb_chat_doc">

<H3>jb_chat</H3>
<H4>Overview</H4>
<P>Start a chat between two users.</P>
<H4>Syntax</H4>
<P> <B>jb_chat</B> <I>screenname screenname </I></P>
<H4>Description</H4>
<P><B>jb_chat </B>
This function takes two parameters, both are <I><b>screennames</b></I> (<I>a screenname is a jid with out the Server portion</I>) , it will start a chat between the specified
 users. Even if both are offline they recive at least a "Hello" and all masseges send, when they go online the next time.If a <I>screenname</I> contains invalid charakters this   function returns an error.</P>
<H4>NOTE</H4>
<P>Nothing</P> 

<br>
<br>
<br>
<hr>

<a name="jb_login_doc">
<H3>jb_login</H3>
<H4>Overview</H4>
<P>Log the AOLServer Client into the Jabber IM Server</P>
<H4>Syntax</H4>
<P><I>success</I> <B>jb_login</B> <I>void</I></P>
<H4>Description</H4>
<P><B>jb_login</B>This function takes no parameters, it logs the community client into the Jabber Server. A call to this function should be done on AOLServer startup, or after a restart of the Jabber Server. It returns (<I>success</I>)  0 on a successfull login and -1 otherwise.</P>
<H4>NOTE</H4>
<P>A automatic login on AOLServer startup is in work but not implemented yet</P>

<br>
<br>
<br>
<hr>

<a name="jb_logout_doc">
<H3>jb_logout</H3>
<H4>Overview</H4>
<P>Log the AOLServer Client out of the Jabber IM Server</P>
<H4>Syntax</H4>
<P> <B>jb_logout</B> <I>void</I></P>
<H4>Description</H4>
<P><B>jb_logout</B> This function takes no parameters, it logs the community client out of the Jabber Server.</P>
<H4>NOTE</H4>
<P>This function is not password protected any tcl programmer can call it.</P> 

<br>
<br>
<br>
<hr>


<a name="jb_message_doc">
<H3>jb_message</H3>
<H4>Overview</H4>
<P>Sending a message.</P>
<H4>Syntax</H4>
<P> <B>jb_message</B> <I>jid message</I></P>
<H4>Description</H4>
<P><B>jb_message </B>
This funktion takes two parameters, the first is a full <I>jid</I> (of any valid Jabber Server including its transports) , the second is the <I>message</I> String.
This function doesn't  return any errors yet.</P>

<br>
<br>
<br>
<hr>


<a name="jb_remove_doc"></a>
<TR>
<H3>jb_remove</H3>
<H4>Overview</H4>
<P>Unregistering a user at the Jabber Server.</P>
<H4>Syntax</H4>
<P> <B>jb_remove</B> <I>screenname</I></P>
<H4>Description</H4>
<P><B>jb_remove </B>
This function takes one parameter, the  <I>srcreenname</I> of the user to be unregistered.If a screenname contains invalid charakters this function returns an error.
The  <I>screenname</I> and all information related to it, will be removed from the community db backend , as well as the Jabber account relaeted to the <i>screenname</I>.   
The user will be imidiatly disconected from the Jabber server.
<H4>NOTE</H4>
<P>We work on a version of this function that returns a un-/successfull unregistration
information.</P> 

<br>
<br>
<br>
<hr>


<a name="jb_removebuddy_doc">
<H3>jb_removebuddy</H3>
<H4>Overview</H4>
<P>Removing buddy('s) from a user roster.</P>
<H4>Syntax</H4>
<P> <B>[1] jb_removebuddy</B> <I>screenname screenname ...</I></P>
<H4>Description</H4>
<P><B>[1] jb_removebudy </B> This function is not limited to the amount of parameters,each parameter must be a valid 
    <I><b>sreenname</B></I> (<I>a screenname is a jid with out the Server portion</I>).
    The first parameter has to be the <I>screenname</I> of the user who wants to remove someones jid from his roster (e.g. the one who is triggering this function), all other parameters are      the screennames to be removed from the firsts roster.   
    If a <I>screenname</I> contains invalid charakters this function returns an error, if a     <I>screenname</I> is spelled corectly  but is not valid the function will not return an error and no action to this specific <I>screenname</I> takes place. The roster held in the users preferred Jabber Client (<I>if the user is online</I>) will not change till the user does a relogin.</P>

<H4>Syntax</H4>
<p> <b>[2] jb_removebuddy</b> <I> list1 list2 .... listn </I></p>
<H4>Description</H4>
<p><b>[2]jb_removebuddy</b> works like <b>[1]jb_removebuddy</b> except that it gets past <I>lists</I> instaed of
simple variables. A list consists of :</p>
<p>
<table align="center" border="1">
       <tr><th>Index</th><th>Value</th><th align="left">Description</th></tr>
       <tr><td>1</td><td>screen</td><td>The screenname of a user</td></tr>
       <tr><td>2</td><td>group</td><td>The (roster)group the jid should be removed from .Defaults to "acs"</td></tr>
</table>                     
</p>

<br>
<br>
<br>
<hr>

<a name="jb_removetransbuddy_doc">
<H3>jb_removetransbuddy</H3>
<H4>Overview</H4>
<P>Removing a buddy from other IM Systems, from the Roster of the Web Server Client to stop tracking their presence.</P>
<H4>Syntax</H4>
<P> <B> jb_removetransbuddy</B> <I>screenname</I>  <I>Transport_ID</I></P>
<H4>Description</H4>
<P><B>jb_removetransbuddy </B> This function takes two parameters the first is a Screenname from any IM System that is available, the second is the Transport ID  of the IM System (transport) to wich the screenname belongs.
</p>

<br>
<br>
<br>
<hr>

<a name="jb_sendxml_doc">
<H3>jb_sendxml</H3>
<H4>Overview</H4>
<P>Sending raw XML.For developers to test new XML. </P>
<H4>Syntax</H4>
<P> <B>jb_sendxml</B> <I>XML</I></P>
<H4>Description</H4>
<P><B>jb_sendxml </B> This function takes one parameter that consists of  serialised <I><b>XML</B></I> (Serialised <I>XML</I> is a string of XML - Tag's).
      It is used by developers only to test new  <I>XML</I> , the <I>XML</I> will be directly send to the Jabber server without any tests.
      If the Jabber server does not accept the <I>XML</I> as valid Jabber <I>XML</I> it will disconect the client.     
</p>
<H4>NOTE</H4>
<P>This function is not password protected any tcl programmer can call it.
   It is also possible that the Jabber server disconnects the client, if bad XML is passed. </P> 

<br>
<br>
<br>
<hr>

<a name="jb_get_transport_url_from_id">
<H3>jb_get_transport_url_from_id</H3>
<H4>Overview</H4>
<P>Retrieving the URL of a transport from the local Jabber Server 
 </P>
<H4>Syntax</H4>
<P> <I>URL</I> <B>jb_get_transport_url_from_id</B> <I>ID</I></P>
<H4>Description</H4>
<P><B>jb_get_transport_url_from_id </B> This function takes one parameter, the <i>ID</i> of a transport. It returns the URL this Transport uses.It is manly used to form JID's .
Example:<br>
<p>
 db_select get_jabber_information "SELECT screen , service FROM jb_screens WHERE user_id = :user_id"<br>
</p>
<p>
set users_jid "$screen@[jb_get_transport_url_from_id [jb_get_transport_id_from_symbol $service]]"
</p>
<p>
jb_message $users_jid "This is your jid $users_jid"
</p>
<p>
This view lines of code retrieve the abstract stored user information from the db. The <i>screen</i> name from one IM System and a Identifier for the <i>service</i> the screen name belongs to. The ns_jabber module stores all URL's
of the local Jabber Server in an array (not tcl array) , it needs a correct id to identify the correct transport. The function jb_get_transport_id_from_symbol is written in tcl , it converts the symbol (easy to read) used to identify a service (transport in jabber terms) in your System into the correct transport id.     
</p>
</p>
 

<br>
<br>
<br>
<hr>


<a name="jb_spellcheck" >
<H3>jb_spellcheck</H3>
<H4>Overview</H4>
<p>Tests if a screen name is spelled corectly  
 </P>
<H4>Syntax</H4>
<P><i>int</i> <B>jb_spellcheck</B> <I>screen</I></P>
<H4>Description</H4>
<P><B>jb_spellcheck</B> This function takes one parameter, a <i>screen</i> that should be checked for illigal Charackters. It returns <b>0</b> if no illigal charackters are used, and <b>-1</b> if the screen contains illigal charackters. 
</p>
 

<br>
<br>
<br>
<hr>


<a name="jb_createconferenceroom" >
<H3>jb_createconferenceroom</H3>
<H4>Overview</H4>
<p> Start recording a chat from the local Jabber Server Conference service.  
 </P>
<H4>Syntax</H4>
<P><i>int</i> <B>jb_createconferenceroom</B> <I>RoomName </I>   <I>user_id </I>   <I>Threadname </I>   <I>creator_jid </I>  <I> short description </I></P>
<H4>Description</H4>
<P><B>jb_createconferenceroom</B>
This function takes   a  <I>RoomName </I>  the   <I>user_id </I> of the creator , a topic name <I>Threadname </I> (which will only be used in case it is the first time this room is recorded), the <I>creator_jid </I> and a <I> short description </I> as parameters. This function will start to record the chat in the conference Room <I>RoomName</I> , if this Room hasn't been opened when it is called , it opens up this Room at the local Jabber Conference Service.  <br>
If  it is the first time a Chat in this Room is Recorded , it will also create a new entry in the table jb_conference_rooms (or an abstraction) and a new entry in the table jb_conference_room_threads
(or an abstraction) . In case a Chat from this Room has been recorded before , it will create a new entry   in the table jb_conference_room_threads (or an abstraction) only. In case of an error it returns <b>-1</b> and <b>0</b>  otherwise.    

</p>
 

<br>
<br>
<br>
<hr>


<a name="jb_delconferenceroom" >
<H3>jb_delconferenceroom</H3>
<H4>Overview</H4>
<p> Stop recording a chat from the local Jabber Server Conference service.  
 </P>
<H4>Syntax</H4>
<P><i>int</i> <B>jb_delconferenceroom</B> <I>RoomName </I>  </P>
<H4>Description</H4>
<P><B>jb_delconferenceroom</B>
This function takes   a  <I>RoomName </I>  as parameter, a call to this function  will stop the recording of the  Chat in the  Room<I> RoomName</I>. The recording of this  Room can be restarted by a call to jb_createconferenceroom.
This function returns <b>-1</b> on an error and <b>0</b> otherwise.
</p>
 

<br>
<br>
<br>
<hr>

<a name="jb_new_subject" >
<H3>jb_new_subject</H3>
<H4>Overview</H4>
<p> Sending a new subject (Topic) to a  Room at the Jabber Server Conference service.  
 </P>
<H4>Syntax</H4>
<P><i>int</i> <B>jb_new_subject</B> <I>RoomName  New_Thread_name  explaination_of_Thread_Name  [optional existing thread_id] </I>  </P>
<H4>Description</H4>
<P><B>jb_new_subject</B>
This function takes   a  <I>RoomName </I>  <I>New_Thread_name</I> <I>explaination_of_Thread_Name</I> and optional an  existing <I>thread_id</I>as parameter, a call to this function  will stop the recording of the  current subject  in the  Room<I> RoomName</I>. The recording of this  Room will go on, but every thing will eather be stored with the passed in <I>thread_id</I> (to append the discussion of an old subject) in this case <I>New_Thread_name</I> and <I>explaination_of_Thread_Name</I> will NOT overwrite the old values, or with a internaly new created <I>thread_id</I> if none is passed in. In the second case  <I>New_Thread_name</I> and <I> explaination_of_Thread_Name </I> will be written into the db. (See  SQL doc,check table jb_conference_room_threads for details).
This function returns <b>-1</b> on an error and <b>0</b> otherwise.
</p>
 

<br>
<br>
<br>
<hr>

<a name="jb_append_subject" >
<H3>jb_new_subject</H3>
<H4>Overview</H4>
<p> Sending a old subject (Topic) to a  Room at the Jabber Server Conference service to append the recordings of this subject, incase the Room is not active it will be restarted automatically.  
 </P>
<H4>Syntax</H4>
<P><i>int</i> <B>jb_new_subject</B> <I>RoomName  New_Thread_name  explaination_of_Thread_Name   existing_thread_id </I>  </P>
<H4>Description</H4>
<P><B>jb_new_subject</B>
This function takes   a  <I>RoomName </I>  <I>New_Thread_name</I> <I>explaination_of_Thread_Name</I> and  an  existing <I>thread_id</I> as parameter, a call to this function  will stop the recording of the  current subject  in the  Room<I> RoomName</I>. The recording of this  Room will go on, but every thing will eather be stored with the passed in <I>thread_id</I> (to append the discussion of an old subject) in this case <I>New_Thread_name</I> and <I>explaination_of_Thread_Name</I> will NOT overwrite the old values, in case the Room is not active at the moment it will be restated.
This function returns <b>-1</b> on an error and <b>0</b> otherwise.
</p>
 

<br>
<br>
<br>
<hr>


<a name="jb_activeconferencerooms" >
<H3>jb_activeconferencerooms</H3>
<H4>Overview</H4>
<p> Returns a ns_set with all Conference Rooms that get  recorded at the moment.    
 </P>
<H4>Syntax</H4>
<P><i>ns_set id</i> <B>jb_delconferenceroom</B>   </P>
<H4>Description</H4>
<P><B>jb_activeconferencerooms</B>
This function is called with no parameters , it returns a ns_set . This ns_set has the names of the active Rooms as its keys , and ns_set's as  values. The ns_set's store more detailed information about the room .<br> Example:
<p>
 set active_rooms [jb_activeconferencerooms]
</p>
<p> 
if {$active_rooms != -1} { 
 
    set room_count [ns_set size $active_rooms]  }
  </P>
 <p>set html "&lt;TABLE&gt; &lt;tr&gt; &lt;th&gt; Room Name &lt;/th&gt; &lt;th&gt; Current Topic &lt;/th&gt;&lt;/tr&gt;"</p>
<p>
for {set i 0} {i < $row_count} {incr i}{
</p>
<p>
  append html "<prev>&lt;tr&gt;&lt;td&gt;[ns_set key $active_rooms $i] &lt;/td&gt;&lt;td&gt;[ns_set value [ns_set value  $active_rooms $i ] 1]&lt;/td&gt;&lt;/tr&gt;</prev>"
</p>
}

<p>append html "&lt;/table&gt;"</p>

<p>
This example calls jb_activeconferencerooms and stores the ns_set ID  in the variable active_rooms, it checks if the function hasent returned <b>-1</b> (no error). Then it reads the size of the ns_set into the variable row_count . Then in a for loop , it loops through the returned ns_set putting it's keys in the first column of the table , and in the second column it first reads the ns_set ID from the keys (roomNames) value pair , and then from this ns_set it reads the value from position 1 (wich holds the topic of this room). 
</p>
<p>
Structur of the  ns_set returned by jb_activeconferencerooms    
<table border="1"><tr><th>Key</th><th>Value</th></tr><tr><td>Room A</td><td>ns_set_id    A</td></tr><tr><td> Room B</td><td>ns_set_id B</td></tr></Table> 

</p>
<p>
Structure of the ns_set from a value of a returned ns_set:
<table border="1" ><tr><th> Key </th> <th> Value </th><th>Position</th> </tr>  
  <tr><td> name</td><td> Room Name</td><td>0</td></tr>
  <tr><td> subject</td><td> Current Topic </td><td>1</td></tr>
  <tr><td> roomid</td><td> Room Id which identifies the Room in the db.  </td><td>2</td></tr>
  <tr><td> threadid</td><td> Thread Id which identifies the current Topic in the db  </td><td>3</td></tr>
</table>

</p>
 
</p>
<br>
<br>
<br>
<hr>


<a name="jb_activeroommembers" >
<H3>jb_activeroommembers</H3>
<H4>Overview</H4>
<p> Returns a ns_set with all Members from a Conference Room that gets  recorded at the moment.    
 </P>
<H4>Syntax</H4>
<P><i>ns_set id</i> <B>jb_activeroommembers</B> <I>RoomName</i>  </P>
<H4>Description</H4>
<P><B>jb_activroommembers</B>
This function is called with a <I>RoomName</I> as parameter, it returns a ns_set . This ns_set has the current nicks (nick inside a Room) of the Members who are inside this  Room as its keys , and ns_set's as  values. The ns_set's store more detailed information about the Member .<br> 
<p>
Structur of the  ns_set returned by jb_activeroommembers:    
<table border="1"><tr><th>Key</th><th>Value</th></tr><tr><td>NickName1 </td><td>ns_set_id 1</td></tr><tr><td> NickName2</td><td>ns_set_id 2</td></tr></Table> 

</p>
<p>
Structure of the ns_set from a value of a returned ns_set:
<table border="1" ><tr><th> Key </th> <th> Value </th><th>Position</th> </tr>  
  <tr><td> nick</td><td> AnyNickName</td><td>0</td></tr>
  <tr><td> jid</td><td>The jid of this Member </td><td>1</td></tr>
  <tr><td> status</td><td>The status of this Member (online,away,etc.)</td><td>2</td></tr>
  <tr><td>user_id</td><td>The acs user_id. (if available)</td><td>3</td></tr>
</table>

</p>
 
</p>
<br>
<br>
<br>
<hr>

<a name="jb_invite" >
<H3>jb_invite</H3>
<H4>Overview</H4>
<p> Sends a Invite to a Conference Room , to a user.
 </P>
<H4>Syntax</H4>
<P><i>int</i> <B>jb_invite</B> <I>Jid</i> <I>RoomName</I> <I> Topic </i> <I>A_short_message</i> <I> Type </I> 
 </P>
<H4>Description</H4>
<P><B>jb_invite</B>
This function is called with 
a <i> Jid</i> to send the invite to,  the <I>RoomName</i> to which the recipient should be invited to, the <I>Topic</I> that will be discused in the room, a  <I>A short message</I> that lets the recipient know why he got invited , and the <I>Type</i> of the invite. The type can be 1 or 2 , standing for the versions v.1 and v.2. Right know v.1 is the preferred way to invite some one to a Conference Room, most Jabber Clients support this version , the Room <I>RoomName</I> doesn't needs to be recorded to send an invite to this Room. While v.2 is more power full but not all Jabber Clients support this version jet, the Room <i>RoomName</I> has to be recorded to send an invite to this Room.
 
</p>
<br>
<br>
<br>
<hr>

<a name="jb_new_subject" >
<H3>jb_new_subject</H3>
<H4>Overview</H4>
<p> Sends a new subject (Topic) to a Conference Room .
 </P>
<H4>Syntax</H4>
<P><i>int</i> <B>jb_new_subject</B> <I>RoomName</I> <I> TopicName </i> <I>Description_of_the_new_Topic</I> 
 </P>
<H4>Description</H4>
<P><B>jb_new_subject</B>
This function is called with 
a <i> RoomName</i> to send the subject change to,  the <I>TopicName</i> to change to and a <I>Description</I> of the new topic. This function worcks only on Rooms that get recorded at the moment.
</p>
<br>
<br>
<br>



<p>Back to <a href="design"> design page </a></p>
<hr>
Author:
<a href=mailto:bkiesbye@sussdorff-roy.com>Bjoern Kiesbye</a>
</p>
<p>Last modified: January 10 2003</p>
<Table border="3" aligen="center" width="100%" >
<TR><TD><P align=center> Copyright Sussdorff & Roy  2001 </P></TD></TR>
</TABLE>
