ad_page_contract {

    disable a IM-Service
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-6
    @param service which service should be deactivated

}   {

    service:notnull

}


db_dml deactivate_service {}

ns_returnredirect "service-view"