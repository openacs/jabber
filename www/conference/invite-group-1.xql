<?xml version="1.0"?>
<queryset>

<fullquery name="get_users_from_group">      
      <querytext>
      SELECT (pe.first_names) as first_name , (pe.last_name) as last_name , (js.im_screen_name) as screen , (js.status) as status 
                                       FROM group_distinct_member_map gdmm , jb_screens js, persons pe  
                                       WHERE gdmm.member_id = js.user_id
                                       AND gdmm.member_id = pe.person_id 
                                       AND js.service = 'jabber'
                                       AND js.status != 'offline'
                                       AND gdmm.group_id = :group_id 
                                       ORDER BY last_name
      </querytext>
</fullquery>

 
</queryset>
