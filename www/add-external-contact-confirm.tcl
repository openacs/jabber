ad_page_contract {

    add new contact
    @author Bjoern Kiesbye
    @creation-date 2003-01-05
    
} { 

  screen_name:array
  first_names:notnull
  last_name:notnull

} -properties {

    get_services:multirow
    context:onevalue

}

set context [list "Add external contact"]

multirow create new_im_contacts im_screen_name service pretty_name display 

db_foreach get_services  "" {
     
    set im_screen_name $screen_name($service) 


    if {![empty_string_p $im_screen_name]} {

        multirow append new_im_contacts  $im_screen_name  $service  $pretty_name true

    } else {
   
            multirow append new_im_contacts  $im_screen_name  $service  $pretty_name false
    }


}

ad_return_template
