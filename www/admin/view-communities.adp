<master>
<property name="title">View User's Communities</property>


<h2>This are the groups and communities this user is member of</h2>

<if @groups_row_check_p@ eq 1>

<p>Following is a list of groups:</p>

<ul>
 <multiple name="get_groups">
  <li><a href="view-group-members?group_id=@get_groups.group_id@&user_id=@user_id@">@get_groups.group_name@</a></li>
 </multiple>
</ul>

</if>
<else>
 <h4>The user is not member of any group!</h4>
</else>

<br>

<if @dotlrn_row_check_p@ eq 1>

<p>Following is a list of dotlrn communities:</p>

<table>
 <tr>
  <th>Community Type</th>
  <th>Community Name</th>
  <th>View members</th>
 </tr>
 <multiple name="get_dotlrn_communities">
 <tr>
  <td>@get_dotlrn_communities.community_type@</td>
  <td>@get_dotlrn_communities.pretty_name@</td>
  <td><a href="view-community-members?community_id=@get_dotlrn_communities.community_id@&user_id=@user_id@">View</a></td>
 </tr>
 </multiple>
</table>

</if>
<else>
 <h4>The user is not member of a dotlrn community!</h4>
</else>