ad_page_contract {

    add selected group members
    @author Luis Mosteiro Fernandez
    @creation-date 2002-12-04
    @param user_id to which user
    @param group_members array of user_ids, which should be added
    @param rows, we need this variable for our loop through the array

}   {

    user_id:integer
    group_members:array
    rows:integer

} 

for {set i 1} { $i <= $rows} {incr i} {

    if {[info exists group_members($i)]} {
	set add_user_id $group_members($i)
	
	#get screen_names
	db_0or1row get_jabber_screen_name {}
	db_0or1row get_jabber_screen_name_from_add_user {}
	#insert into jb_friends and update jb_screens
	if {![db_0or1row check_friend ""]} {
	    db_dml insert_into_jb_friends {}
	} 
	db_dml update_reference_count {}
	#add buddy to Jabber roster
	set success [jb_addbuddy $user_screen $im_screen_name]

    }
}


ns_returnredirect "index"