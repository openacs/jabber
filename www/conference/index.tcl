ad_page_contract {
     
    
    @cvs-id index.tcl,
    @creation-date 04/12/02
    @author bkiesbye@sussdorff-roy.com
    
    
}  -properties {
    
    
         
    room_table:multirow
    context:onevalue
    is_room_table:onevalue
    time:onevalue
    groups:multirow
}

set time [ns_time]

set active "false"

set active_value "-1"

set context ""

set user_id [ad_conn user_id]

set is_room_table "true"

set thread_list ""

set active_rooms [jb_activeconferencerooms]

if {$active_rooms != -1} {

    set room_count [ns_set size $active_rooms]
} else {

   set room_count "-1"
}




if {[db_0or1row  get_last_visit ""]} {
     set last_visit_t $last_visit
    }


multirow create groups group_name group_id

db_foreach groups_of_this_user  "" {

                multirow append groups $group_name $group_id
}


multirow create rooms_table room_name room_id active thread_table active_value party_id


db_foreach get_conference_group_rooms ""  {



					   if {$room_count != -1} {

                                                set active "false"
						 set active_value "-1"

					       for {set i 0 } {$i < $room_count} {incr i} {
						   if { [ns_set key $active_rooms $i ] == $room_name } {
                                                      set active "true"
						       set active_value [jb_invite_user $room_name 2  index.tcl]
                                                   }
					       }

                                           }                
 
 

              
set thread_list "<OL type=1>"

db_foreach get_new_conference_threads "" {


                                         append thread_list "<LI>$subject $start_time <a href='recorded-chat.tcl?room_id=$room_id&thread_id=$thread_id&name=$room_name&subject=$subject&party_id=$party_id'>View Log</a></LI>"
                                     

				     } if_no_rows {
                                             
                                            set thread_list ""
                                                   }

                       
					   if { $thread_list != ""} {
                                                     append thread_list "</OL>"
                                                   

          

               multirow append rooms_table $room_name  $room_id  $active $thread_list $active_value $party_id

               set thread_list ""
					   }
                 
				       } if_no_rows {

			               
					   set is_room_table "false"
				       }