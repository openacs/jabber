ad_page_contract {

     block-group-2.tcl
     @author Bjoern Kiesbye
     @email bkiesbye@sussdorff-roy.com 

} {

  group_id:integer,notnull
  type:notnull
  {showe_blocked "true"}
}


if { $type == "block"  } {


       catch { [db_dml remove_group_from_conferencing ""]
    }  errormsg

    catch { [db_dml block_group_for_conferencing ""]
    }  errormsg

    ns_returnredirect block-group.tcl?showe_blocked=$showe_blocked
} elseif { $type == "unblock"} {


    catch { [db_dml unblock_group_for_conferencing ""]
    }    errormsg
   
    ns_returnredirect block-group.tcl?showe_blocked=$showe_blocked
}
