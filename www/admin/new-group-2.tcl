ad_page_contract {

    new-groups-2.tcl
    Admin Page for Conference Groups
    @author Bjoern Kiesbye
    @email bkiesbye@sussdorff-roy.com
    @creation-date 2003-03-13

}  {


 group_id:notnull

}


catch { [db_dml add_group_for_conferencing ""]
    }  errormsg

ns_returnredirect conference.tcl
