ad_page_contract {

    site to display all users online
    @author Luis Mosteiro Fernandez, lmosteiro@sussdorff-roy.com
    @author Bjoern Kiesbye, bkiesbye@sussdorff-roy.com
    @creation-date 2003-03-26
    @param prefix display users depending on this prefix

} {

    {prefix "A"}

} -properties {

}

set onliners [whos_online::user_ids]
set all_invisible [whos_online::all_invisible_user_ids]
if {[llength $all_invisible] == 0 } {lappend all_invisible  0}
set all_users [whos_online::all_user_ids]

set context [list "Online users"]

set user_id [ad_conn user_id]
ad_maybe_redirect_for_registration

set any_is_online_p 0

multirow create prefix_links prefix
set prefix_list [list A B C D E F G H I J K L M N O P Q R S T U V W X Y Z All]
for {set j 0} { $j < [llength $prefix_list]} {incr j} {
    multirow append prefix_links [lindex $prefix_list $j]
}

multirow create other_status any_user_id any_screen_id first_names last_name service status create_jid chat


# query to get users within the OACS who are online in Jabber and who are not explicit friends

if {![string equal $prefix "All"]} { 

db_foreach get_all_other_users_online "" {
    set online_any($service) $status
    multirow append other_status $any_user_id $screen_id $first_names $last_name $service $status [jb_create_jid $im_screen_name $service] [jb_best_chat $any_user_id] 
    set any_is_online_p 1
} 

} else {

db_foreach get_all_users_online "" {
    set online_any($service) $status
    multirow append other_status $any_user_id $screen_id $first_names $last_name $service $status [jb_create_jid $im_screen_name $service] [jb_best_chat $any_user_id] 
    set any_is_online_p 1
} 

}
