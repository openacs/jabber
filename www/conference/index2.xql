<?xml version="1.0"?>
<queryset>

<fullquery name="get_last_visit">      
      <querytext>
      select last_visit FROM users WHERE user_id = :user_id
      </querytext>
</fullquery>

 
<fullquery name="get_last_visit_2">      
      <querytext>
select (last_visit - 1000) as last_visit FROM users WHERE user_id = :user_id
      </querytext>
</fullquery>

 
<fullquery name="get_conference_group_rooms">      
      <querytext>
      SELECT (jrpm.party_id) as party_id , (jrpm.room_id) as room_id , (jcr.name) room_name 
                                       FROM group_distinct_member_map gdmm , jb_room_party_map jrpm , jb_conference_rooms jcr  
                                       WHERE gdmm.member_id = :user_id 
                                       AND gdmm.group_id = jrpm.party_id 
                                       AND jcr.room_id = jrpm.room_id
                                       ORDER BY jcr.name
      </querytext>
</fullquery>

 
<fullquery name="get_new_conference_threads">      
      <querytext>
      SELECT thread_id , subject , start_time 
                                                  FROM jb_conference_room_threads 
                                                  WHERE room_id = :room_id 
                                                  
      </querytext>
</fullquery>

 
</queryset>
