ad_page_contract {
      append-chat.tcl 
      author: bkiesbye@sussdorff-roy.com
      26.2.2003
} {
 
 room_name:notnull
 thread_id:notnull
 subject:notnull
 {display_status "true"}
 {party_id "0"}
 {room_id "0"}

}

set current_subject "Unknowen"

set active_rooms "-1"

set active_members [jb_activeroommembers $room_name]

if {$active_members == -1} {
ns_returnredirect append-chat-2.tcl?room_name=$room_name&thread_id=$thread_id&party_id=$party_id&subject=$subject$display_status=display_status&room_id=$room_id
} else {
    set active_rooms [jb_activeconferencerooms]
    if {$active_rooms != -1} {
    
     set rooms_count [ns_set size $active_rooms]

     for {set i 0 } {$i < $rooms_count} {incr i} {
         if { [ns_set key $active_rooms $i ] == $room_name } {
	     set current_subject "[ns_set value [ns_set value $active_rooms $i ] 1 ]"
	      
	 } 			       
      }
 }
 

    

    set member_count [ns_set size $active_members]
   
    multirow create members nick color 

    if {$member_count != -1} {
        
	for {set j 0} {$j < $member_count } {incr j} {
            
            set cur_member [ns_set value $active_members $j]   
	    multirow append members [ns_set value  $cur_member 0]  [jb_get_link_color_from_state [ns_set value  $cur_member 2 ]] 

	}

    }
    


}