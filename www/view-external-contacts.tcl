ad_page_contract {

    view your external contacts
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-22
    
} -properties {

    get_external_friends:multirow
    context:onevalue
    row_check_p:onevalue

}

set context [list "Edit External Contact"]

set user_id [ad_conn user_id]
ad_maybe_redirect_for_registration

db_multirow get_external_friends get_external_friends  {} {
    set row_check_p 1
} if_no_rows {
    set row_check_p 0
}

ad_return_template
