ad_page_contract {

    edit external contact
    @author Bjoern Kiesbye
    @creation-date 2003-06-19
    @param friend Frist and Last name of the conntact that should be edited

}   {

    friend_first_name
    friend_last_name
    friend_last_name_old
    friend_first_name_old
    im_screen_name:array
    im_screen_name_old:array
    services:array
    services_pretty:array



} -properties {

    new_im_contacts
    friend_first_name:onevalue
    friend_last_name:onevalue
    friend_last_name_old:onevalue
    friend_first_name_old:onevalue
}



multirow create new_im_contacts service pretty_name im_screen_name im_screen_name_old



for {set search [array startsearch services]} { [array anymore services  $search]} {} {


    set cur_service_1 [array nextelement services $search]
    set cur_service $services($cur_service_1)
ns_log notice "cur_service = $cur_service , services(cur_service) = $services($cur_service_1)"

    multirow append new_im_contacts $cur_service $services_pretty($cur_service) $im_screen_name($cur_service) $im_screen_name_old($cur_service)

}

ad_return_template