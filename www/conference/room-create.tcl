ad_page_contract {

   room-create.tcl

} {

 roomname:notnull
 roomsubject:notnull
 threadname:notnull
 threadsubject:notnull
 jid:optional
 jid_to:optional
 thread_id:optional,integer
 room_id:optional
 party_id:optional,notnull
 type:optional
 {return_url "index.tcl"}
 {create "false"}
 {restart "false"}
}  -properties {

   error:onevalue

}
set pos 0

set errormsg "Position: "

set allow_creation false

set user_id [ad_conn user_id]

set roomname [string trim $roomname]
set roomname [string tolower $roomname]
set err ""
set suc ""
if {[regexp  {([ ]+)|(!+)|(/+)|([-]+)|([:]+)|(;+)|("+)|('+)|([*]+)|(%+)|(&+)|([$]+)|(§+)} $roomname match ]} {

set pos 1
   set errormsg "Room: <b>$roomname</b> cant' be created.<BR>
                 Because you used the charackter : <b>\"$match\"</b> , in your RoomName.<br>
                 Do not use iligal caracters like <b>! , + , / , : , ; , \$ , \' , \" ,  % , & </b> or <b>spaces</b> in your RoomName.<br>
                 Use the carackters <I>a to z</i>, numbers <i> 0 to 9</I>  and the singnes <i>\"-\" and  \"_\" </I> only."  

  set allow_creation false

} else {
set pos 1.1
set allow_creation true
}


if {![info exists jid]} {
set jid "www.sussdorff-roy.com"
}




# This code is used when some one starts a room (a discussion from an existing thread), we have to map the old thread to the new Room 


if { [info exists thread_id] && [info exists type] && $type == "insert" && $allow_creation == "true"  } {

    if { [db_0or1row get_room_id ""]  } {
	
	catch {[ set suc [jb_createconferenceroom $roomname $user_id $threadname $jid $roomsubject ] ]} err
        
	set error_txt "The Room: $roomname is all ready in use"

        set suc "-10"

    } else {  

	catch {[ set suc [jb_createconferenceroom $roomname $user_id $threadname $jid $roomsubject ] ]} err
    }

   if {$suc == -10  } {

       set errormsg "Room creation unsuccessful. $error_txt"
} else {

    if { [db_0or1row get_room_id ""]  } {

	catch {[db_dml map_new_room_to_old_thread ""]} errormsg 
	catch {[db_dml map_new_room_to_group ""]} errormsg 
}


#    the room is created  now invite the persons
    
    ns_returnredirect invite-group-1.tcl?group_id=$party_id&room_name=$roomname
 
    #ns_returnredirect invite.tcl?room_name=$roomname&room_subject=$roomsubject&msg=Question_about:_$roomname&version=1&jid=$jid&second_jid=$jid_to&thread_id=$thread_id&room_id=$room_id
 
   
    }
     

} 






#This happens at a normal room creation 

if { $create == "true" && $allow_creation == "true"} {

  
    set pos 3

    ns_log notice "form room creation $roomname $user_id $threadname $jid $roomsubject"

    catch { 
	[set suc [jb_createconferenceroom $roomname $user_id $threadname $jid $roomsubject ]]
    } err
    
ns_log notice "nach dem room creation"
    if {$suc != 0} {
	set pos 3.1
	set errormsg "Room creation unsuccessful. error $suc. Jabber Server not available."
    } else {
	set pos 3.2
	set im "keine ahnung"
	if { $create == "true" } {

	    if {[db_0or1row get_room_id ""]} {
		set pos 3.3
		db_dml map_new_room_to_group ""
		db_dml update_room_type  ""

		set im ja
	    }  else {
		set pos 3.4
		set im nein
	    }
	    
	}

 
	#ns_return 200 text/html "room: $roomname create: $create im if? $im "  
	ns_returnredirect [jb_invite_user $roomname 1 $return_url]
	set pos 3.5
    }

}

append errormsg " $allow_creation, $restart nnnn"

if {  $allow_creation == "true" && $restart == "true" } {

    catch {
	[set suc [jb_createconferenceroom $roomname $user_id $threadname $jid $roomsubject ]]
    } err
 
ns_log notice "after createroom suc = $suc"
    if {$suc == -10  } {

	set errormsg "Room creation unsuccessful. error $suc"
    } else {
	ns_log notice "return_url = $return_url"
	set check_url [jb_invite_user $roomname 2 $return_url]
	ns_log notice "check_url = $check_url"
	ns_returnredirect $check_url
       
    }
} 

set pos "ende"