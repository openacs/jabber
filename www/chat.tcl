ad_page_contract {

    @param return_url
    @param user_id_friend
} {

    user_id_friend:notnull,integer 
    {return_url "index.tcl"}
} 


set user_id [ad_conn user_id]
auth::require_login

db_foreach get_screens "" {
    if {$cur == $user_id} {
	set user_a $screen 
    } else {set user_b $screen}
} 

set suc [jb_chat $user_a $user_b]

ns_returnredirect $return_url
