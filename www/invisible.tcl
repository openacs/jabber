ad_page_contract {
    

    @cvs-id invisible.tcl,
    @creation-date 18/3/03
    @author bkiesbye@sussdorff-roy.com

    
} {

    type:notnull
    {return_url "[apm_package_url_from_key jabber]"}

}

set user_id [ad_conn user_id]

if {$type == "set"} {

    whos_online::set_invisible $user_id

} elseif { $type == "unset"} {

    whos_online::unset_invisible $user_id
}

ns_returnredirect $return_url