ad_page_contract {
    

    @cvs-id index.tcl,
    @creation-date 25/8/02
    @author bkiesbye@sussdorff-roy.com
    @author lmosteiro@sussdorff-roy.com
    @param reg_error checks, whether input was successful
    
} {

    {reg_error "nothing"}

} -properties {
    
    reg_error_code:onevalue
    reg_error_name:onevalue
    user_status:multirow
    friend_status:multirow
    external_status:multirow
    other_status:multirow
    context:onevalue
    return_url:onevalue
    friends_is_online_p:onevalue
    external_is_online_p:onevalue
    any_is_online_p:onevalue
    
}



#set url_to_conference_group [jb_start_conference_room_for_group_url 15331]

#Check if we are inside a dotlrn Comunity
set community_id [dotlrn_community::get_community_id_from_url]


set system_name [ad_system_name]
set trans_symbol [list]
set return_url [ad_conn url]
set context ""
set user_id [ad_conn user_id]
auth::require_login
set reg_need "0"

set connstate [jb_getconnstate]

set user_invisible [whos_online::check_invisible $user_id ]
set all_invisible [whos_online::all_invisible_user_ids]
if {[llength $all_invisible] == 0 } {lappend all_invisible  0}
set all_users [whos_online::all_user_ids]

#----------------------------------------------------check, whether user is registered-------------------------------------

if { ![db_0or1row is_user_reg_with_jabber {select (user_id) as reg_check, (uc.jabber_regstate) as reg_stat 
    from jb_user_jabber_information uc where user_id = :user_id} ]} {
    set reg_need "1"
} 

ad_form -name user-register -action user-register -form {
    {jscreen:text(text) {label "Jabber Screen:<br>"}}
    {passwd:text(password) {label "Password:<br>"}}
    {return_url:text(hidden) {value "index"}}
}

#-----------------------------------------------------get avaiable services--------------------------------------------------

db_foreach get_services {} {
    set user_states($service) "offline"
    set online_state($service) "offline"
    set online_state_name($service) $service
    set online_ext($service) "offline"
    set online_ext_name($service) $service
    set online_any($service) "offline"
    set online_any_name($service) $service
    append trans_symbol " $service"
}

#-------------------------------------get the different user states for the IM services-----------------------------------------

multirow create user_status service status 

db_foreach get_users_state {} {
    multirow append user_status $service $status 
    set user_states($service) $status
} if_no_rows {

    db_foreach get_services {} {
	multirow append user_status $service "no"
	set user_states($service) "offline"
    }
    
}

set jabber_start "offline"

for {set j 0} { $j < [llength $trans_symbol]} {incr j} {
    if { [lindex $trans_symbol $j] == "jabber" } {
	if { [set user_states([lindex $trans_symbol $j])] == "offline"   } {
	    set jabber_start "offline"
	} else {
	    set jabber_start "online"
	}
    } 
    if { [lindex $trans_symbol $j] == "aim" } {
	if { [set user_states([lindex $trans_symbol $j])] != "offline"   } {
	    set aim_on 1
	} else {
	    set aim_on 0
	}
    } 
}     


set member_is_online_p 0
set onliners [whos_online::user_ids]


#----------------------------------Comunity Members Online------------------------------------------

multirow create member_status first_names last_name member_user_id member_screen_id service status create_jid chat im_screen_name member_is_friend

db_foreach get_members_state { select (persons.person_id) as friends_user_id ,
    persons.first_names as first_names, persons.last_name as last_name 
    from persons , group_distinct_member_map gdmm
    where persons.person_id = gdmm.member_id
    AND gdmm.group_id = :community_id
    AND persons.person_id != :user_id
} { 

    lappend members_online_list $friends_user_id

    if {[db_0or1row check_if_member_is_friend {select jf.friend_screen_id from jb_friends jf, jb_screens js where jf.user_id = :user_id and jf.friend_screen_id = js.screen_id and  js.user_id = :friends_user_id and js.service = 'jabber'} ] } {
	set member_is_friend 1  
    } else {
	set member_is_friend 0
    }
    db_foreach get_his_online_states "" {

	set online_state($service) $status

	multirow append member_status $first_names $last_name $friends_user_id $friend_screen_id $service $status [jb_create_jid $im_screen_name $service] [jb_best_chat $friends_user_id] $im_screen_name $member_is_friend
	    set member_is_online_p 1    
    }

  


}

#-------------------------------internal friend online ------------------------------------------------------------------------------

set friend_is_online_p 0
#set onliners [whos_online::user_ids]

multirow create friend_status first_names last_name friend_user_id friend_screen_id service status create_jid chat im_screen_name


db_foreach get_a_friend ""  {

    lappend friends_online_list $friends_user_id


    db_foreach get_his_online_states "" {
	set online_state($service) $status
	multirow append friend_status $first_names $last_name $friends_user_id $friend_screen_id $service $status [jb_create_jid $im_screen_name $service] [jb_best_chat $friends_user_id] $im_screen_name
	set friend_is_online_p 1    
    }

} 

#--------------------------External friends----------------------------------------------------------------------

set external_is_online_p 0

multirow create external_status friend_screen_id first_names last_name combi_name service status create_jid


db_foreach get_friends_users_online {} {

    db_foreach get_this_online_anys {} {
	set online_ext($service) $status
	multirow append external_status $ef_id $first_names $last_name "$first_names $last_name" $service $status [jb_create_jid $im_screen_name $service]
	set external_is_online_p 1
    }

}


ad_return_template


