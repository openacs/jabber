ad_page_contract {

    page to display all IM-Services
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-6

} -properties {

    get_services:multirow
    row_check_p:onevalue

}

db_multirow get_services get_service {} {

    set row_check_p 1

} if_no_rows {

    set row_check_p 0

}

ad_return_template

