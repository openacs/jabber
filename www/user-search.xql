<?xml version="1.0"?>
<queryset>

<fullquery name="get_friends">      
      <querytext>
      
 Select distinct user_id from jb_screens where screen_id in (Select friend_screen_id from jb_friends where user_id = :user_id)
 and user_id is not null
      </querytext>
</fullquery>

 
<fullquery name="get_users_from_prefix">      
      <querytext>
      
 SELECT distinct p.person_id , p.first_names , p.last_name
 FROM persons p
 WHERE ( lower(p.last_name) like(lower('$user_prefix%')) OR lower(p.first_names) like(lower('$user_prefix%')) )
 and p.person_id NOT IN ([template::util::tcl_to_sql_list $friends_list])


      </querytext>
</fullquery>

 
</queryset>
