ad_page_contract {

    add new contact
    @author Luis Mosteiro Fernandez
    @creation-date 2002-10-22
    
} -properties {

    context:onevalue

}

set context [list "Add external contact"]

ad_form -name add-external -action add-external-contact-confirm -form {
    {first_names:text(text) {label "First Names:<br>"}}
    {last_name:text(text) {label "Last Name:<br>"}}
}

db_foreach get_services "" {

    template::element create add-external screen_name.$service -datatype text -widget text -label "$pretty_name screen:<br>"     

}

ad_return_template
