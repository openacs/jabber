ad_page_contract {

   conf-room-create.tcl

} {

 room_name:notnull
 {room_subject "Not specified"}
 {msg "Not specified"}
 jids:notnull,multiple
 
 {return_url "index.tcl"}
 {version "1"}
}

set length [llength $jids]


for {set i 0} {$i < $length} {incr i}  {

    set suc [jb_invite [lindex $jids $i]  $room_name $room_subject $msg $version ]

    ns_log Notice "hello"

}



ns_returnredirect $return_url
