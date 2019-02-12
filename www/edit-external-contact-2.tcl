ad_page_contract {

    updates the database

    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-23
    @param screen_id who should be updated
    @param first_names new value for first_names
    @param last_name new value for last_name
    @param im_screen_name new value for im_screen_name

}   {
    friend_first_name
    friend_last_name
    friend_last_name_old
    friend_first_name_old
    im_screen_name:array
    im_screen_name_old:array
    services:array
} -properties {

}

set user_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]
set db_nulling ""

if {$friend_first_name != $friend_first_name_old} {

    db_dml update_first_name "UPDATE jb_friends SET friend_first_name = :friend_first_name
                              WHERE friend_first_name = :friend_first_name_old
                              AND friend_last_name = :friend_last_name_old
                              AND user_id = :user_id"

    set friend_first_name_old "$friend_first_name"

}

if {$friend_last_name != $friend_last_name_old} {

    db_dml update_first_name "UPDATE jb_friends SET friend_last_name = :friend_last_name
                              WHERE friend_first_name = :friend_first_name_old
                              AND friend_last_name = :friend_last_name_old
                              AND user_id = :user_id"

    set friend_last_name_old "$friend_last_name"

}

for {set search [array startsearch services]} { [array anymore services  $search]} {} {

    set cur_service_1 [array nextelement services $search]
    set cur_service $services($cur_service_1)
    ns_log notice "cur_service = $cur_service , services(cur_service) = $services($cur_service_1)"

    set old_screen $im_screen_name_old($cur_service)
    set new_screen $im_screen_name($cur_service)

    if {$new_screen != $old_screen} {

        if {$cur_service == "msn"} {
            regsub -all  "@" $old_screen "%" old_screen
            regsub -all  "@" $new_screen "%" new_screen
        }

        if {$old_screen != "" } {

            #remove from friends list

            db_1row get_old_screen_id "SELECT (screen_id) as old_screen_id , refcount FROM jb_screens WHERE im_screen_name = :old_screen AND service = :cur_service"

            db_dml delete_from_friendslist "DELETE FROM jb_friends
            WHERE friend_screen_id = :old_screen_id
            AND user_id = :user_id"

            if {$refcount > 1} {
                set refcount [expr $refcount - 1]
                db_dml update_refcount "UPDATE jb_screens SET refcount = :refcount  WHERE im_screen_name = :old_screen AND service = :cur_service"
            } else {

                db_exec_plsql jb_screen_delete ""

                set success [jb_removetransportbuddy $old_screen [jb_get_transport_id_from_symbol $cur_service]]

            }

        }

        if { $new_screen != "" } {
            # check if we alreddy have this screen in the jb_screens table
            if { [ db_0or1row get_new_screen_id "SELECT (screen_id) as new_screen_id , (refcount) as new_refcount FROM jb_screens WHERE im_screen_name = :new_screen AND service = :cur_service"]} {


                #we know this screen just update the friends table.

                db_dml insert_new_frind "INSERT INTO jb_friends (friend_first_name , friend_last_name , friend_screen_id , user_id) values (:friend_first_name_old , :friend_last_name_old , :new_screen_id , :user_id)"

                set new_refcount [expr $new_refcount +1]

                db_dml update_refcount_with_screen_id "UPDATE jb_screens SET refcount = :new_refcount WHERE screen_id = :new_screen_id"


            } else {

                #we have a total new screen

                #create a new jb_screen object for the new screen name
                db_exec_plsql new_screen {}

                #now add the new screen to the jabber roster
                set success [jb_addtransportbuddy $new_screen "online-trace" [jb_get_transport_id_from_symbol $cur_service]]

                db_1row get_new_screen_id "SELECT (screen_id) as new_screen_id , (refcount) as new_refcount
                FROM jb_screens
                WHERE im_screen_name = :new_screen
                AND service = :cur_service"

                db_dml insert_new_frind "INSERT INTO jb_friends (friend_first_name , friend_last_name , friend_screen_id , user_id)
                VALUES (:friend_first_name_old , :friend_last_name_old , :new_screen_id , :user_id)"

            }
        }
    }
}

ad_returnredirect "view-external-contacts"

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
