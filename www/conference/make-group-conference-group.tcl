ad_page_contract {
   
     make-group-conference-group.tcl
     @author Bjoern Kiesbye
     @email bkiesbye@sussdorff-roy.com

 } {


  group_id:integer,notnull
  type:notnull
  {return_url "jabber"}
  {errormsg ""}
}
set user_id [ad_conn user_id]
set group_name "Unknown"

# First check if our system is online 
if {[jb_getconnstate ] == -1 } {

     ns_returnredirect $return_url
}

# test if this group is already a conference group , if its blocked or if it doesn't meet our constraints,

if { $group_id > 10 } {
  
    if { ![db_0or1row check_if_group_is_blocked ""]} {
	if {![db_0or1row check_group_for_existence_at_conference ""]} {
            
           
	    # this group_id is not a conference group yet ,and it's not blocked so make it one.

            db_dml enabling_group_for_conferencing ""

            
	} 





	# At least now it's  a group_id free for conferencing , redirect him to the groups main page / or just Start the Default Room.

	if {$type == "start_room"} {
	    
	    # Check if the user is registerd with jabber, and if get his/her screen and online status
	    if {[db_0or1row get_jabber_user_screen ""]} {
		set jid "$im_screen_name@[jb_get_transport_url_from_id [jb_get_transport_id_from_symbol "jabber"]]"
	    } else {
		
		# the user is not registerd just redirect him to the jabber/index.tcl

		ns_returnredirect "jabber/index"
		ad_script_abort
	    }

	    # We got jid and online status, now try to get the default room
	    
	    set room_name [jb_get_default_room_for_group $group_id]

            if {$room_name == "-1"} {
	     # we could not get a default room name
		set errormsg "We had problems to figure out your default Room , please contact your admin" 
		ad_return_template
		ad_script_abort
	    }	    
	    
	    
	    # now we have a room just try to start it
	    set suc [jb_createconferenceroom $room_name [ad_conn user_id] "First Start" $jid "Automatic Started Room ,this room: $room_name will be the Groups default name"]
	    
	    # now invite him any way
	    
	    set suc [jb_invite $jid $room_name "Groups discussion room" "You send this invite throug your web server" 1]
	    
	    # now return or let him login
	    if {$status == "offline"} {
		
		#ns_returnredirect "../jabber-login.tcl?return_url=$return_url"
		ns_returnredirect main.tcl?group_id=$group_id
		ad_script_abort 
	    } else {
		#ns_returnredirect $return_url 
		ns_returnredirect main.tcl?group_id=$group_id
		ad_script_abort
	    }
	    
	} else {
	    ns_returnredirect main.tcl?group_id=$group_id 
	
	    ad_script_abort


	
	}
    }
}
