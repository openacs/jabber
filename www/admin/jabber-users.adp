<master>
<property name=title>Jabber - Jabber Users</property>

<if @row_check_p@ not eq 0>

<H1>Jabber Users:</H1><hr><a href='jabber-users.tcl'>[refresh]</a>

<table>
   <tr> 
	<th>UserID</th> 
	<th>JabberID</th> 
	<th>Password</th> 
	<th>Status</th>
	<th>Action</th>
	<th>View user's roster</th> 
   </tr>
 <multiple name=get_users>
   <tr> 
	<td>@get_users.user_id@</td> 
	<td>@get_users.screen_name@</td> 
	<td>@get_users.pass@</td> 
	<td>@get_users.regstate@</td>
	<if @get_users.regstate@ eq a>
	<td><a href="register2.tcl?user_id=@get_users.user_id@&user=@get_users.screen_name@">Register</a></td>
	</if>
	<else>
	 <if @get_users.regstate@ eq s>
	  <td><a href="register2.tcl?user_id=@get_users.user_id@&user=@get_users.screen_name@">Approve and Register</a></td>
	 </if>
	 <else>
	  <td><a href="remove.tcl?user_id=@get_users.user_id@&user=@get_users.screen_name@">Remove user</a></td>
	 </else>
	</else>
	<td><a href="view-users-roster?user_id=@get_users.user_id@&action=view">View buddies</a></td>
   </tr>
 </multiple>
</if>
<else>
<table> 
	<H2>Jabber Users:</H2><hr>
	<H4>Actually there are no users registered!</H4>
</else>
</table>
<a href='jabber-users.tcl'>[refresh]</a>
<br>
<br>
<hr>
<h4>Back to <a href='index'>admin-page</a>.</h4>

