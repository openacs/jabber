<master src="doc-master">
<property name=title>PL/SQL procedure documentation</property>

<h2>PL/SQL procedure documentation</h2>


<p>Following PL/SQL procedures and functions are invoked by the nsjabber-module. Please mind that some procedures are not useful for 
the datamodel of the OACS, specially those dealing with a conference room ID, because the conference room is implemented as an object so 
we cannot query the room ID, but this procedures have to be defined, because the nsjabber-module uses those procedures to be for 
general use.</p>

<br>
<br>

<table>
 <tr>
  <td>
   <h3>Procedure jb_reg_validation</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Validates whether user is in the database. If the user is in the database his regstate is changed.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_reg_validation</b>&nbsp <i>screen_in</i>&nbsp <i>regstate</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Screen_in is the Jabber screen name of the user, who should be validated, and regstate is the new regstate for this user.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_update_status</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Update user's online status.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_update_status</b>&nbsp <i>status_in &nbsp resourc_in &nbsp screen_in &nbsp service_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Status_in is the new online status<br>
      &nbsp&nbsp resourc_in is the resource of the user (whether he is at home or...)<br>
      &nbsp&nbsp screen_in is the screen name of the user<br>
      &nbsp&nbsp service_in is the IM service of the user</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_clear_status</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Puts every status and resource on offline when the Jabber server logs in or out.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_clear_status</b></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp When the Jabber server logs in or out every status and resource is put on offline.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Function jb_subscription_check</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Checks whether a certain Jabber ID is in our subscription table, which stores Jabber IDs, which need approval by the user.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_subscription_check</b>&nbsp <i>jid_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Returns 0 if Jabber ID is not in jb_subscription_request, otherwise returns number n of subscription requests for this Jabber ID.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp jid_in is the requested Jabber ID.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_subscription_insert</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Inserts a new subscription request into the database.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_subscription_insert</b>&nbsp <i>jid_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp jid_in is the Jabber ID, which should be inserted.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_subscription_del</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Removes a subscription from the database.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_subscription_del</b>&nbsp <i>jid_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp jid_in is the Jabber ID, which should be removed from the database.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Function jb_get_user_id</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Gets the user_id for a given Jabber screen name.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_get_user_id</b>&nbsp <i>screen_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Returns the user_id</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp screen_in is the Jabber screen name for which you want to get the user ID.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Function jb_get_jid</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Gets the Jabber ID for a given user ID.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_get_jid</b>&nbsp <i>user_id_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Returns the Jabber ID</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp user_id_in is the User ID for which you want to get the Jabber ID.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_conference_thread_finish</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Finishes a conference room thread.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_conference_thread_finish</b>&nbsp <i>thread_id_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp thread_id_in is the Conference Room Thread ID for the thread, which should be finished.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_conference_thread_new</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Creates a new thread for a certain Conference Room.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_conference_thread_new</b>&nbsp <i>thread_id_in &nbsp room_id_in &nbsp subject_in &nbsp creator_jid &nbsp creator_user_id</i> </p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp thread_id_in is the new Thread ID<br>
      &nbsp&nbsp room_id_in is the Room ID for which a new thread is created<br> 
      &nbsp&nbsp subject_in is the subject for this thread<br>
      &nbsp&nbsp creator_jid is the Jabber ID of the creator of this thread<br>
      &nbsp&nbsp creator_user_id is the User ID of the creator of this thread</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_conference_message</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Inserts a message in the database (jb_conference_protocols).</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_conference_message</b>&nbsp <i>jid_in &nbsp message_in &nbsp room_id_in &nbsp thread_id_in &nbsp user_id_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp jid_in is the Jabber ID of the user who has written the message<br> 
      &nbsp&nbsp message_in is the message<br>
      &nbsp&nbsp room_id_in is the Conference Room in which this message was written<br>
      &nbsp&nbsp thread_id_in is the Conference Room Thread in which this message was written<br>
      &nbsp&nbsp user_id_in is the User ID of the user who has written the message</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Function jb_conference_room_check</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Checks whether a Conference Room exists for a given room name.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_conference_room_check</b>&nbsp <i>room_name_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Returns a room ID on success, otherwise -1 is returned</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp room_name_in is the room name, which should be checked.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Procedure jb_conference_rooms_new</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Creates a new Conference Room.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_conference_rooms_new</b>&nbsp <i>room_id_in &nbsp user_id_in &nbsp creator_jid_in &nbsp name_in &nbsp description_in</i></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp No return</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp room_id_in is irrelevant for OACS datamodel, because we get the ID from acs_objects, but we have to give the procedure
   a room ID to not generate an error<br>
      &nbsp&nbsp user_id_in is the user ID of the creator<br>
      &nbsp&nbsp creator_jid_in is the Jabber ID of the creator<br>
      &nbsp&nbsp name_in is the name of the new Conference Room<br>
      &nbsp&nbsp description_in is the description of the new Conference Room<br>
      &nbsp&nbsp <br>
      &nbsp&nbsp This procedure invokes the jb_conference_room.new procedure to create a new conference room</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Function jb_conference_next_room_id</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Gets a room ID (irrelevant for OACS datamodel. Function returns an integer value so the nsjabber module doesn't 
   generates an error.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_conference_next_room_id</b></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Returns an integer value</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp This procedure doesn't get a room ID, it only returns an integer value. This ID is used to create a new Conference Room,<br>
      &nbsp&nbsp but as seen in the procedure jb_conference_rooms_new we don't use the room_id.</p>
  </td>
 </tr>
</table>
<br>
<br>
<br>
<table>
 <tr>
  <td>
   <h3>Function jb_conference_next_thread_id</h3>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Overview</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Gets a new Conference Room Thread ID.</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Syntax</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p><b>&nbsp&nbsp jb_conference_next_thread_id</b></p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Return</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Returns a thread ID</p>
  </td>
 </tr>
 <tr>
  <td>
   <h4>Description</h4>
  </td>
 </tr>
 <tr>
  <td>
   <p>&nbsp&nbsp Gets a new thread ID from the corresponding sequence.</p>
  </td>
 </tr>
</table>
<br>