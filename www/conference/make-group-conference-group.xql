<?xml version="1.0"?>
<queryset>

<fullquery name="check_if_group_is_blocked">      
      <querytext>
      SELECT (jgbc.group_id) as test_group_id FROM jb_groups_blocked_conference jgbc WHERE group_id =:group_id  
      </querytext>
</fullquery>

 
<fullquery name="check_group_for_existence_at_conference">      
      <querytext>
      SELECT group_id  FROM jb_conference_groups WHERE group_id = :group_id
      </querytext>
</fullquery>

 
<fullquery name="enabling_group_for_conferencing">      
      <querytext>
      INSERT INTO jb_conference_groups (group_id , conference_only_p ) values (:group_id , 'f')
      </querytext>
</fullquery>

 
<fullquery name="get_jabber_user_screen">      
      <querytext>
      SELECT im_screen_name , status FROM jb_screens WHERE user_id = :user_id AND service = 'jabber'
      </querytext>
</fullquery>

<fullquery name="insert_new_room_as_default">      
      <querytext>
DECLARE 
   v_room_id integer;
   begin 
   SELECT room_id INTO v_room_id 
   FROM jb_conference_rooms 
   WHERE lower(name) = lower(:room_name);
                
   UPDATE jb_conference_groups 
   SET default_room_id = v_room_id
   WHERE group_id = :group_id;
   END;
      </querytext>
</fullquery>

 
</queryset>
