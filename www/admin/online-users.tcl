ad_page_contract {

    display users who are online
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-17

} -properties {

    caller:onevalue
    ltext:onevalue
    get_users:multirow
    online_check_p:onevalue
    statecolour:onevalue

}


set user_id [ad_conn user_id]
ad_maybe_redirect_for_registration



if { [db_0or1row reg_request {}] } { 
    set caller $im_screen_name
    set ltext "Start chat"
} else {
    set caller ""
    set ltext "You are not registered"
}


multirow create get_users screen_id status statecolour im_screen_name service resource
db_foreach get_users "select * from jb_screens where status != 'offline'" {
    
    set online_check_p 1
    
    if { $status == "online" } {
         set statecolour "green"
    } elseif { $status == "away" } {
         set statecolour "mediumslateblue"
    } elseif { $status == "dnd" } {
         set statecolour "navy"
    } else { 
	set statecolour "black"
    }
 
    multirow append get_users $screen_id $status $statecolour $im_screen_name $service $resourc 
} if_no_rows {
 
    set online_check_p 0

}  


ad_return_template