<master>
<property name ="title">Jabber Admin Confernce Groups</property>
<property name="context">1</property>
<p>
This Groups are able to be used with the Conference System ( Blocked Groups will not show up.
If you want to add a previously blocked Group you have to unblock this Group first).
</p> 
<if @searched_rows@ eq true>
<UL>
<multiple name=groups>
<LI>@groups.group_name@ <a href="new-group-2.tcl?group_id=@groups.group_id@">Add</a></LI>
</multiple>
<UL>
</if>

<if @searched_rows@ eq false>
<h3>No Group Name found that starts with "@group_name@"
</if>