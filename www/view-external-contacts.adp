<master>

<property name="title">View Your External Contacts</property>
<property name="context">@context@</property>

<h1>Your External Contacts</h1>

<if @row_check_p@ eq 1>

<table>
  <tr>
   <td>First Names</td>
   <td>Last Name</td>
   <td>Edit </td>
   <td>Remove ?</td>
  </tr>

 <multiple name="get_external_friends">
  <tr>
   <td>@get_external_friends.friend_first_name@</td>
   <td>@get_external_friends.friend_last_name@</td>
   <td><a href="edit-external-contact.tcl?friend_first_name=@get_external_friends.friend_first_name@&friend_last_name=@get_external_friends.friend_last_name@">Edit</a></td>
   <td><a href="remove-external-contact.tcl?friend_first_name=@get_external_friends.friend_first_name@&friend_last_name=@get_external_friends.friend_last_name@&screen_id=@get_external_friends.friend_screen_id@">Remove?</a></td>
  </tr>
 </multiple>
</table>

</if>
<else>
 <p> You don't have any external contacts!</p>
</else>

<hr>

<a href="index.tcl">Back to index page</a>
