ad_page_contract {
    
    
    @cvs-id invite-group.tcl,
    @creation-date 04/12/02
    @author bkiesbye@sussdorff-roy.com
    
    
} {
  group_id:integer,notnull
  {return_url "index.tcl"}   
  
}  -properties {
    
    
    
    active_rooms_table:multirow
    closed_rooms_table:multirow
    users_table:multirow
    context:onevalue
    is_users_table:onevalue
    
}

set is_rooms_table "true"

set context ""

set active_rooms [jb_activeconferencerooms]

set user_id [ad_conn user_id]

if {[db_0or1row get_user_screen "" ]} {

    set jid [jb_create_jid $im_screen_name jabber]
}

if {$active_rooms != -1} {

    set room_count [ns_set size $active_rooms]
} else {

   set room_count "-1"
}

template::form create invite -action invite-group-1
template::form create create -action room-create

set user_checkbox_options [list]
set active_select_options [list]
set closed_select_options [list]

multirow create active_rooms_table name 

multirow create closed_rooms_table name 


db_foreach get_rooms_from_group "" {
            

                      if {$room_count != -1} {

                                     set active_r false

	      				       for {set i 0 } {$i < $room_count} {incr i} {
						   if { [ns_set key $active_rooms $i ] == $room_name } {
                                                      
						       set active_select_options [concat [list [list $room_name $room_name]] $active_select_options]
						       multirow append active_rooms_table $room_name
						       set active_r true
                                                   } 
					       }
                                           
 
	         			     if { $active_r == "true"} {
    
	         				       set active_r false
  
						   } else {
						       
						       set closed_select_options [concat [list [list $room_name $room_name]] $closed_select_options]
						       multirow append closed_rooms_table $room_name

                          
			         	     }   



                                           } else {
					       
					       set closed_select_options [concat [list [list $room_name $room_name]] $closed_select_options]

					       multirow append closed_rooms_table $room_name

					   }                
 


              
	  } if_no_rows {

 set is_rooms_table "false"
}






# form template invite    

template::element create invite room_name -datatype text -widget select -label "Select room" -options $active_select_options
template::element create invite sub-invite -datatype text -widget submit -label "Invite"
template::element create invite group_id -datatype text -widget hidden -value $group_id
# form template create
template::element create create roomname -datatype text -widget select -label "Select room" -options $closed_select_options
template::element create create roomsubject -datatype text -widget hidden -value "restart"
template::element create create jid -datatype text -widget hidden -value $jid
template::element create create threadname -datatype text -widget text -label "New topics name:"
template::element create create threadsubject -datatype text -widget text -label "New topics subject:"
template::element create create sub-restart -datatype text -widget submit -label "Restart"
