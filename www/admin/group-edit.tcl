ad_page_contract {

    group-edit.tcl
    Admin Page for Conference Groups
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-16
} {
    {user_prefix ""}
    {group_prefix ""}
     group_id:notnull
     group_name:notnull
    {list_members "true"}
} -properties {

}

set multi ""

multirow create partys party_id name

if {$user_prefix != ""} {

    set multi users

    db_foreach get_users_from_prefix "" {


           multirow append partys $person_id "$first_names $last_name"
       } if_no_rows {

         set multi ""
     }
} elseif { $group_prefix != ""} {

    set multi groups

    db_foreach get_groups_from_prefix "" {


           multirow append partys $cur_group_id $cur_group_name
       } if_no_rows {

         set multi ""
     }


} 





if {$list_members == "true" } {
multirow create users_list  name rel_id member_state

db_foreach get_users_from_this_group "" {

                        multirow append users_list  "$first_names $last_name" $rel_id $member_state

		    } if_no_rows {

		    }




multirow create groups_list  name rel_id



db_foreach get_groups_from_this_group "" {

                        multirow append groups_list $name $rel_id 

		    } if_no_rows {

		    }


}

ad_form -name user_search -action group-edit\#result -form {
    {group_id:text(hidden) {value $group_id}}
    {group_name:text(hidden) {value $group_name}}
    {list_members:text(hidden) {value $list_members}}
    {user_prefix:text(text) {label ""}}
    {sub1:text(submit) {label "Search User"}}
}

ad_form -name group_search -action group-edit\#result -form {
    {group_id:text(hidden) {value $group_id}}
    {group_name:text(hidden) {value $group_name}}
    {list_members:text(hidden) {value $list_members}}
    {group_prefix:text(text) {label ""}}
    {sub2:text(submit) {label "Search Group"}}
}
