<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>



<fullquery name="get_all_other_users_online">      
      <querytext>
    select pr.first_names , pr.last_name , 
    (pr.person_id) as any_user_id , sn.screen_id, sn.status, sn.service, sn.im_screen_name
    from persons pr , jb_screens sn 
    where pr.person_id = sn.user_id
    and lower(pr.last_name) like(lower('$prefix%')) 
    and sn.user_id != :user_id
    and sn.user_id NOT IN ([template::util::tcl_to_sql_list $all_invisible])
    and ( (sn.status != 'offline') OR sn.user_id IN ([template::util::tcl_to_sql_list $onliners]) )
    and sn.screen_id not in (Select friend_screen_id from jb_friends where user_id = :user_id)
    ORDER BY any_user_id    
      </querytext>
</fullquery>


<fullquery name="get_all_users_online">      
      <querytext>
    select pr.first_names , pr.last_name , 
    (pr.person_id) as any_user_id , sn.screen_id, sn.status, sn.service, sn.im_screen_name
    from persons pr , jb_screens sn 
    where pr.person_id = sn.user_id 
    and sn.user_id != :user_id
    and sn.user_id NOT IN ([template::util::tcl_to_sql_list $all_invisible])
    and ( (sn.status != 'offline') OR sn.user_id IN ([template::util::tcl_to_sql_list $onliners]) )
    and sn.screen_id not in (Select friend_screen_id from jb_friends where user_id = :user_id)
    ORDER BY last_name    
      </querytext>
</fullquery>

</queryset>
