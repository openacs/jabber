<master>
<property name="title">Search users</property>
<property name="context">@context@</property>

<h1>Search user</h1>

<p>Please note that you can only search users, who are registered in our Jabber server!</p>
 
<table>
<tr><td align=left>
<p>Search for <b>Users</b> who's First or Last Name starts with: </p>
<formtemplate id="search"></formtemplate>
</td>
</table>

<a name='result'></a>

<if @row_check_p@ eq 1>
<p>You can add these users to your buddy list</p>
<table>
 <tr>
  <th>First Name</th>
  <th>Last Name</th>
  <th>Action</th>
 </tr>
 <multiple name="partys">
 <tr>
  <td>@partys.first_names@</td>
  <td>@partys.last_name@</td>
  <td><a href="buddy-add?friend_id=@partys.person_id@&return_url=@return_url@">Add</a></td>
 </tr>
 </multiple>
</table>
</if>
<if @row_check_p@ eq -1>
<h2>Sorry, there are no Jabber users with this prefix, try again!</h2>
</if>



<br>
<br>
<br>
<p>Back to <a href="index">admin-page</a></p>
