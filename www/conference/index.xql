<?xml version="1.0"?>
<queryset>

<fullquery name="get_last_visit">      
      <querytext>
      select last_visit FROM users WHERE user_id = :user_id
      </querytext>
</fullquery>

 
<fullquery name="groups_of_this_user">      
      <querytext>
      SELECT (gp.group_name) as group_name , (gp.group_id) as group_id 
                                 FROM  group_distinct_member_map gdmm , groups gp , jb_conference_groups jcg 
                                 WHERE gdmm.member_id = :user_id
                                 AND gdmm.group_id =  jcg.group_id 
                                 AND gdmm.group_id = gp.group_id
</querytext>
</fullquery>
 
<fullquery name="get_conference_group_rooms">      
      <querytext>
      SELECT (jrpm.party_id) as party_id , (jrpm.room_id) as room_id , (jcr.name) as room_name 
                                       FROM 
                                         group_distinct_member_map gdmm , 
                                         jb_room_party_map jrpm , 
                                         jb_conference_rooms jcr , 
                                         jb_conference_groups jcg  
                                       WHERE gdmm.member_id = :user_id 
                                       AND gdmm.group_id = jcg.group_id
                                       AND gdmm.group_id = jrpm.party_id 
                                       AND jcr.room_id = jrpm.room_id
                                       ORDER BY gdmm.group_id
      </querytext>
</fullquery>

 
<fullquery name="get_new_conference_threads">      
      <querytext>
      SELECT thread_id , subject , start_time  
      FROM jb_conference_room_threads 
      WHERE room_id = :room_id 
      AND start_time > to_date(:last_visit , 'YYYY-MM-DD')
      </querytext>
</fullquery>

 
</queryset>
