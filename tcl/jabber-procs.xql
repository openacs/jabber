<?xml version="1.0"?>
<queryset>

<fullquery name="jb_register_aprove.check_if_user_has_contacts">      
      <querytext>
      select (user_id) as dummy from jb_screens where user_id = :user_id
      </querytext>
</fullquery>

 
<fullquery name="jb_register_aprove.create_a_contacts_table_entry">      
      <querytext>
      insert into jb_user_jabber_information (user_id) values (:user_id)
      </querytext>
</fullquery>

 
<fullquery name="jb_register_aprove.does_screen_exist">      
      <querytext>
      select screen_id from jb_screens where im_screen_name = :jscreen and service = 'j'
      </querytext>
</fullquery>

 
<fullquery name="jb_register_aprove.register_with_user">      
      <querytext>
      update jb_user_jabber_information SET jabber_regstate = 'a' , jabber_passwd = :passwd where user_id = :user_id
      </querytext>
</fullquery>

 
<fullquery name="jb_subscribe_transport.does_screen_exist_2">      
      <querytext>
      select screen_id from jb_screens where lower(im_screen_name) = lower(:screen) and lower(service) = lower(:service)
      </querytext>
</fullquery>

 
<fullquery name="jb_subscribe_transport.update_ref_count">      
      <querytext>
      update jb_screens set refcount = refcount + 1 where screen_id = :screen_id
      </querytext>
</fullquery>

 
<fullquery name="jb_subscribe_transport.add_to_jb_screens">      
      <querytext>
      insert into jb_screens (screen_id , im_screen_name , service ,status , refcount ) values (acs_object_id_seq.nextval , lower(:screen) , lower(:service) , 'offline' , '1')
      </querytext>
</fullquery>

 
<fullquery name="jb_subscribe_transport.get_the_new_screen_id">      
      <querytext>
      select (screen_id) as new_screen_id from jb_screens where im_screen_name = lower(:screen)  and service = lower(:service)
      </querytext>
</fullquery>

 
<fullquery name="jb_best_chat.find_m_all">      
      <querytext>
      select (sn.im_screen_name) as screen, (sn.service) as service ,(sn.status) as status
                       FROM jb_screens sn  
                       WHERE sn.user_id = :user_id 
      </querytext>
</fullquery>

 
<fullquery name="jb_best_chat.find_m_all_friend">      
      <querytext>
      select (sn.im_screen_name) as screen, (sn.service) as service ,(sn.status) as status FROM jb_screens sn  
	WHERE sn.user_id = :user_id_friend 
      </querytext>
</fullquery>

 
<fullquery name="jb_get_aim_screen_from_friend_id.get_screen">      
      <querytext>
      SELECT (sn.im_screen_name) as screen FROM jb_screens sn  WHERE  sn.user_id = :user_id_friend  AND sn.service = 'aim' 
      </querytext>
</fullquery>

 
<fullquery name="jb_invite_user.get_user_jid">      
      <querytext>
      SELECT im_screen_name FROM jb_screens WHERE user_id = :user_id AND service = 'jabber'
      </querytext>
</fullquery>

 
<fullquery name="jb_get_room_thread_tree.">      
      <querytext>
       SELECT (jcr.room_id) as room_id , (jcr.name) as room_name 
                                                         FROM jb_room_start_from_thread jrsft , jb_conference_rooms jcr  
                                                         WHERE jrsft.thread_id = :thread_id 
                                                          AND jrsft.room_id = jcr.room_id
      </querytext>
</fullquery>

 
<fullquery name="jb_get_room_thread_tree.get_new_conference_threads">      
      <querytext>
      SELECT (thread_id) as cur_thread_id , subject , start_time 
                                       FROM jb_conference_room_threads 
                                       WHERE room_id = :room_id 
      </querytext>
</fullquery>

 
<fullquery name="jb_get_default_room_for_group.get_default_room">      
      <querytext>
      SELECT (jcr.name) as room_name FROM jb_conference_groups jcg , jb_conference_rooms jcr 
                                                  WHERE jcg.group_id = :group_id 
                                                  AND jcg.default_room_id = jcr.room_id
      </querytext>
</fullquery>

 
<fullquery name="jb_get_room_thread_tree.">      
      <querytext>
      SELECT group_name FROM groups WHERE group_id = :group_id
      </querytext>
</fullquery>

 
<fullquery name="jb_get_default_room_for_group.check_if_room_exists">      
      <querytext>
      SELECT room_id FROM jb_conference_rooms WHERE lower(name) = lower(:room_name)
      </querytext>
</fullquery>

 
<fullquery name="jb_get_default_room_for_group.get_room_id">      
      <querytext>
      SELECT (room_id) as new_room_id FROM jb_conference_rooms WHERE name = :room_name
      </querytext>
</fullquery>

 
<fullquery name="jb_get_default_room_for_group.map_new_room_to_group">      
      <querytext>
      INSERT INTO jb_room_party_map (room_id , party_id) VALUES (:new_room_id , :group_id)
      </querytext>
</fullquery>

 
<fullquery name="jb_get_room_thread_tree.">      
      <querytext>
      UPDATE jb_conference_rooms SET type = 'master' WHERE room_id = :new_room_id 
      </querytext>
</fullquery>

 
<fullquery name="jb_get_default_room_for_group.insert_new_room_as_default">      
      <querytext>
	Select jb_make_group_conference_group(:room_name , :group_id)
      </querytext>
</fullquery>

 
<fullquery name="send.get_user_screens_and_state">      
      <querytext>
      SELECT im_screen_name , status , service FROM jb_screens WHERE user_id = :to_user_id
      </querytext>
</fullquery>

 
</queryset>
