ad_page_contract {

    display whether client could login or not
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @creation-date 2002-10-16

} -properties {

    success:onevalue
    success_presence:onevalue

}


set success [jb_login]

set success_presence [jb_setpresence]

ad_return_template