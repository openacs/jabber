ad_page_contract {

    group-edit.tcl
    Admin Page for Conference Groups
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-16
} {
     group_id:notnull
     group_name:notnull
     list_members:notnull
     rel_id:notnull
} -properties {

}


db_exec_plsql new_conference_group {}


ns_returnredirect "group-edit.tcl?group_name=$group_name&group_id=$group_id&list_members=$list_members"