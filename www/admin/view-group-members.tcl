ad_page_contract {

    view members of a group
    @author Luis Mosteiro Fernandez
    @creation-date 2002-12-04
    @param group_id which group
    @param user_id to which user

}   {

    group_id:integer
    user_id:integer

} -properties {

    get_group_members:multirow
    member_row_check_p:onevalue

}

set row_count 0

ad_form -name group_members -action add-group-members -form {
    {user_id:text(hidden) {value $user_id}}
}

db_foreach  get_group_members {} {
    set options [list [list "" $person_id]]
    incr row_count
    template::element create group_members group_members.$row_count -datatype text -widget checkbox -label "$first_names $last_name" -options $options
    set member_row_check_p 1

} if_no_rows {
    set member_row_check_p 0
}

ad_form -extend -name group_members -form {
    {rows:integer(hidden) {value $row_count}}
}

ad_return_template

    