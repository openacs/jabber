ad_page_contract {

    remove buddy from user's roster
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-13
    @param user_id which roster
    @param screen_id who should be removed

}   {

    user_id:integer
    screen_id:integer

}


db_1row get_user_jid {}
db_1row get_friend_screen_name {}

db_dml remove_from_jb_friends {}
db_dml decrease_reference {}

set success [jb_removebuddy $im_screen_name $friend_screen_name]

ns_returnredirect "view-users-roster?user_id=$user_id&action=remove"