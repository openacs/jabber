<?xml version="1.0"?>
<queryset>

<fullquery name="remove_group_from_conferencing">      
      <querytext>
      DELETE FROM jb_conference_groups WHERE group_id = :group_id
      </querytext>
</fullquery>

 
<fullquery name="block_group_for_conferencing">      
      <querytext>
      INSERT INTO jb_groups_blocked_conference (group_id) values (:group_id)
      </querytext>
</fullquery>

 
<fullquery name="unblock_group_for_conferencing">      
      <querytext>
      DELETE FROM jb_groups_blocked_conference WHERE group_id = :group_id
      </querytext>
</fullquery>

 
</queryset>
