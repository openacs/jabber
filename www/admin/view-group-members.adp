<master>
<property name="title">View Group Members</property>


<h2>These are the members of the selected group and registered users in our Jabber server without users, who are in your buddy list already!</h2>


<if @member_row_check_p@ eq 1>
<p>Please select the user's you want to add</p>

<formtemplate id="group_members"></formtemplate>
</if>
<else>
<p>You already have all users of these group on your buddy list!</p>
</else>