ad_page_contract {

    view the communities the user is member of
    @author Luis Mosteiro Fernandez
    @creation-date 2002-12-4
    @param user_id which user

}   {

    user_id:integer

} -properties {

    dotlrn_row_check_p:onevalue
    get_dotlrn_communities:multirow
    groups_row_check_p:onevalue
    get_groups:multirow
    user_id:onevalue

}


set dotlrn_row_check_p 0


if {![db_0or1row check_dotlrn "select * from apm_packages where instance_name = 'dotlrn'"]} { 

db_multirow get_dotlrn_communities get_dotlrn_communities {} {

    set dotlrn_row_check_p 1

} if_no_rows {

    set dotlrn_row_check_p 0

}

}


db_multirow get_groups get_groups {} {

    set groups_row_check_p 1

} if_no_rows {

    set groups_row_check_p 0

}

ad_return_template