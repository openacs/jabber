ad_page_contract {

    add new contact to IM-Adressbook
    inserts new rows in jb_friends
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-22
    @param first_names first names of the new contact
    @param last_name last name of the new contact
    @param screen_name array of screen_names , which should be added

}   {

    first_names:notnull
    last_name:notnull
    screen_name:array

}


set user_id [ad_conn user_id]
auth::require_login 


db_foreach get_services "" {

    set user_screen_name $screen_name($service)
  
  if {$service == "msn"} {
	regsub -all  "@" $user_screen_name "%" user_screen_name
	
    }


    if {![empty_string_p $user_screen_name]} {

	if {![db_0or1row check_screen_id ""]} {

	    db_exec_plsql new_screen {}

	

	db_1row get_new_screen_id {}
	db_transaction {
	    
	    db_dml update_reference {}
	    db_dml insert_into_friends {}
	}


	set success [jb_addtransportbuddy $user_screen_name "online-trace" [jb_get_transport_id_from_symbol $service]]



	} else {

            db_1row get_new_screen_id {}

	    db_transaction {
	    
	    db_dml update_reference {}
	    db_dml insert_into_friends {}
	}

} 
    }
}

ns_returnredirect "index"
