<master src="doc-master">
<property name=title>Jabber Design</property>


<hr>

<center>
<a href="requirements">Back: Requirements</a>
</center>

<h2>Jabber Design</h2><a name="begin">


<p>This document explains brief the design of the Jabber Module, its
existing table and what's the purpose of each table. Furthermore you get an view over the defined procedures.
<br>
You have to know that not only the tcl-files define transactions to the database, but also
the C-modules. This non convenient procedure is due to velocity advantages, which are provided
by an direct access to the database by the C-modules.</p>

<p>Please read the introduction page first, so you can get an general overview:
<br><a href="introduction">Introduction</a>
<br>
<br>
</p>

<a href="#overview">1. Overview</a>
<br>
<a href="#table">2. Tables</a>
<br>
<a href="#api">3. API - Procedures</a>


<B><FONT SIZE=4><P><a name="overview"></a>1. Overview</P>
</B></FONT><P>The Jabber module for OpenACS can track any entity presence state (i.e. online or offline) from most of the Big Instant Messaging Systems (AIM , MSN , Yahoo , ICQ and Jabber). It is able to interact with your local Jabber Server and it can record Chats hosted by the Conference Component of your local Jabber Server. </P>



<P><b>The tracking of presence :</b></P>
<P>The Aolserver logs into your precreated account at your local Jabber Server , it acts like a usual Jabber Client so it can connect it self to any IM System your Jabber Server is able to connect to. When a user enters a name from an entity from any supported IM System (say name: Fred123 IM System: AIM ), this information is inserted into the  table jb_screens (Oacs) and into the account information (in jabber terms roster) (the account the Aolserver uses )  at your local Jabber Server.</P>
<P>Once this information is in the Aolservers accounts roster , the Jabber Server will push any presence state changes ,from this entity , to the Aolserver. Who then writes the new state into the state column of the jb_screens table where the screen column has the value Fred123 and the  service column has the value AIM. The table jb_screens holds all information about a entity , the screen(name) the service the screen belongs to , the current online state (and possibly a away message and a resource). If any application has an interest in the online state of any entity (like the IM Addressbook) this application has to reefer to the jb_screens table .In the www/image subdirectory their are several icons  for displaying different online states and IM Systems . In the jabber-procs.tcl library file their are some functions that return a colour for a passed in online state (it would be help full for users if the different states are display system wide in the same colour ).</P>
<P>As well you are able to send IM Messages to any entity of any IM System your Jabber Server supports, but you cant receive any Messages. For end users it can be used like a SMS web interfaces , the OpenACS could use it in its alert system. You find all pages related to the tracking of presence in the www/jabber directory.</P>

<P><b>The recording of Chats:</b></P>
<P>The Aolserver can enter any Conference Room from the Conference Module of your local Jabber Server,  so it is able to receive any Messages send to a Conference Room once it is asked to record this Conference Room. The Conferences are stored in three tables jb_conference_protocols , this table holds any Message from any Conference Room , in addition to the Message text any line reefers to the table jb_conference_rooms ,via the room_id  (which holds the room name the  description of what discussions this room is for etc. ),  the table jb_conference_thraeds ,via the thread_id (which holds the name of the currently discussed topic), and the users table via the user_id (the user_id is figured out with the help of the jid, the possibility to query the conference module for the real jids of conference members isnt a standard so make sure you use the version that comes with the package). You find all tcl/adp pages used for conferencing in the www/jabber/conferencing subdirectory. Later access is done by relations , the jb_conferens_room is defined as an Object (acs 4.x) so a room can (has to) be related to a Group (Groups for conferencing can be created and administrated in the admin section of the jabber module www/jabber/admin/conferencing). On the Conference index page a list of all Groups the user is a member of are displayed, which link them to an overview of all Room including all Topics that belong to this Group which themselves link the user to read a Topic  enter an currently active Room or to Restart an inactive Room. On the index page their is an overview with all new Topics (since last visit) displayed. </P>




<h2>2. Tables</h2><a name="table"></a>

<b>jb_services</b>

<p>Due to the fact that not all IM-services are avaiable for Jabber and that
new services could come in the future, this table stores those IM-services, 
which are avaiable and enabled. In the future the admin can deactivate a certain
IM-service or add new ones.
</p>

<b>jb_screens</b>

<p>This table stores all relevant information of every contact or
buddy, whether they are members in the OACS and registered users of
the Jabber server or they are non members of the OACS and are external
contacts. To offer the possibility of permissioning for each user
jb_screens is implemented as an object inheriting the features of an
object. A unique screen_id referencing an object_id is used as index
for this table. Furthermore for users within the OACS the user_id is
stored, so it is possible to find out whether this buddy is an
internal or external buddy. Moreover the Screen Name
(im_screen_name), the service (aim, icq, msn, yahoo, jabber or irc)
and the actual online status is stored. The im_screen_name in
combination with the service have to be unique due to the fact that
the Im-Services do not allow identical Screen names.</p>

<b>jb_conference_rooms</b>

<p>This table stores all relevant information of every existing
conference room. It is aswell implemented as object, so 
the permissioning system and the auditing attributes of an object
can be inherited. A room_id referencing an object_id is used as index,
furthermore a name and description for each room has to be stored.
Due to the fact that only registered users of the Jabber server can
create a conference room the creator_jabber_id is archived, so the
creator is not only referenced by his user_id (inherited
attribute).</p>

<b>jb_conference_room_threads</b>

<p>Each conreference_room can have different threads with different
topics, so this table stores information for every thread, archiving
the room_id, so you can reference every thread with his
conference_room. A thread_id is used as index of this table. The
threads are not implemented as object, because there is no need to
inherit the features of an object like the permissioning system. This
is accomplished by the permissioning of the conference room. As
consequence this table has to store auditing information for
itself. Furthermore a name and brief description of this thread is
stored aswell.</p>

<b>jb_conference_room_protocols</b>

<p>This table stores the transcripts for each room and thread, so
later users can take a look on the transcripts. The permissioning
system of the conference_room is used to allow the view on the
protocols.</p>

<b>jb_message_log</b>

<p>This table stores every message written and send through the
jabber-server. Moerover auditing information is archived to
relationate a message with a screen_id.</p>

<b>jb_friends</b>

<p>This table stores the buddy list for each user within the OACS and
Jabber server. The screen_id, first_names and last_name of the contact
ist stored. Through the information in jb_screens it can be figured
out qhether the contact is member of the OACS or not (user_id not null
in jb_screens). If the friend is user of the OACS, the first and last
names are taken out from persons, if not, the user is given a GUI to
write the first and last names.</p>

<b>jb_user_jabber_information</b>

<p>For registered users of the OACS this table stores login
information like password, registry status and a boolean
auto-login. There are several different registry status, "r" stands
for registered, "a" for approved.</p>

<b>jb_subscription_request</b>

<p>This table stores a jabber_id (includes information over which IM-service 
is used), which need approval by the user you want to add to your buddy list, 
for example in icq with authorize. The Jabber server checks whether an 
approval arrives and then this screen is added to jb_screens.</p>

<b>jb_xml_to_send</b>

<p>This table stores every xml-send-information, which could not been send
because of problems with the Jabber server, for example when the Jabber server
is down. On every restart of the Jabber server the server checks this table and
send the archived messages to its destination.</p> 


<b>jb_room_start_from_thread</b>

<table><tr><td><tt><pre>
create  table jb_room_start_from_thread (
        thread_id     not null references jb_conference_room_threads(thread_id),
        room_id       not null references jb_conference_rooms(room_id),
        primary key(thread_id , room_id)
                                          );
</pre></td></tr></table>
</div>
<p> Maps Rooms to the threads where the dicussion started, for storing the structure of a discussion on an major topic.The structure is manly used for later displaye. The time stamp orders the Rooms in x-direction, this table orders the Rooms in y-direction 
</p>



<b>jb_room_party_map</b>
<table><tr><td><tt><pre>
create table jb_room_party_map (
                                party_id      not null references parties(party_id),
                                room_id       not null references  jb_conference_rooms(room_id),
                                primary key (party_id , room_id) 
	                       );
</pre></td></tr></table>
<p>
This Table Maps a Room to a Party ( user/group),it difines who has access to a Room. Yet there are no permisions (other then access/noaccess a group maps to a Room or not ) definde for the objects acs_party and jb_conference_room. When  relations for this objects are intrduced, this table becomes an index for fast access, that is kept up to date via trigers (like it's done for the the acs_groups system) 
</p>


<b>jb_conference_groups</b>
<table><tr><td><tt><pre>
create table jb_conference_groups (
                                  group_id primary key references groups(group_id)
                                  );  
</pre></td></tr></table>
<p>
This Table Stores the group_id's ,of the groups, which have access to the conference system.
</p>



<h2>3. API - Procedures</h2><a name="api"></a>

<a href="#begin">Up</a>

<p>Some procedures are defined in the tcl-library file named jabber-procs. You can find
this file in the /tcl directory of your jabber-server package. The C-modules define procedure
aswell, which are not only used within the C-modules, but also in the tcl-files. To see the documentation
for several procedures defined in th nsjabber-module follow this link: <a href="ns-jabber-documentation">ns-jabber procedure 
documentation</a></p>

<p>The nsjabber-module accesses the database, but due to the fact that the c-modules should not be used in connection with
a certain datamodel, we define PL/SQL procedures and functions, which will be called by the c-modules. So we can debug and administer
the c-modules independently from the datamodel. If changes occur in the datamodel we only have to change the PL/SQL procedures and 
functions. This implementation symplifies the maintenance of the system. To see the documentation for the PL/SQL procedures
and functions follow this link: <a href="pl-sql-documentation">PL/SQL procedure documentation</a></p>  


<center>
<a href="requirements">Back: Requirements</a>
</center>

<br>
<hr>
<p>Author:  
<a href=mailto:lmosteiro@sussdorff-roy.com>Luis Mosteiro Fernandez</a>
</p>
<hr>
<p>
Modified
<a href=mailto:bkiesbye@sussdorff-roy.com>Bjoern Kiesbye</a><br>Added the Overview , and new Table descriptions.
</p>
<p>Last modified: January 10 2003</p>
<Table border="3" aligen="center" width="100%" >
<TR><TD><P align=center> Copyright Sussdorff & Roy  2001 </P></TD></TR>
</TABLE>

