
ad_page_contract {

    send messages and insert into jb_message_log
    @author Bjoern Kiesbye
    @author Malte Fliedner
    @author Luis Mosteiro Fernandez
    @param  screen_id
    @param  screen the jabber_id of the receiver
    @param  message

}   {

    screen_id:integer,optional
    screen:notnull
    message:trim

} -properties {

    success:onevalue
    user_check_p:onevalue

}

set user_id [ad_conn user_id]
ad_maybe_redirect_for_registration


if {[db_0or1row get_name "select first_names , last_name from persons where person_id =:user_id"]} {
    
    set user_check_p 1
    set name "([string range $first_names 0 0]. $last_name)\n"
    append  name $message
    set message $name
    append message "\n(You can't respond to this Message)"
    set user_log $screen
    set success [jb_message $screen $message]
    db_dml insert_log "insert into jb_message_log ( message_id, user_id , message , send , conn_state, receive_jid) values ( jb_message_log_seq.nextval, :user_id , :message , sysdate  , :success , :user_log )"
    
} else {
    set user_check_p 0
}


ad_return_template
