ad_page_contract {

    view user's roster or buddy list
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-12
    @param user_id who's roster do you want to see
    @param action what do you want to do with user's roster

}   {

    user_id:integer
    action:notnull

} -properties {

    row_check_p:onevalue
    action:onevalue
    internal_buddies:multirow
    external_buddies:multirow

}

set row_check_p 0

db_multirow internal_buddies get_internal {} {
    set row_check_p [expr $row_check_p + 1] 
}

db_multirow external_buddies get_external {} {
    set row_check_p [expr $row_check_p + 2]
}
