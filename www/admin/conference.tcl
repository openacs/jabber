ad_page_contract {

    conference.tcl
    Admin Page for Conference Groups
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-16
}  -properties {

    
}

ad_form -name find -action new-group -form {
    {group_name:text(text) {label "Find existing &nbsp;&nbsp;&nbsp;<br>group: "}}
    {new_group:text(submit) {label "Find"}}
}

ad_form -name create -action new-group -form {
    {group_name:text(text) {label "Create group:"}}
    {new_group:text(submit) {label "Create"}}
}


set groups_exist "true"

multirow create groups group_name group_id


db_foreach get_conference_groups "" {

                  multirow append groups $group_name $group_id


	      } if_no_rows {

		  set groups_exist "false"
	      }


