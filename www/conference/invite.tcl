ad_page_contract {

   conf-room-create.tcl

} {

 room_name:notnull
 room_subject:notnull
 msg:notnull
 jid:notnull
 second_jid:optional
 second_user_id:optional
 {return_url "index.tcl"}
 {version "1"}
}



# we send both version of invites to asure all clients recive the invite
# This causesconflicts inside the conference module

set suc [jb_invite $jid $room_name $room_subject $msg $version ]
#set suc [jb_invite $jid $room_name $room_subject $msg 2 ]
if {[info exists second_jid]} {

set suc [jb_invite $second_jid $room_name $room_subject $msg $version ]
#set suc [jb_invite $second_jid $room_name $room_subject $msg 2 ]            
 
}
#set  suc [jb_activeconferencerooms]
#set suc [jb_invite]


ns_returnredirect $return_url
