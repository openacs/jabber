<master>
<property name ="title">Jabber Admin Conference Groups</property>
<property name="context">Conference</property>

<if @show_blocked@ eq true>
<ul>
<multiple name=blocked_groups>
<LI>@blocked_groups.group_name@ <a href="block-group-2?group_id=@blocked_groups.group_id@&type=unblock">Unblock</a></LI>
</multiple>
</UL>
<p><a href="block-group?show_blocked=false">Hide this List</a></p>
</if>
<if @show_blocked@ eq false>
<p><a href="block-group?show_blocked=true">Showe List of blocked Groups</a></p>
</if>

<p>Enter a search prefix to find the Group to Block.</br>
 (Blocking a Group will implicitly remove this Group from the  Conference System, <br>this Group can't be added again as long as the Group is blocked)</p>
<p><formtemplate id="search"></formtemplate></p>


<a name="result">
<if @searched_rows@ eq true>
<ul>
<multiple name=searched_groups>
<LI>@searched_groups.group_name@ <a href="block-group-2.tcl?group_id=@searched_groups.group_id@&type=block">Block</a></LI>
</multiple>
</UL>
</IF>