<master>
<property name=title>JABBER CONFERENCE ADMIN </property>

<div><formtemplate id="create"></formtemplate>
<formtemplate id="find"></formtemplate></div>



<hr/>
<a href="block-group">Manage Blocking of Groups</a>
<hr/>
<b>Add or Remove Users or Groups to/from a Conference Group</b>
<if @groups_exist@ eq true>
<UL>
<multiple name=groups>
<LI><a href='group-edit.tcl?group_id=@groups.group_id@&group_name=@groups.group_name@'>@groups.group_name@</a></LI>
</multiple>
<UL>
</if>

<if @groups_exist@ eq false>
<p>There are no Groups!! You have to create a Group before you can add Users to a Group</p>
</if>