<?xml version="1.0"?>
<queryset>

<fullquery name="get_room_id">      
      <querytext>
      SELECT (room_id) as new_room_id FROM jb_conference_rooms WHERE name = :roomname
      </querytext>
</fullquery>

 
 
<fullquery name="map_new_room_to_old_thread">      
      <querytext>
      INSERT INTO jb_room_start_from_thread (room_id , thread_id) VALUES (:new_room_id , :thread_id)
      </querytext>
</fullquery>

 
<fullquery name="map_new_room_to_group">      
      <querytext>
      INSERT INTO jb_room_party_map (room_id , party_id) VALUES (:new_room_id , :party_id)
      </querytext>
</fullquery>

 
 
 
<fullquery name="update_room_type">      
      <querytext>
      UPDATE jb_conference_rooms SET type = 'master' WHERE room_id = :new_room_id 
      </querytext>
</fullquery>

 
</queryset>
