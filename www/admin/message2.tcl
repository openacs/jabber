ad_page_contract {

    inserts messages written on the admin-page into the database
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-18
    @param  receive_user who shall receive the message
    @param  message message

}   {

    receive_user:notnull
    message:optional

}

set user_id [ad_conn user_id]
auth::require_login

if {[db_0or1row get_name ""]} {
    
    set register_check_p 1
    set name "([string range $first_names 0 1]. $last_name)\n"
    append  name $message
    set message $name
    set user_log "$receive_user"
    set success [jb_message $receive_user $message]
    db_dml insert_log ""
   



} else {
 
    set register_check_p 0

}


ad_return_template


