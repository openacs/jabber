<master>
<property name=title>Select a user</property>

<if @row_check_p@ eq 1>
<h2>Please select a user to @action@ buddies</h2>


<table>
 <tr>
  <th>First Name</th>
  <th>Last Name</th>
 </tr>
 <multiple name="get_users">
 <tr>
  <td>@get_users.first_names@</td>
  <td>@get_users.last_name@</td>
  <td><a href="view-users-roster?user_id=@get_users.person_id@&action=@action@">Select</a></td>
 </tr>
 </multiple>
</table>
</if>
<else>
<h2>Sorry, there are no jabber-users</h2>
</else>

<hr>

<p>Back to <a href="index">admin-page</a></p>