ad_page_contract {

    add a user as buddy of logged-in user
 
    @param friend_id
    @param groupe
    @param return_url

} {
    friend_id:integer,notnull
    {return_url "/"}
    {groupe "aiesec"}
}

set user_id [ad_conn user_id]
ad_maybe_redirect_for_registration
set user_id_friend $friend_id

#if {[db_0or1row is_blocked "select blocked from jb_friends where user_id = :user_id and user_id_friend= :user_id_friend"]} {

 #   if { $blocked == "t" } {
  #      set html "<h3>You can't add this Member!</h3> <p><a href='$return_url'>Back</a></p>"
   #     ns_return 200 text/html $html
   # } else {
   #      ad_returnredirect "$return_url"
   # }
#} else {

set both 0

db_foreach get_jids "" {
    if {$user_id == $user_id_cur  } {
	set jid_a [list $jabber_screen $jabber_screen $groupe]
       set both [expr $both + 1]
       }
    
    if {$user_id_friend == $user_id_cur } {
	set jid_b [list $jabber_screen $jabber_screen $groupe]
        set both [expr $both + 1]

    }    

}
 

if {$both == 2} {
    set success  [jb_addbuddy $jid_a $jid_b]
}

db_foreach get_screen_ids "" {

    db_dml add_buddy ""
    db_dml update_refcount "" 

}

ad_returnredirect $return_url

}
