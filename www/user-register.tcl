ad_page_contract {

    register user in jabber
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation_date 2002-10-17
    @param user_id
    @param user which jabber screen name
    @param pass password for login

}   {

    jscreen:notnull
    passwd:notnull

} -properties {

    user_id:onevalue
    user:onevalue
    errormsg:onevalue
    insert_check_p:onevalue
    passwd:onevalue

}

set user_id [ad_conn user_id]
set creation_user [ad_conn user_id]
auth::require_login

set peeraddr [ad_conn peeraddr]




set success [jb_register $jscreen $passwd] 

if {$success  == "r" } {
    
    db_exec_plsql new_screen {}
    
    db_dml create_contact {insert into jb_user_jabber_information (user_id , jabber_regstate, jabber_passwd) values (:user_id , 'r', :passwd)} 
    ns_returnredirect "index?reg_error=success"
    set insert_check_p 1
    
} elseif {$success == "e"} {  
    
    ns_returnredirect "index?reg_error=exists"
    
    set insert_check_p 2
    
} else {

    ns_returnredirect "index?reg_error=offline"    
    set insert_check_p 3
    
}






ad_return_template









