ad_page_contract {

    user-register.tcl
    Admin Page to register a user
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-03-05
    @param user_prefix search for user with this user_prefix, so admin can register them

} {

    {user_prefix ""}

} -properties {

    partys:multirow
    row_check_p:onevalue

}

set row_check_p 0
set context "Search"


ad_form -name search -action user-search\#result -form {
    {user_prefix:text(text) {value $user_prefix} {label ""}}
    {Search:text(submit) {value "Search"}}
}


set user_id [ad_conn user_id]
auth::require_login


multirow create partys person_id first_names last_name 

if {$user_prefix != ""} {

    set friends_list [list $user_id]

    db_foreach get_friends "" {
     lappend friends_list $user_id
 }


    db_foreach get_users_from_prefix "" {

	set row_check_p 1    
	multirow append partys $person_id $first_names $last_name 
	    
    } if_no_rows {
	
	set row_check_p -1
    }
   
}

set return_url "user-search?user_prefix=$user_prefix"

ad_return_template


