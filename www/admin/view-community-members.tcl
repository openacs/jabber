ad_page_contract {

    view members of an dotlrn community
    @author Luis Mosteiro Fernandez
    @creation-date 2002-12-04
    @param community_id

}   {

    community_id:integer
    user_id:integer

} -properties {

    users:multirow

}

#Get members
set community_members [dotlrn_community::list_users $community_id]

template::util::list_of_ns_sets_to_multirow \
    -rows $community_members \
    -var_name "users"

ad_return_template