ad_page_contract {

    display-name.tcl
    @author Bjoern Kiesbye
    @author Luis Mosteiro Fernandez
    @param trans_symbol which im_service
    @param user_id_friend which user

}   {

    trans_symbol:notnull
    user_id_friend:notnull,integer
    {return_url "index.tcl"}

} -properties {

    im_service:onevalue
    im_screen_name:onevalue

}

set user_id [ad_conn user_id]
auth::require_login

set im_service $trans_symbol

db_0or1row get_screen "" 


