ad_page_contract {
    
    
    @cvs-id invite-group.tcl,
    @creation-date 04/12/02
    @author bkiesbye@sussdorff-roy.com
    
    
} {
  group_id:integer,notnull
  
  
}  -properties {
    
    
    
    users_table:multirow
    context:onevalue
    is_users_table:onevalue
    
}

set is_rooms_table "true"

set active_rooms [jb_activeconferencerooms]

if {$active_rooms != -1} {

    set room_count [ns_set size $active_rooms]
} else {

   set room_count "-1"
}

multirow create active_rooms_table name 

multirow create closed_rooms_table name 


db_foreach get_rooms_from_group "SELECT  (jcr.name) as room_name 
                                       FROM jb_room_party_map jrpm , jb_conference_rooms jcr  
                                       WHERE jrpm.party_id = :group_id 
                                       AND jcr.room_id = jrpm.room_id
                                       AND lower(jcr.type) != 'child'
                                       ORDER BY jcr.name" {
            

                      if {$room_count != -1} {

              multirow append closed_rooms_table $room_name
	      				       for {set i 0 } {$i < $room_count} {incr i} {
						   if { [ns_set key $active_rooms $i ] == $room_name } {
                                                      
						       multirow append active_rooms_table $room_name
						      
                                                   } else {
						   
						   multirow append closed_rooms_table $room_name

						   }
					       }

                                           }                
 


              multirow append closed_rooms_table $room_name
	  } if_no_rows {

 set is_rooms_table "false"
}





multirow create users_table first_name last_name screen status

db_foreach get_users_from_group "SELECT (pe.first_names) as first_name , (pe.last_name) as last_name , (js.im_screen_name) as screen , (js.status) as status 
                                       FROM group_distinct_member_map gdmm , jb_screens js, persons pe  
                                       WHERE gdmm.member_id = js.user_id
                                       AND gdmm.member_id = pe.person_id 
                                       AND js.service = 'jabber'
                                       AND gdmm.group_id = :group_id 
                                       ORDER BY last_name" {



#AND js.status = 'offline'


append screen "@"
append screen [jb_get_transport_url_from_id [jb_get_transport_id_from_symbol jabber ]]


multirow append users_table $first_name $last_name $screen [jb_get_link_color_from_state $status] 
                    

}

