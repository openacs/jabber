ad_page_contract {

    add buddy to user's roster
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-12
    @param username username of the buddy, which should be added
    @param user_id 

}   {

    user_id:integer
    screen_name:notnull

}


db_0or1row get_user_screen_name {}
db_0or1row get_screen_id {}


db_dml update_reference {}
db_dml insert_into_jb_friends {}

set success [jb_addbuddy $im_screen_name $screen_name]

ns_returnredirect "addbuddy?user_id=$user_id"