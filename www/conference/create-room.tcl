ad_page_contract {

   create-room.tcl

} {

 party_id:notnull
 {create "false"}
 {return_url "index"}

}  -properties {

   jid:onevalue

}

set jid "bjoern@jabber.org"

set user_id [ad_conn user_id]

if {[db_0or1row get_user_screen "" ]} {


    set jid [jb_create_jid $im_screen_name jabber]

} else {

   set jid "bjoern@jabber.org"

}

ad_form -name room_create -action room-create -form {
    {party_id:text(hidden) {value $party_id}}
    {create:text(hidden) {value $create}}
    {roomname:text(text) {label "Please Enter the<br> Name of the Room:<br>"} {html {size 75}}}
    {roomsubject:text(text) {label "Please Enter a short<br> description of the Room:<br>"} {html {size 75}} {value "Not specified"}}
    {jid:text(text) {label "Your Jabber ID:"} {value $jid} {html {size 40}}}
    {threadname:text(text) {label "New topics name:"} {value "Not specified"} {html {size 75}}}
    {threadsubject:text(text) {label "New topics description:"} {value "Not specified"} {html {size 75}}}
    {sub1:text(submit) {label "Create room"}}
}