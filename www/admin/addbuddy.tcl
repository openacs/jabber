ad_page_contract {

    add buddy to user's roster
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-12
    @param user_id to whom's roster should the admin add buddies

}   {

    user_id:integer
  
} -properties {

    user_id:onevalue
    internal_users:multirow
    row_check_p:onevalue

}


db_multirow internal_users get_internal_users {} {
    set row_check_p 1
} if_no_rows {
    set row_check_p 0
}



ad_return_template