ad_page_contract {

    register user through admin page, uses form like the form in the Jabber index page
    @author Bjoern Kiesbye bkiesbye@sussdorff-roy.com
    @author Luis Mosteiro Fernandez lmosteiro@sussdorff-roy.com
    @creation-date 2003-03-06
    @param user_id which user should be registered
    @param user_prefix 
    @param reg_error error code for failed registration

} {

    user_id:integer,notnull
    {user_prefix ""}
    {reg_error "nothing"}

} -properties {

    connstate:onevalue
    user_id:onevalue
    user_prefix:onevalue

}

set connstate [jb_getconnstate]

ad_form -name user-register -action user-register-3 -form {
    {jscreen:text(text) {label "Jabber screen:"}}
    {passwd:text(password) {label "Password:"}}
    {return_url:text(hidden) {value "index"}}
    {user_id:integer(hidden) {value $user_id}}
    {user_prefix:text(hidden) {value $user_prefix}}
    {Register:text(submit) {value "Register"}}
}