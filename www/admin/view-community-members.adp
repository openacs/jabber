<master>
<property name="title">View Community Members</property>


<h2>These are the members of the selected dotlrn community.</h2>
<p>Please take under consideration that not all user's displayed are registered users in our Jabber server!</p> 

<form action="add-community-members">
<p>Select the user's you want to add.</p>
<p>
<input type="hidden" name="user_id" value="@user_id@>
<input type="hidden" name="rows" value="@users:rowcount@">
<multiple name="users">
 <if @users.user_id@ not eq @user_id@>
 <input type="checkbox" name="community_member.@users.rownum@" value="@users.user_id@" checked>@users.first_names@ &nbsp @users.last_name@ (@users.role@) <br>
</if>
</p>
<p>
 <input type="submit" value="Add">
</p>
</form>
