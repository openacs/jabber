ad_page_contract {

    displays whether chat started or not
    @author Bjoern Kiesbye, Luis Mosteiro Fernandez
    @param user1 
    @param user2 

}   {

    user1:notnull
    user2:notnull

} -properties {

    user1:onevalue
    user2:onevalue
    success:onevalue

}

set success  [jb_chat $user1 $user2]

 
ad_return_template




