<?xml version="1.0"?>
<queryset>

<fullquery name="get_user_screen">      
      <querytext>
      Select im_screen_name FROM jb_screens WHERE user_id = :user_id AND service = 'jabber'
      </querytext>
</fullquery>

 
<fullquery name="get_rooms_from_group">      
      <querytext>
      SELECT  (jcr.name) as room_name 
                                       FROM jb_room_party_map jrpm , jb_conference_rooms jcr  
                                       WHERE jrpm.party_id = :group_id 
                                       AND jcr.room_id = jrpm.room_id
                                       ORDER BY jcr.name
      </querytext>
</fullquery>

 
</queryset>
