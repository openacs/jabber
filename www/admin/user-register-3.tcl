ad_page_contract {

    final registration process, checks, whether registration was successful, throws exception and redirects to registration form
    @author Bjoern Kiesbye bkiesbye@sussdorff-roy.com
    @author Luis Mosteiro Fernandez lmosteiro@sussdorff-roy.com
    @creation-date 2003-03-06
    @param user_id which user should be registered
    @param jscreen which name should the user have
    @param passwd which password will the user have
    @param user_prefix

} {

    user_id:integer,notnull
    jscreen:notnull
    passwd:notnull
    {user_prefix ""}

} -properties {

}



set success [jb_register $jscreen $passwd] 

if {$success  == "r" } {
    
    db_exec_plsql new_screen {}
    
    db_dml create_contact {} 
    ns_returnredirect "user-register?user_prefix=$user_prefix"
    set insert_check_p 1
    
} elseif {$success == "e"} {  
    
    ns_returnredirect "user-register-2?reg_error=exists&user_id=$user_id"
    
    set insert_check_p 2
    
} else {

    ns_returnredirect "user-register-2?reg_error=offline&user_id=$user_id"    
    set insert_check_p 3
    
}

ad_return_template



