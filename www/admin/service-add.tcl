ad_page_contract {

    add new service to jb_services
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-6
    @param service database name for the IM-service
    @param pretty_name pretty_name for the service

}   {

    service:notnull
    pretty_name:notnull

} -properties {

    insert_check_p:onevalue

}




#check, whether service is in the database or not

if {![db_0or1row get_services {}]} {
    
    db_dml insert ""

    set insert_check_p 1

} else {

    set insert_check_p 0

}

ad_return_template