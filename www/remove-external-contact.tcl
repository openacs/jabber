ad_page_contract {

    remove external contact from list
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-22
    @param screen_id who will be removed from jb_friends

}   {

    screen_id:integer

}


set user_id [ad_conn user_id]
ad_maybe_redirect_for_registration

db_dml remove_friend {}
db_dml decrease_reference {} 

#db_1row get_jabber_id {}
#db_1row get_friend_screen_name {}

#[jb_removetransbuddy $im_screen_name $friend_screen_name]

ad_returnredirect "view-external-contacts"
