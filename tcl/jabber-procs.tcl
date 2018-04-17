# /tcl/jabber-procs

ad_library {
    Procedures for Jabber Module

    @author Bjoern Kiesbye
    @creation-date 2002/08/15 22:00:00

    changed name to jabber-procs, 2002/09/24 luis mosteiro fernandez
    changes made by Luis Mosteiro Fernandez, 2002/10/08
}


ad_proc jb_get_transport_id_from_symbol  { service }  "this func returns the transport_id and takes the services stored in the db" {

    switch $service { 
	"jabber" { return 1}
       	"aim" { return 2}
	"icq" { return 3}
	"msn" { return 4}
	"yahoo" { return 5}
	"irc" { return 6}
	default {return 0}
    }

}


ad_proc jb_get_link_color_from_state { state } "this func returns the color for a chat link , it takes the state stored in the db"  {
    
    switch $state {
        
	"online" { return "green" }
	"chat"   { return "green" }
	"away"   { return "yellow" }
	"dnd"    { return "navy" }
	"xa"     { return "mediumslateblue"}
	"offline" { return "black" }
	default {return "black" }
    }

}


ad_proc jb_get_colored_link { state  jid  scope  } "this func returns a the colored  chat link , it takes the state stored in the db and a full jid"  {

    set link_to_return "<a href=\"message1.tcl?scope=$scope&user_id=[ad_get_user_id]&screen=$jid\"><font color=" 
    switch $state {
        
	"online" { append link_to_return "\"green\">Message</font></A>" }
	"chat"   { append link_to_return "\"green\">Message</font></A>" }
	"away"   { append link_to_return "\"yellow\">Message</font></A>" }
	"dnd"    { append link_to_return "\"navy\">Message</font></A>" }
	"xa"     { append link_to_return "\"mediumslateblue\">Message</font></A>"}
	"offline" { set link_to_return "Offline" }
	default {set link_to_return "Offline" }
    }

    return $link_to_return
    
}



ad_proc jb_get_pritty_name_from_symbol { service  } "this func returns a pritty name to be displayed , takes a service symbol from the Table jb_screens"  {
    
    switch $service {
        
	"aim" { return "AIM" }
	"icq" { return "ICQ" }
	"yahoo" { return "Yahoo" }
	"msn" { return "MSN"  }
	"irc" { return "IRC" }
	"conference" { return "Conference" }
	"jabber" { return "Jabber" }
        default {return "" }
    }



}

ad_proc jb_smart_get_colored_link { jabber_state state  frinds_user_id  display_online display_offline  }   "this func returns a the colored  chat link , it takes the state stored in the db and a user_id to chat with and a string to be displayed"  {

    set link_to_return "<a href=\"chat-or-notify.tcl?user_id=[ad_get_user_id]&frinds_user_id=$frinds_user_id&jabber_state=$jabber_state\"><font color=" 
    switch $state {
        
	"online" { append link_to_return "\"green\">$display_online</font></A>" }
	"chat"   { append link_to_return "\"green\">$display_online</font></A>" }
	"away"   { append link_to_return "\"yellow\">$display_online</font></A>" }
	"dnd"    { append link_to_return "\"navy\">$display_online</font></A>" }
	"xa"     { append link_to_return "\"mediumslateblue\">$display_online</font></A>"}
	"offline" { set link_to_return "$display_offline" }
	default {set link_to_return "$display_offline" }
    }

    return $link_to_return
    
}


ad_proc jb_register_aprove {  user_id jscreen passwd  }   "This func registers a user with the Jabber server, it asumes that the user has ben approved already. If the tabel entrys for the user doesn't exist they will be created , Returns 0 on succes , -1 if the IM System isn't available (will be proccesed as soon as it becomes available, -2 if the jscreen already exists"  {

    if {![db_0or1row check_if_user_has_contacts "select (user_id) as dummy from jb_screens where user_id = :user_id"]} {
	db_dml create_a_contacts_table_entry "insert into jb_user_jabber_information (user_id) values (:user_id)"
    }

    if {![db_0or1row does_screen_exist "select screen_id from jb_screens where im_screen_name = :jscreen and service = 'j'"]} {


	db_exec_plsql new_screen {}


	db_dml register_with_user "update jb_user_jabber_information SET jabber_regstate = 'a' , jabber_passwd = :passwd where user_id = :user_id"

	set success [jb_register $jscreen $passwd]

	return $success
	
    } else {
	return "-3"
    }

}


ad_proc jb_subscribe_transport { screen service  }   "This function takes screenname and a service symbol, it returns the screen_id from jb_screens. If it doesn't exist jet it subscribes this screenname with the service identified by the service symbol"  {

    set group "online_trace"
    regsub -all  "@" $screen "%" screen

    if {[db_0or1row does_screen_exist_2 "select screen_id from jb_screens where lower(im_screen_name) = lower(:screen) and lower(service) = lower(:service)"]} {

        db_dml update_ref_count {update jb_screens set refcount = refcount + 1 where screen_id = :screen_id}                    
        return $screen_id

    } else {

	db_dml add_to_jb_screens {insert into jb_screens (screen_id , im_screen_name , service ,status , refcount ) values (acs_object_id_seq.nextval , lower(:screen) , lower(:service) , 'offline' , '1')}
	
	set success [jb_addtransportbuddy $screen $group [jb_get_transport_id_from_symbol $service] ]
	
	db_1row get_the_new_screen_id {select (screen_id) as new_screen_id from jb_screens where im_screen_name = lower(:screen)  and service = lower(:service)}
	
	return $new_screen_id

    }


}


ad_proc jb_best_chat { user_id_friend  }   "This function gives back a   link to start a chat"  {

    
    set  user_id [ad_get_user_id] 



    set trans_symbol [list j a i m y r]

    set jabber_user [list "dumy" "offline" ]
    set aim_user [list "dumy" "offline" ]
    set msn_user [list "dumy" "offline" ]
    set icq_user [list "dumy" "offline" ]
    set yahoo_user [list "dumy" "offline" ]
    set irc_user [list "dumy" "offline" ]

    db_foreach find_m_all "select (sn.im_screen_name) as screen, (sn.service) as service ,(sn.status) as status
                       FROM jb_screens sn  
                       WHERE sn.user_id = :user_id "  {


			   switch $service {
			       
			       "jabber" {set jabber_user [list $screen $status $service]}
			       "aim"    {set aim_user [list $screen $status $service]}
			       "msn"    {set msn_user [list $screen $status $service]}
			       "icq"    {set icq_user [list $screen $status $service]}
			       "yahoo"  {set yahoo_user [list $screen $status $service]}
			       "irc"    {set irc_user [list $screen $status $service]}
			   }


		       }


    


    set jabber_friend [list "dumy" "offline" ]
    set aim_friend [list "dumy" "offline" ]
    set msn_friend [list "dumy" "offline" ]
    set icq_friend [list "dumy" "offline" ]
    set yahoo_friend [list "dumy" "offline" ]
    set irc_friend [list "dumy" "offline" ]



    db_foreach find_m_all_friend {select (sn.im_screen_name) as screen, (sn.service) as service ,(sn.status) as status FROM jb_screens sn  
	WHERE sn.user_id = :user_id_friend }  {

			   

			   switch $service {
			       
			       "jabber" {set jabber_friend [list $screen $status $service]}
			       "aim" {set aim_friend [list $screen $status $service]}
			       "msn" {set msn_friend [list $screen $status $service]}
			       "icq" {set icq_friend [list $screen $status $service]}
			       "yahoo" {set yahoo_friend [list $screen $status $service]}
			       "irc" {set irc_friend [list $screen $status $service]}
			   }


		       }

    set best_state [list] 
    set notifyable  0
    set jabberable 0

    for {set i 0} {$i < 5} {incr i} {


	switch $i {

	    0 { if {[lindex $jabber_user 1] != "offline" && [lindex $jabber_friend 1] != "offline" } {
		return "chat.tcl?user_id_friend=$user_id_friend"
		break
	    } elseif { [lindex $jabber_friend 1] != "offline"} {
		lappend best_state 1.2
	    } elseif { [lindex $jabber_user 1] != "offline"}  { 
		set jabberable 1
	    }
	    }
	    
	    1 { if {[lindex $aim_user 1] == "offline" && [lindex $aim_friend 1] != "offline"} { 
		return "aim:goim?screenname=[jb_get_aim_screen_from_friend_id $user_id_friend]&message=Hello" 
	    } elseif {[lindex $aim_user 1] != "offline" && [lindex $aim_friend 1] != "offline"} {
		return "aim:buddyicon?message=Aiesec+Chat+Invite&listofscreennames=[jb_get_aim_screen_from_friend_id  $user_id_friend]"
		lappend best_state 2 
		set notifyable 1
	    } else {lappend best_state 0}
	    }
	    
	    2 { if {[lindex $msn_user 1] != "offline" && [lindex $msn_friend 1] != "offline"} {
		lappend best_state 2
		set notifyable 1
	    } elseif { [lindex $msn_friend 1] != "offline"} {
		lappend best_state 1
		set notifyable 1
	    } else { lappend best_state 0}
	    }
	    
	    3 { if {[lindex $yahoo_user 1] != "offline" && [lindex $yahoo_friend 1] != "offline"} {
                lappend best_state 2 
                set notifyable 1
	    } elseif {[lindex $yahoo_friend 1] != "offline"} {
                lappend best_state 1 
                set notifyable 1
	    } else {lappend best_state 0}
	    }

	    4 { if { [lindex $icq_user 1] != "offline" && [lindex $icq_friend 1] != "offline"} {
		lappend best_state 2
		set notifyable 1 
	    } elseif {[lindex $icq_friend 1] != "offline"} {
		lappend best_state 1
		set notifyable 1 
	    } else { lappend best_state 0}
	    }

	    5 { if {[lindex $irc_user 1] != "offline" && [lindex $irc_friend 1] != "offline"} {
	        lappend best_state 2 
	    } elseif {[lindex $icq_friend 1] != "offline"} {
                lappend best_state 1
	    } else {lappend best_state 0}
	    }

	    
	}
    }
    set hiest 0
    set trans_symbols_2 [list jabber aim msn yahoo icq irc]    
    for {set j 0} {$j <= 5 } {incr j} {
	if {[expr  [lindex $best_state $j] - $hiest] > 0 } { 
	    set hiest  [lindex $best_state $j]
	    set trans  [lindex $trans_symbols_2 [expr $j + 1]] 
	}
	
    }
    if {$hiest == 2 } { return "display-name.tcl?user_id_friend=$user_id_friend&trans_symbol=$trans" }
    if {$hiest == 1.2} { return "go-to-jabber?user_id_friend=$user_id_friend&trans_symbol=$trans"}
    if {$hiest == 1 && $jabberable } { return "ask-to-jabber?user_id_friend=$user_id_friend&trans_symbol=$trans"} 
    if {$hiest == 1 } { return "notify-only?user_id_frind=$user_id_friend&trans_symbol=$trans"} 

    return "[lindex $best_state 0 ] $hiest"


}

ad_proc jb_create_jid {screen service} "This function takes a screen_name and a service Symbol and returns a full jid " {

    append screen "@" 
    append screen [jb_get_transport_url_from_id [jb_get_transport_id_from_symbol $service]]
    return $screen

}


ad_proc jb_get_aim_screen_from_friend_id {user_id_friend } "This func returns the Aim Screenname that belongs to a friend id " {

    if {[db_0or1row get_screen "SELECT (sn.im_screen_name) as screen FROM jb_screens sn  WHERE  sn.user_id = :user_id_friend  AND sn.service = 'aim' "]} {

	return $screen

    } else {
	
	return "error"
	
    }

}




ad_proc jb_invite_user  { room_name version return_url } { This function returns the URL (href for a link) to invite the user him self (entering a Room) to a Conference Room , the parameters are the 1. name of the room 2. which version of the invite shuold be used (1 or2) , 3. the url of the page the user should be redirected to after the invite has been send , 4. display will be what the browser shows to the user (displayed name of the Link)   }  {

    set user_id [ad_get_user_id]
    set jid_to ""

    if {[db_0or1row get_user_jid "SELECT im_screen_name FROM jb_screens WHERE user_id = :user_id AND service = 'jabber'" ]} { 

    set jid_to $im_screen_name 
    append jid_to "@"
    append jid_to [jb_get_transport_url_from_id [jb_get_transport_id_from_symbol jabber ]]
      
    set return_val "/jabber/conference/invite.tcl?room_name=$room_name&version=$version&jid=$jid_to&room_subject=Self&msg=Invite&return_url=$return_url"

    return $return_val 

}  

  return test 

}





ad_proc jb_get_room_thread_tree { thread_id  party_id  active_rooms  last_visit max_depth} {try to build up a tree structure of conference Rooms} {

    set return_val "<OL type=A>"
   
    if { $max_depth == 5} {
	return ""
    } 

    if {$active_rooms != -1} {

	set room_count  [ns_set size $active_rooms] 

    } else {


	set room_count -1
    }
    
    set rooms_list [list]
    set rooms_count 0
    

    db_foreach get_rooms_started_at_thread  " SELECT (jcr.room_id) as room_id , (jcr.name) as room_name 
                                                         FROM jb_room_start_from_thread jrsft , jb_conference_rooms jcr  
                                                         WHERE jrsft.thread_id = :thread_id 
                                                          AND jrsft.room_id = jcr.room_id" {

							      set cache [list $room_id $room_name]   
							      lappend rooms_list $cache
							      set rooms_count [expr $rooms_count +1]
							      
							  } if_no_rows {
							      set rooms_count -1
							      
							  }



    #      multirow -local create test test_value
    #     set room_rows  [multirow size multi_rooms]

      

    if { $rooms_count > 0} {
	
	for {set k 0} {$k < $rooms_count} {incr k} {
	    
	    

	    set room_name [lindex [lindex $rooms_list $k] 1] 
	    # room_array(room_name)
	    set room_id [lindex [lindex $rooms_list $k] 0] 
	    #room_arry(room_name)
	    ns_log notice "for dem false 1"

	    set active "false"


	    if {$room_count != -1} {

		set active "false"
		set active_value "-1"
		ns_log notice "for dem false 2.1"
		for {set i 0 } {$i < $room_count} {incr i} {
		    if { [ns_set key $active_rooms $i ] == $room_name } {
			set active "true"
			set active_value [jb_invite_user $room_name 2  index.tcl]
			ns_log notice "for dem false 2.2"
		    }
		}
		
	    }                
	    
	    
	    
	    append return_val "<LI><B>$room_name "
	    
	    
	    ns_log notice "for dem false 3"
	    if {$active == "false"} {
                append return_val " <a href='room-create.tcl?room_id=$room_id&roomname=$room_name&roomsubject=Restarted_$room_name&threadname=Restarted_$room_name&threadsubject=Restarted$room_name&party_id=$party_id&restart=true'>Restart</a> "                               
		ns_log notice "for dem false 4.1"
	    } else {
                append return_val " <a href='$active_value'>Enter</a> "
		ns_log notice "for dem false 4.2"
                                          }


           
	   
	    set thread_table ""
	    set thread_list [list]
	    set thread_count 0

	    db_foreach get_new_conference_threads "SELECT (thread_id) as cur_thread_id , subject , start_time 
                                       FROM jb_conference_room_threads 
                                       WHERE room_id = :room_id " {
					   

					   set cache [list $cur_thread_id $subject $start_time]
                                           lappend thread_list $cache
                                           set thread_count [expr $thread_count + 1 ]
					   
				       }
 
	    if { $thread_count > 0 } {             
		set thread_table "<OL type=1>"
		for {set j 0} {$j < $thread_count} {incr j} {

		    set cur_thread_id [lindex [lindex $thread_list $j] 0]
		    set subject [lindex [lindex $thread_list $j] 1]
		    set start_time [lindex [lindex $thread_list $j] 2]

		    ns_log debug "for dem false 5.1"
		    append thread_table "<LI>$subject $start_time <a href='recorded-chat.tcl?room_id=$room_id&thread_id=$cur_thread_id&name=$room_name&subject=$subject&party_id=$party_id'>View Log</a>"
                    
                    set sub_table  ""
		    set sub_table "[jb_get_room_thread_tree $cur_thread_id $party_id $active_rooms $last_visit [expr $max_depth + 1]]"
		    append thread_table " $sub_table</LI>" 
		    
		    
		    if {![empty_string_p $sub_table]} {
			append thread_table "</ol>"
		    }
                                                                    
		      
		} 
		append thread_table " </ol> "            
	    } else  { 
     
		ns_log debug "for dem false 5.2"
		set  thread_table  ""
                  

	    }                                      
 

	    ns_log notice "for dem false ENDE"

	    append return_val "</B>$thread_table</LI>"              


                 


	    
	}
    } else {

	set return_val ""                        
    }
    
    
    
    ns_log notice "for dem false ENDE 2 "
    
    return $return_val
    
    
    
}



ad_proc jb_get_conference_url_for_group {group_id} {This function gets passed a group_id and returns, the url of the Conferencing main-page for this Group. } {

    #set url [apm_package_url_from_key jabber]
    set url "conference/make-group-conference-group.tcl?group_id=$group_id&type=main"

}
 
ad_proc jb_start_conference_room_for_group_url {group_id} {This function gets passed a group_id and returns, the url to start the default Conferencing room of  this Group. } {

    #set url [apm_package_url_from_key jabber]
    set url "conference/make-group-conference-group.tcl?group_id=$group_id&type=start_room"

}


ad_proc jb_get_default_room_for_group { group_id } { This function returns the default room name for a group, if their is now default room yet it creates one.} {

      		if {![db_0or1row get_default_room "SELECT (jcr.name) as room_name FROM jb_conference_groups jcg , jb_conference_rooms jcr 
                                                  WHERE jcg.group_id = :group_id 
                                                  AND jcg.default_room_id = jcr.room_id"]} {


                     # no default name yet
		    if {[db_0or1row get_group_name  "SELECT group_name FROM groups WHERE group_id = :group_id"]} {
		
                       # remove all white spaces
       
			regsub -all {\ } $group_name "-" group_name
ns_log notice "anfang: group_name = $group_name"
			# got the groupname, try to create a room_name with it
			if {[string length $group_name] <= 16} {
 
			    set room_name $group_name
                           ns_log notice "A: group_name = $group_name , room_name = $room_name"
			} else { 
                            set room_name $group_name
			    set room_name [string range $group_name 0 15 ]
	                        ns_log notice "B: group_name = $group_name , room_name = $room_name"
			}

			set count 0

			while {1} {
                          ns_log notice "jb_get_default_room_for_group 1 group_id = $group_id"
			    if {[db_0or1row check_if_room_exists "SELECT room_id FROM jb_conference_rooms WHERE lower(name) = lower(:room_name)"]} {
 
                          ns_log notice "jb_get_default_room_for_group 2 room_id = $room_id"
				#the room exists already , so try to figure out a different name 
  
set dummy "empty"
                                if {$count == 0} {

				    set room_name [string range $room_name 0 12]
				} else {

				    regsub -all {[0-9]+} $room_name "" room_name
				} 
                          ns_log notice "jb_get_default_room_for_group 3 room_name = $room_name , count = $count ,dummy = $dummy"
                         
			  set count [expr $count + 1]
			  append room_name "$count"
	                 			                          ns_log notice "jb_get_default_room_for_group 3 room_name = $room_name , count = $count ,dummy = $dummy"
				
                                
                                if {$count > 999} {return -1}

			    } else {
				
				# we have a name so create the room 
				
				set suc [jb_createconferenceroom $room_name [ad_conn user_id] "First Start" "$room_name@[jb_get_transport_url_from_id [jb_get_transport_id_from_symbol jabber]]" "This Room is"]
                          ns_log notice "jb_get_default_room_for_group 4 suc = $suc"

				if {$suc != "-1"} {

				    if {[db_0or1row get_room_id "SELECT (room_id) as new_room_id FROM jb_conference_rooms WHERE name = :room_name"]} {
		
					db_dml map_new_room_to_group "INSERT INTO jb_room_party_map (room_id , party_id) VALUES (:new_room_id , :group_id)"
					db_dml update_the_room_type  "UPDATE jb_conference_rooms SET type = 'master' WHERE room_id = :new_room_id "

	      
				    } 
				     
				     db_exec_plsql insert_new_room_as_default ""
				
				 
				       return $room_name
				 } else {
				 
				    return "-1"
				 }
			    
			    }

                          

		             
		
			}
		    } else {
			return "-1"
		    }
		} else {
		
		   return $room_name
		}
	    }


ad_proc -public jb_get_leagel_screen  {cur_user_id}  "this func returns a automatic created screen_name like firstname.lastname" {

    if {[db_0or1row get_user_names {SELECT first_names , last_name FROM persons
	WHERE person_id = :cur_user_id}]} {

        set names_available 1
        string trim $first_names
        string trim $last_name
        set screen_name "$first_names.$last_name"


        regsub -all {([^A-z^0-9.]*[`]*[\^]*)} $screen_name "" screen_name

        set screen_name [string range $screen_name 0 15]
        set screen_name [string tolower $screen_name]

        set count 0
	

        while {[db_0or1row check_jid_exists {Select (user_id) as check1 From jb_screens Where im_screen_name = :screen_name And service = 'jabber'}]} {

            if {$count > 1000} {
                #error
            }

	    
            if {$count > 0} {

                while {1} {
                    # remove all trailing digits
		    set lastchar [string range $screen_name [string length $screen_name] [string length $screen_name]]
		    
		    if {[regexp {[0-9]} $lastchar lastchar] == 1} {
			set screen_name [string range $screen_name 0 [expr [string length $screen_name] -2]]
		    } else {
			break
		    }
		}
	    }

	    incr count

	    if {[expr [string length $screen_name] + [string length $count]] > 16} {

		set screen_name [string range $screen_name 0 [expr 15 - [string length $count]]]
                append screen_name "$count"

	    } else {


                set screen_name "$screen_name$count"
            }
	}
    }
    
    return $screen_name

}




namespace eval notification {


    namespace eval imessage {

        ad_proc send_and_email { to_user_id reply_object_id notification_type_id subject  content } {This procedure Sends a IM-msg to the user user_id,  it figures out which system to use by User preferences and his current online state (the message will be trunct to 500 characters), and sends an email } {

	    ns_log notice "notification::imessage::send_and_mail 1"	
	    set suc  [ notification::imessage::send $to_user_id $reply_object_id $notification_type_id "$subject"  "$content"]

	    ns_log notice "notification::imessage::send_and_mail 2 suc = $suc"            

	    notification::email::send $to_user_id $reply_object_id $notification_type_id "$subject"  "$content"
	    
	    ns_log notice "notification::imessage::send_and_mail 3"
	
	}
	

	ad_proc -public send_or_email {  to_user_id reply_object_id notification_type_id subject  content } { This procedure Sends a IM-msg to the user user_id,  it figures out which system to use by User preferences and his current online state (the content will be trunct to 50 characters). Or in case the user is offline it will send an email } {
	    ns_log notice "notification::imessage::send_or_mail 1"
	    set suc 0
    	    set suc  [ notification::imessage::send $to_user_id $reply_object_id $notification_type_id "$subject"  "$content"]
	    ns_log notice "notification::imessage::send_or_mail 2 suc = $suc"

            if {$suc == "-1"} {
	    ns_log notice "notification::imessage::send_or_mail 3"
		notification::email::send $to_user_id $reply_object_id $notification_type_id "$subject"  "$content"
	    }

 	    ns_log notice "notification::imessage::send_or_mail 4"


	}


	ad_proc send {  to_user_id reply_object_id notification_type_id subject  content } { This procedure Sends a IM-msg to the user user_id,  it figures out which system to use by User preferences and his current online state } {

	    ns_log notice "notification::imessage::sendbb"	
	    set state 0
	    set cur_screen ""
	    set cur_service ""
	    db_foreach get_user_screens_and_state "SELECT im_screen_name , status , service FROM jb_screens WHERE user_id = :to_user_id" {

		
		switch $status {
		    
		    "online" {set cur_state 5 }
		    "chat"   {set cur_state 4 }
		    "away"   {set cur_state 3 }
		    "dnd"    {set cur_state 2 }
		    "xa"     {set cur_state 1 }
		    "offline" {set cur_state 0 }
		    default {set cur_state 0 }
		}

		if {$cur_state > $state} {
		    
		    set  state $cur_state
		    set cur_screen $im_screen_name
		    set cur_service $service
		}

		    


	    } if_no_rows {
	    
		return -1
	    } 
	    

	    if {$state == 0 } {return -1}
	    
	    # we have our best im_screen_name an service create jid

	    set jid "$cur_screen@[jb_get_transport_url_from_id [jb_get_transport_id_from_symbol $cur_service]]"

            set sub_len [string length $subject]
            
	    set content_len [string length $content]

            if { $sub_len < 500 } {

		set left_len [expr 500 - $sub_len]

		if { $content_len < $left_len } {

		    set msg "$subject $content" 
    
		} else {

		    set msg "$subject [string range $content 0 [expr $left_len - 6]] . ." 
		}

	    }  else {

		set msg "[string range $subject 0 492] . . . "
	    }



	    return [jb_message $jid $msg] 

	}
    }
}
