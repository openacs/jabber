ad_page_contract {

   @email bkiesbye@sussdorff-roy.com
} {
 room_name:notnull
 group_id:notnull,integer
}

template::form create invite -action invite-group-2

set context 0
set user_checkbox_options [list]


multirow create users_table first_name last_name screen  status



db_foreach get_users_from_group "" {



append screen "@"
append screen [jb_get_transport_url_from_id [jb_get_transport_id_from_symbol jabber ]]


set user_checkbox_options [concat [list [list "$first_name $last_name" $screen]] $user_checkbox_options]
multirow append users_table $first_name $last_name $screen [jb_get_link_color_from_state $status] 
                    

} if_no_rows {


 set is_users_table "false"
}

# form template invite    

template::element create invite jids -datatype text -widget checkbox -label "Select users" -options $user_checkbox_options -optional
template::element create invite room_subject -datatype text -widget text -label "The topic you want to discuss:" -optional
template::element create invite msg -datatype text -widget textarea -label "A short message to<br> the user you want to invite:" -optional
template::element create invite room_name -datatype text -widget hidden -label -value $room_name
template::element create invite sub-invite -datatype text -widget submit -label "Invite"

