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
     new_state:notnull
} -properties {

}

if {$new_state == "deleted" } {

db_exec_plsql new_conference_group_delete {
   begin
   membership_rel.delete(:rel_id );
   end;
}
} elseif {$new_state == "approved" } {

db_exec_plsql new_conference_group_approve {
   begin
   membership_rel.approve(:rel_id );
   end;
}
   

}


ns_returnredirect "group-edit.tcl?group_name=$group_name&group_id=$group_id&list_members=$list_members"