<master>
<property name=title>View user's roster or buddy list</property>


<if @row_check_p@ not eq 0>


<p>Internal buddies</p>
<if @row_check_p@ not eq 2>
<table>
  <tr>
   <th>First Names</th>
   <th>Last Name</th>
   <th>Service</th>
  </tr>
  <multiple name="internal_buddies">
  <tr>
   <td>@internal_buddies.first_names@</td>
   <td>@internal_buddies.last_name@</td>
   <td>@internal_buddies.service@</td>
   <if @action@ eq remove>
    <td><a href="removebuddy?screen_id=@internal_buddies.screen_id@&user_id=@user_id@">Remove</td>
   </if>
  </tr>
  </multiple>
</table>
</if>
<else>
<p>Sorry, no internal buddies</p>
</else>

<p>External buddies</p>
<if @row_check_p@ not eq 1>
<table>
  <tr>
   <th>First Names</th>
   <th>Last Name</th>
   <th>Service</th>
  </tr>
  <multiple name="external_buddies">
  <tr>
   <td>@external_buddies.friend_first_name@</td>
   <td>@external_buddies.friend_last_name@</td>
   <td>@external_buddies.service@</td>
   <if @action@ eq remove>
    <td><a href="removebuddy?screen_id=@external_buddies.screen_id@&user_id=@user_id@">Remove</td>
   </if>
  </tr>
  </multiple>
</table>
</if>
<else>
<p>Sorry, no external buddies</p>
</else>
</if>
<else>
<h2>This user has no buddies in his roster</h2>
</else>

<if @action@ eq add>
  <br>
  <a href="addbuddy?user_id=@user_id@">Add buddies to this user</a>
</if>

<hr>
<p>Back to <a href="index">admin-page</a></p>
