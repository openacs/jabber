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
    multi:onevalue

}

set multi ""


ad_form -name search -action user-register\#result -form {
    {user_prefix:text(text) {value $user_prefix} {label ""}}
    {Search:text(submit) {value "Search"}}
}



multirow create partys party_id name

if {$user_prefix != ""} {


    set multi users
   
   
 
	db_foreach get_users_from_prefix  "" {
	    
	    multirow append partys $person_id "$first_names $last_name"
	    
	} if_no_rows {
	    
	    set multi ""
	}
   
}

ad_return_template


#