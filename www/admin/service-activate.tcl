ad_page_contract {

    enable a IM-Service
    @author Luis Mosteiro Fernandez
    @creation-date 2002-11-6
    @param service which service should be activated

}   {

    service:notnull

}


db_dml activate_service {}

ns_returnredirect "service-view"