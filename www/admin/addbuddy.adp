<master>
<property name=title>Add buddy to user's roster</property>

<h2>Here you can add buddies to the user's roster</h2>

<if @row_check_p@ eq 1>

<p>This is a list of jabber users, who are registered in our internal Jabber Server. You can add those to the user's specific roster only.</p>

<table>
 <tr>
  <th>First Names</th>
  <th>Last Name</th>
  <th>Screen name</th>
  <th>Action</th>
 </tr>
 <multiple name="internal_users">
 <tr>
  <td>@internal_users.first_names@</td>
  <td>@internal_users.last_name@</td>
  <td>@internal_users.im_screen_name@</td>
  <td><a href="addbuddy2?user_id=@user_id@&screen_name=@internal_users.im_screen_name@">Add</a></td>
 </tr>
 </multiple>
</table>



<br>
<br>
<a href="view-communities?user_id=@user_id@">Add members of a community</a>

</if>
<else>
 <p>There are no other users registert than the user you have chosen, so you cannot add anyone.</p>
</else>

<hr>
<p>Back to <a href="index">admin-page</a></p>
