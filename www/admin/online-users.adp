<master>
<property name=title>Jabber - Online Users</property>

<if @online_check_p@ eq 1>

<H1>Online Users:</H1><hr><a href='online-users.tcl'>[refresh]</a>

<table>
     <tr> 
	<th>JabberID</th> 
	<th>Resource</th> 
	<th>Status</th>
	<th>Service</th>
	<th>Start a Chat</th>
	<th>Add this user to my Roster</th>
     </tr>
     <multiple name=get_users>
     <tr>
	<td>@get_users.im_screen_name@</td> 
	<td>@get_users.resource@</td> 
	<td><FONT color='@get_users.statecolour@'>@get_users.status@</FONT></td>
	<td>@get_users.service@</td><td><a href='chatstart.tcl?user1=@caller@&user2=@get_users.im_screen_name@'><FONT color='@get_users.statecolour@'>@ltext@  @get_users.im_screen_name@</FONT></a></td>
	<td><a href='addbuddy2.tcl?user=@caller@&buddy1=@get_users.im_screen_name@&bcount=1'>add to my roster</a></a>
     </tr>
     </multiple>
</if>
<else>
	<H2>Online Users:</H2><hr> 
	<table> 
	<H4>There are no users online!</H4>
</else>
</table>
<a href='online-users.tcl'>[refresh]</a>
<br>
<br>
<hr>
<h4>Back to <a href='index'>admin-page</a>.</h4>

