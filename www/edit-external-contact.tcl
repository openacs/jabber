ad_page_contract {

    edit external contact
    @author Bjoern Kiesbye
    @creation-date 2003-06-19
    @param friend Frist and Last name of the conntact that should be edited

}   {

    friend_first_name:notnull
    friend_last_name:notnull

} -properties {

    im_screen_name:onevalue
    service:onevalue
    friend_first_name:onevalue
    friend_last_name:onevalue

}

set user_id [ad_conn user_id]
set services_list [list]

db_foreach get_services "" {

    lappend services_list $service
    set services($service) $pretty_name
    set  details_im_screen_name($service) ""
}

db_foreach get_external_contacts_details "" {
ns_log notice "$service / $im_screen_name"
 set details_im_screen_name($service) $im_screen_name
# lappend details_service $service
 
}






template::form create edit-user -action edit-external-contact-confirm

template::element create edit-user friend_first_name -datatype text -widget text -label "First Name:" -value $friend_first_name
template::element create edit-user friend_last_name -datatype text -widget text -label "Last Name:" -value $friend_last_name
template::element create edit-user friend_first_name_old -datatype text -widget hidden  -value $friend_first_name
template::element create edit-user friend_last_name_old -datatype text -widget hidden   -value $friend_last_name



for {set i 0} { $i < [llength $services_list]} { incr i } {

    set err ""

    #    catch { set test "$details_im_screen_name([lindex $services_list $i])" }  err
    #   ns_log notice "err = $err"
    if {$details_im_screen_name([lindex $services_list $i]) != ""} {

	set displayed_im_screen_name $details_im_screen_name([lindex $services_list $i])

	if { [lindex $services_list $i] == "msn"} {
	    regsub -all  "%" $displayed_im_screen_name "@" displayed_im_screen_name
	
	}

	template::element create edit-user im_screen_name.[lindex $services_list $i] -datatype text -widget text -label "$services([lindex $services_list $i]) Screen:" -value "$displayed_im_screen_name"

          
	template::element create edit-user im_screen_name_old.[lindex $services_list $i] -datatype text -widget hidden  -value "$displayed_im_screen_name"

	template::element create edit-user services.$i -datatype text -widget hidden  -value "[lindex $services_list $i]"
    
	template::element create edit-user services_pretty.[lindex $services_list $i] -datatype text -widget hidden  -value "$services([lindex $services_list $i])"
  
    } else {

	set displayed_im_screen_name $details_im_screen_name([lindex $services_list $i])
	template::element create edit-user im_screen_name.[lindex $services_list $i] -datatype text -widget text -label "$services([lindex $services_list $i]) Screen:" -value "$displayed_im_screen_name"

          
	template::element create edit-user im_screen_name_old.[lindex $services_list $i] -datatype text -widget hidden  -value "$displayed_im_screen_name"

	template::element create edit-user services.$i -datatype text -widget hidden  -value "[lindex $services_list $i]"
    
	template::element create edit-user services_pretty.[lindex $services_list $i] -datatype text -widget hidden  -value "$services([lindex $services_list $i])"
    
    
    }
}






ad_return_template