ad_page_contract {
   
    block-group.tcl
    @author Bjoern Kiesbye
    @email bkiesbye@sussdorff-roy.com

} {

 group_prefix:optional
 {show_blocked "true"}
}


if {$show_blocked == "true"} {
multirow create blocked_groups group_name group_id

db_foreach get_blocked_groups "" {


    multirow append blocked_groups $group_name $group_id 
     
  }
}


set searched_rows "false"

if { [info exists group_prefix]} {

    set searched_rows "true"

    multirow create searched_groups group_name group_id
    
    db_foreach get_group_from_prefix "" {
	
	multirow append searched_groups $cur_group_name  $cur_group_id
	
    } if_no_rows {
	
	set searched_rows "false"
    }
}

ad_form -name search -action block-group\#result -form {
    {show_blocked:text(hidden) {value $show_blocked}}
    {group_prefix:text(text) {label ""}}
    {sub1:text(submit) {label "Search"}}
}