<master>
<property name=title>JABBER CONFERENCE GROUP EDIT</property>
          
<if @list_members@ eq true>
<div align=left>
<p>All members of this Group</p>

<TABLE border=2 >
<tr><th align=left>Name</th><th align=left>State</th><th align=left>Action</th></tr>
<multiple name=users_list>
<tr><td>@users_list.name@</td><td>@users_list.member_state@</td><td><a href='user-state-change.tcl?group_id=@group_id@&group_name=@group_name@&list_members=@list_members@&rel_id=@users_list.rel_id@&new_state=deleted'>delete</a></td></tr>
</multiple>
</TABLE>
</div>
<div align=left>
<p>All Groups of this Conference Group</p>
<table border=1>
<tr><th align=left>Name</th><th align=left>Action</th></tr>
<multiple name=groups_list>
<tr>
<td>@groups_list.name@</td>

<td><a href='group-state-change.tcl?group_id=@group_id@&list_members=@list_members@&rel_id=@groups_list.rel_id@&group_name=@group_name@'>remove</a></td>

</tr>
</multiple>
</table>
</div>
<p><a href='group-edit.tcl?group_id=@group_id@&group_name=@group_name@&list_members=false'> Don't show this list </a> </p>
</if>

<if @list_members@  eq false>
<p><a href='group-edit.tcl?group_id=@group_id@&group_name=@group_name@&list_members=true'> Show a list of all Members </a> </p>
</if>


Here you can search for Users or Groups to add them to the  Conference group <b>@group_name@</b> !
<table>
<tr><td align=left>
<p>Search for <b>Users</b> who's Last Name starts with: </p>
<p><formtemplate id="user_search"></formtemplate></p>
</td>

<td align=right>
<p> Search for <b>Groups</b> who's  Name starts with</p>
<p><formtemplate id="group_search"></formtemplate></p>
</td>
</tr>
</table>

<a name='result'></a>

<if @multi@ eq users>
<p>You can add this @multi@ to the Conference group @group_name@</p>
<UL>
<multiple name=partys>
 <LI><a href='add-user.tcl?group_id=@group_id@&user_id=@partys.party_id@&group_name=@group_name@&list_members=@list_members@'>@partys.name@</a></LI>
</multiple>
</UL>
</if>


<if @multi@ eq groups>
<p>You can add this @multi@ to the Conference group @group_name@</p>
<UL>
<multiple name=partys>
 <LI><a href='add-group.tcl?group_id=@group_id@&new_group_id=@partys.party_id@&group_name=@group_name@&list_members=@list_members@'>@partys.name@</a></LI>
</multiple>
</UL>
</if>