ad_page_contract {

    new-groups.tcl
    Admin Page for Conference Groups
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-12-18

}  {


 group_name:notnull
 new_group:notnull
}

set searched_rows "false"

if {$new_group == "Create"} {

    catch {
	db_dml new_conference_group {}
    } errormsg


ns_returnredirect conference.tcl
ad_script_abort

} elseif {$new_group == "Find" } {

    set searched_rows true
 
    multirow create groups group_name group_id 

    db_foreach get_group_from_prefix "SELECT (group_id) as cur_group_id , (group_name) as cur_group_name 
                              FROM groups g 
                              WHERE lower(g.group_name) like(lower('$group_name%')) 
                              AND g.group_id NOT IN (SELECT group_id FROM jb_groups_blocked_conference)" {
	
				  multirow append groups $cur_group_name  $cur_group_id
	
	
			      } if_no_rows {
	
				  set searched_rows "false"
    

			      }

}
