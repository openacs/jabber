ad_page_contract {

    remove a user as buddy of logged-in user

    @param friend_id
} {
    friend_id:integer,notnull
    {return_url "/"}
}




if {![info exists grupe]} {
   set groupe aiesec
}

set user_id [ad_conn user_id]
set user_id_friend $friend_id
set both 0

db_foreach get_jids ""  {
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
    set success  [jb_removebuddy $jid_a $jid_b]
}

db_foreach get_screen_ids "" { 

    db_dml remove_buddy ""
    db_dml update_refcount ""
}

ad_returnredirect $return_url


