ad_page_contract {

    updates existing user preferences
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-22
    @param screen_name array of new/old screen names
    
}   {

    screen_name:array

}


set user_id [ad_conn user_id]
set db_nulling [db_null]
set peeraddr [ad_conn peeraddr]
ns_log debug "edit-user-2  1"

db_foreach get_services "Select service from jb_services where active_check_p = 't'" {
    set screen_id "-1"
    set refcount "0"
    set user_screen_name $screen_name($service)  
    if {$service == "msn"} {
	regsub -all  "@" $user_screen_name "%" user_screen_name
	
    }

    if {[empty_string_p $screen_name($service)]} {
          ns_log debug "edit-user-2  2 $user_screen_name"
          #the user did not enter a screen for this service, so just remove old stuff
	if {[db_0or1row get_screen_id "SELECT screen_id , refcount , im_screen_name
                                       FROM jb_screens 
                                       WHERE user_id = :user_id 
                                       AND service = :service"]} {
            ns_log debug "edit-user-2  2.1"

            #we have a screen for this user_id and no new , so we have to 1. completely remove the screen from jb_screens if no one else
            #is interestet in this screen refcount = 1 and remove it from the jabber roster.
            #2. just delete the user_id from the screen_id
	    
	    set old_screen_name $im_screen_name

            if { $refcount == 1 } {

		set old_screen_id $screen_id

		db_exec_plsql jb_screen_delete {
		    begin
		    jb_screen.delete(:screen_id);
		    end;
		}
		
		set old_screen_id ""
		
	#	db_dml delete_screen "delete from jb_screens where user_id = :user_id and service = :service"
		set success [jb_removetransportbuddy $old_screen_name [jb_get_transport_id_from_symbol $service]]              
                

	    } else {
                 ns_log debug "edit-user-2  2.1.2"
		
		db_dml update_screen "UPDATE  jb_screens SET user_id = :db_nulling WHERE user_id = :user_id AND service = :service"
	    }


	} else { ns_log debug "edit-user-2  2.2"
            # we have no screen in the db , and no new one , nothing to do.
	}
    } else {
            ns_log debug "edit-user-2  3"
           #we have a new screen , see if we have one in the jb_screens table

	if {[db_0or1row  get_screen_id "select (screen_id) as old_screen_id , (im_screen_name) as old_screen_name , refcount from jb_screens where user_id = :user_id and service = :service"]} {
	    ns_log debug "edit-user-2  3.1"
               #we have a screen in the db , see if it's a new one.
            if { $old_screen_name != $user_screen_name } { 
		ns_log debug "edit-user-2  3.1.1"
		#we have a new screen , see if we can just update the OLD table column
		if { [db_0or1row check_new_screen_exists "SELECT (screen_id) as new_screen_id  
                                                         FROM jb_screens 
                                                         WHERE im_screen_name = :user_screen_name 
                                                         AND service = :service"]} {

		    ns_log debug "edit-user-2  3.1.1.1"
		    #ok we already have a new screen_id for this screen, so remove the user_id from the old screen_id and may drop the whole
                    #column , or just update the user_id , old column to null and the new one to :user_id  
		    if { $refcount == 1 } {
			ns_log debug "edit-user-2  3.1.1.1.1"
                       # no one is interested  in the old screen so remove the whole column 
                       # we have to do it with the delete function (ACSOBJECT)
                       # till then we just delete the user_id 


			db_exec_plsql jb_screen_delete ""
				    
                       
		       set success [jb_removetransportbuddy $old_screen_name [jb_get_transport_id_from_symbol $service]]              

		    } else {
			ns_log debug "edit-user-2  3.1.1.1.2"
			#just remove the user_id in the old column , and put it in the new column
			db_dml remove_old_user_id "UPDATE jb_screens SET user_id = :db_nulling WHERE screen_id = :old_screen_id"  
			db_dml update_new_screens_column "UPDATE jb_screens SET user_id = :user_id WHERE screen_id = :new_screen_id"  
                   
		    }

		} else {
		    ns_log debug "edit-user-2  3.1.1.2"
		    #the new screen doesn't exists jet create a new one and delete the user_id from the old 
                   
		     if { $refcount == 1 } {
ns_log debug "edit-user-2  3.1.1.2.1"
                       # no one is interested  in the old screen so remove the whole column 
                       # we have to do it with the delete function (ACSOBJECT)
                       # till then we just delete the user_id 

                       
                         db_exec_plsql jb_screen_delete ""
				    
			 set success [jb_removetransportbuddy $old_screen_name [jb_get_transport_id_from_symbol $service]]              

		   } else {
ns_log debug "edit-user-2  3.1.1.2.2"
		       #just remove the user_id in the old column 
                       db_dml remove_old_user_id "UPDATE jb_screens SET user_id = :db_nulling WHERE screen_id = :old_screen_id"  

                   }

		     #create a new jb_screen object for the new screen name
		       db_exec_plsql new_screen {}

		       #now add the new screen to the jabber roster
		       set success [jb_addtransportbuddy $user_screen_name "online-trace" [jb_get_transport_id_from_symbol $service]]

		   }

                
	    } else {
ns_log debug "edit-user-2  3.1.2"

                  #old and new screen name match so do nothing
	    }
	} else {
ns_log debug "edit-user-2  3.2"
         #we have no old_screen_id for this user_id, so check if we have to fully create a new one, or just inserting the old user_id.
	    if { [db_0or1row check_new_screen_exists "SELECT (screen_id) as new_screen_id  
                                                      FROM jb_screens 
                                                      WHERE im_screen_name = :user_screen_name 
                                                      AND service = :service"]} { 

 
         #just update the user_id column 
          db_dml insert_new_user_id "UPDATE jb_screens SET user_id = :user_id WHERE screen_id = :new_screen_id"       
                

      } else {
	    db_exec_plsql new_screen {}
	    
	    #now add the new screen to the jabber roster
	    set success [jb_addtransportbuddy $user_screen_name "online-trace" [jb_get_transport_id_from_symbol $service]]
      }
	} 
    }
}          
	
ad_returnredirect "index.tcl"
