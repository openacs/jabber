

ad_page_contract {
    
    send message via index page
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-29
    @param screen_id 
    @param screen
    
} {
    
    screen_id:integer
    screen:notnull

} -properties {

    screen_id:onevalue
    screen:onevalue

}


set user_id [ad_conn user_id]
auth::require_login

ad_form -name message -action message-2 -form {
    {screen:text(hidden) {value $screen}}
    {screen_id:text(hidden) {value $screen_id}}
    {message:text(textarea) {html {cols 25}} {html {rows 5}} {label "Message:"}}
}

ad_return_template







