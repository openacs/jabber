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



set ret [jb_append_subject $room_name $subject $subject $thread_id]
ns_log notice "thread_id in append_chat-2.tcl ghj  $thread_id"

if { $ret == "0"} {
ns_returnredirect recorded-chat.tcl?name=$room_name&thread_id=$thread_id&party_id=$party_id&subject=$subject&display_status=$display_status&room_id=$room_id

ad_script_abort

} else {

ad_return_template

}