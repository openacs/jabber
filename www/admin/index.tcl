ad_page_contract {

    jabber-admin.tcl
    Admin Page for Jabber server
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-16

} -properties {

    url:onevalue
    state:onevalue
    user_id:onevalue

}


    set url [ad_conn url]
    set jconn [jb_getconnstate]             
    
    if {$jconn == "-1"} {
	set state 0
    } else {
	set state 1
    }

    set user_id [ad_conn user_id]
    auth::require_login

# define the different forms

ad_form -name login -action client -form {
    {Login:text(submit) {label "Log In"}}
}

ad_form -name logout -action logout -form {
    {Logout:text(submit) {label "Log Out"}}
}

ad_form -name service-add -action service-add -form {
    {service:text(text) {label "Service Name:<br>(Database reference name)"}}
    {pretty_name:text(text) {label "Pretty Name:"}}
}

ad_form -name message -action message2 -form {
    {receive_user:text(text) {label "Username:"}}
    {message:text(textarea) {html {cols 25}} {html {rows 5}} {label "Message:"}} 
    {Send:text(submit)}
}

ad_form -name chat -action chatstart -form {
    {user1:text(text) {label "1.User:"}}
    {user2:text(text) {label "2.User:"}}
    {Chat:text(submit)}
} 

ad_return_template



