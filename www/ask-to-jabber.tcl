ad_page_contract {

} {

    user_id_friend:notnull,integer
    trans_symbol:notnull
    {return_url "index.tcl"}

}

set user_id [ad_conn user_id]

db_0or1row get_name_to_notify ""

set notify_screen "$screen@[jb_get_transport_url_from_id [jb_get_transport_id_from_symbol $trans_symbol]]"

db_0or1row get_name ""

set message "$first_names $last_name would like you to come to Jabber at ([jb_get_transport_url_from_id 1]) {You cant respond to this Message!}"

jb_message $notify_screen $message

db_foreach get_screens "" {
    if {$cur == $user_id} {
	set user_a $screen 
    } else {set user_b $screen}
} 

set suc [jb_chat $user_a $user_b]

ns_returnredirect $return_url
