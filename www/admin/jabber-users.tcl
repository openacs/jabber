ad_page_contract {

    display registered jabber users
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-17

} -properties {

    register:onevalue
    get_users:multirow
    row_check_p:onevalue

}





db_multirow get_users get_users {} {

    set regstate [string trimright $regstate]     
    set row_check_p 1

} if_no_rows {

    set row_check_p 0
}

ad_return_template 
