ad_page_contract {

    view of jabber users, so the admin can choose for which user he wants to add or remove buddies
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-12
    @param action , what does the admin want to do with user's roster, add or remove buddies

}   {

    action:notnull

} -properties {

    row_check_p:onevalue
    action:onevalue
    get_users:multirow

}

db_multirow get_users get_users {} {
    set row_check_p 1

} if_no_rows {

    set row_check_p 0

}



ad_return_template