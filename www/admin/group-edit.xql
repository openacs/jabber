<?xml version="1.0"?>
<queryset>

<fullquery name="get_users_from_prefix">      
      <querytext>
      SELECT person_id , first_names , last_name FROM persons p WHERE lower(p.last_name) like(lower('$user_prefix%'))
      </querytext>
</fullquery>

 
<fullquery name="get_groups_from_prefix">      
      <querytext>
SELECT (group_id) as cur_group_id , (group_name) as cur_group_name
FROM groups g WHERE lower(g.group_name)   like(lower('$group_prefix%'))
      </querytext>
</fullquery>

 
<fullquery name="get_users_from_this_group">      
      <querytext>
      SELECT  (p.last_name) as last_name , (p.first_names) as first_names , (gmm.rel_id) as rel_id , (mr.member_state) as member_state
                                      FROM persons p, group_member_map gmm, membership_rels mr 
                                      WHERE gmm.group_id = :group_id
                                      AND gmm.group_id = gmm.container_id
                                      AND gmm.member_id = p.person_id
                                      AND mr.rel_id = gmm.rel_id
      </querytext>
</fullquery>

 
<fullquery name="get_groups_from_this_group">      
      <querytext>
	SELECT  (g.group_name) as name,  (gcm.rel_id) as rel_id
                                      FROM groups g , group_component_map gcm
                                      WHERE gcm.group_id = :group_id
                                      AND gcm.component_id  = g.group_id

      </querytext>
</fullquery>

 
</queryset>
