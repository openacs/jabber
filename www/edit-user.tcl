ad_page_contract {

    edit user IM-contact information
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-22

} -properties {

    first_names:onevalue
    last_name:onevalue
    get_existing_screen:multirow
    context:onevalue

}

set context [list "Edit contact information"]

set user_id [ad_conn user_id]
auth::require_login


db_1row get_name ""

template::form create edit-user -action edit-user-confirm

db_foreach get_services {} {    
    set im_screen_name ""
    db_0or1row get_screen_name {}

    if {$service == "msn"} {
	regsub -all  "%" $im_screen_name "@" im_screen_name
	
    }

    template::element create edit-user screen_name.$service -datatype text -widget text -label "$pretty_name screen name" -value $im_screen_name
    template::element create edit-user service_pretty_name.$service -datatype text -widget hidden -value $pretty_name
    template::element create edit-user service.$service -datatype text -widget hidden -value $service
      
}

ad_return_template
