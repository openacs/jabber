ad_page_contract {
 recordings

} {
 room_id:integer,notnull
 thread_id:notnull
 party_id:notnull
 {name:optional "Unknowen"}
 {subject:optional "Unknowen"}
 {display_status "true"}
} -properties {

 name:onevalue
 subject:onevalue
 msg:multirow
 nothing:onevalue
 nothing_message:onevalue
 thread_id:onevalue
 return_url:onevalue
 time:onevalue
 user_jid:onevalue
 party_id:onevalue
 new_name:onevalue
 
}

set link "false"
set user_id [ad_conn user_id]
set user_id_cur "NULL"
set first_names  "Unknown"
set last_name "Unknown"
set email "Unknowen"
set nothing false
set nothing_message ""
set status "offline"
set return_url [ad_conn url]
set time [ns_fmttime [ns_time] "%D %T"]
set ad_url [ad_url]

regsub -all ":"  $time  "-" time
regsub -all "/"  $time  "_" time
regsub -all " "  $time  "at" time
regsub -all "(0-9)(0-9)_(0-9)(0-9)_(0-9)(0-9)at(0-9)(0-9)-(0-9)(0-9)-(0-9)(0-9)" $name $time new_name

regsub -all {[0-9][0-9]_[0-9][0-9]_[0-9][0-9]at[0-9][0-9]-[0-9][0-9]-[0-9][0-9]} $name $time new_name

if {$name == $new_name} {

   set new_name $time
   append new_name $name
}

append return_url "?thread_id=$thread_id&room_id=$room_id"

multirow create msg nick text date link link_url

if {[db_0or1row get_user_jid "" ]} {
set user_jid $im_screen_name
append user_jid "@"
append user_jid [jb_get_transport_url_from_id [jb_get_transport_id_from_symbol jabber ]]
    
} else {

    set user_jid false
}

if { $thread_id == "full" } {

set sql "Select (user_id) as user_id_cur , jid , message , to_date(stored , 'HH:MM:SS') as stored from jb_conference_protocols where room_id=:room_id order by stored" 

} else {


set sql "Select (user_id) as user_id_cur , jabber_id ,  message ,   stored 
         FROM jb_conference_protocols  
         WHERE room_id= :room_id  
         AND thread_id= :thread_id 
         order by stored"

 



}

db_foreach messages_from_room_and_thread $sql {

    regsub -all {(@).*} $jabber_id "" nick

    if {$user_id_cur != "NULL" } {


      set link "true"
      set link_url  [acs_community_member_link -user_id $user_id_cur -label "$nick"]

    }

    multirow append msg nick $message $stored $link $link_url



set user_id_cur "NULL"
set nick "Unknown"

} if_no_rows {
  set nothing true
  set nothing_message "Sorry but we din't find any discussion from Room: $name and Thread: $subject"

}

if {$nothing != "true"} {
set msg_list [template::util::multirow_to_list msg]
set msg_list_count 0
} 

ad_form -name room_create -action room-create -form {
    {jid:text(hidden) {value $user_jid}}
    {party_id:text(hidden) {value $party_id}}
    {thread_id:text(hidden) {value $thread_id}}
    {return_url:text(hidden) {value "invite-group?group_id=$party_id"}}
    {type:text(hidden) {value "insert"}}
    {roomname:text(text) {label "New room name:"}}
    {roomsubject:text(text) {label "New room description:"} {value "Not specified"}}
    {threadname:text(text) {label "New topic:"}}
    {threadsubject:text(text) {label "New topic description:"} {value "Not specified"}}
    {sub1:text(submit) {label "Create"}}
}
