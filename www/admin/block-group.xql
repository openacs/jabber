<?xml version="1.0"?>
<queryset>

<fullquery name="get_blocked_groups">      
      <querytext>
      SELECT (g.group_name) as group_name , (g.group_id) group_id FROM jb_groups_blocked_conference jgbc , groups g WHERE jgbc.group_id = g.group_id
      </querytext>
</fullquery>

 
<fullquery name="get_group_from_prefix">      
      <querytext>
      SELECT (group_id) as cur_group_id , (group_name) as cur_group_name FROM groups g WHERE lower(g.group_name) like(lower('$group_prefix%'))
      </querytext>
</fullquery>

 
</queryset>
