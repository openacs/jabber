ad_page_contract {
    
      edit-user-confirm.tcl
      @author: bkiesbye@sussdorff-roy.com , lmosteiro@sussdorff-roy.com

  } {

 service_pretty_name:array
 service:array
 screen_name:array

}
 

multirow create new_im_contacts service pretty_name im_screen_name



for {set search [array startsearch service]} { [array anymore service  $search]} {} {


    set cur_service [array nextelement service $search]



    multirow append new_im_contacts $service($cur_service) $service_pretty_name($cur_service) $screen_name($cur_service)

}