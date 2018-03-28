ad_page_contract {

    remove user from the jabber server
    @author Luis Mosteiro Fernandez
    @creation-date 2002-12-10
    @param user_id 
    @param user the Jabber screenname of the user

}   {

    user_id:integer
    user:notnull

}

set user_screen_ids [list]
set delete_screens_check 1
set delete_jabber_information_check 1

# remove user from the Jabber server
set success [jb_remove $user]

# get all screen IDs from user to delete them with the jb_screens_delete func


if {$success == "1"} {

    db_foreach get_screen_ids {} {

	lappend user_screen_ids $screen_id

    }

    # delete rows from the database

    for { set i 0 } {$i <= [llength $user_screen_ids] - 1} {incr i} {

	set user_screen_id [lindex $user_screen_ids $i]

	db_transaction {

	    db_exec_plsql jb_screen_delete {} 
	} on_error {
	    set delete_screens_check 0
	}

    }

    db_transaction {

	db_dml delete_jabber_information {} 

    } on_error {

	set delete_jabber_information_check 0

    }

    if { $delete_screens_check == "1" && $delete_jabber_information == "1" } {
	ns_returnredirect "jabber-users"
    } else {
	ad_return_template
    }
    

} else {

    ad_return_template

}



