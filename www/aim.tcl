ad_page_contract {

    aim.tcl
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-16
    @param return_url to which url do you want to send the information
    @param screen 

} {

    {return_url "index"} 
    screen:notnull

} -properties {

    screen:onevalue
    return_url:onevalue
    aim_value:onevalue

}

set aim_value $screen
regsub -all  {[@][^ ]+} $screen ""  screen
ns_log notice "AIM PAGE $screen $aim_value"

ad_form -name message -action message-2 -form {
    {screen:text(hidden) {value $aim_value}}
    {return_url:text(hidden) {value $return_url}}
    {message:text(textarea) {html {cols 25}} {html {rows 5}} {label "Message:"}}
}

ad_return_template