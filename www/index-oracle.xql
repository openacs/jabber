<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="">      
      <querytext>
	
      </querytext>
</fullquery>

<fullquery name="is_user_reg_with_jabber">      
      <querytext>
	select (user_id) as reg_check, (uc.jabber_regstate) as reg_stat 
    from jb_user_jabber_information uc where user_id = :user_id
      </querytext>
</fullquery>


<fullquery name="get_services">      
      <querytext>
	 Select service from jb_services where active_check_p = 't'
      </querytext>
</fullquery>
      
<fullquery name="get_users_state">      
      <querytext>
    select lower(sn.status) as status,
    lower(sn.service) as service
    FROM jb_screens sn , jb_services
    WHERE sn.user_id = :user_id
    AND sn.service = jb_services.service
    AND jb_services.active_check_p = 't'
      </querytext>
</fullquery>


<fullquery name="get_services">      
      <querytext>
	select service 
	from jb_services 
	where active_check_p = 't'
      </querytext>
</fullquery>

<fullquery name="get_a_friend">      
      <querytext>
	select (persons.person_id) as friends_user_id ,
    persons.first_names as first_names, persons.last_name as last_name 
    from persons 
    where persons.person_id IN (Select jb_screens.user_id from jb_screens, jb_friends
				where jb_friends.user_id = :user_id
				and jb_screens.screen_id = jb_friends.friend_screen_id
				and   jb_screens.user_id IS NOT NULL)
   AND  persons.person_id NOT IN [template::util::tcl_to_sql_list $all_invisible]
      </querytext>
</fullquery>



<fullquery name="get_his_online_states">      
      <querytext>
	SELECT (sn.screen_id) as friend_screen_id,
	(sn.status) as status , 
	sn.im_screen_name,
	lower(sn.service) as service 
	FROM jb_screens sn  
	WHERE sn.user_id = :friends_user_id 
	AND   ( ( lower(sn.status) != 'offline' ) or   (sn.user_id IN [template::util::tcl_to_sql_list $onliners])  ) 
      </querytext>
</fullquery>

<fullquery name="get_friends_users_online">      
      <querytext>
	    select (ef.friend_screen_id) as ef_id , 
    (ef.friend_first_name) as first_names , 
    (ef.friend_last_name) as last_name 
    FROM jb_friends ef  
    WHERE ef.user_id = :user_id
    AND ef.friend_screen_id IN ( Select screen_id from jb_screens 
				where user_id is null )
      </querytext>
</fullquery>


<fullquery name="get_this_online_anys">      
      <querytext>
	 select (sn.status) as status , 
	(sn.service) as service, sn.im_screen_name  
	FROM jb_screens sn 
	WHERE  sn.screen_id = :ef_id      
	AND  sn.status != 'offline'
      </querytext>
</fullquery>

</queryset>
