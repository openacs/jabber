<?xml version="1.0"?>
<queryset>

<fullquery name="get_internal">      
      <querytext>
      
    Select persons.first_names, persons.last_name, jb_screens.screen_id, jb_screens.service
    from jb_screens, persons
    where persons.person_id = jb_screens.user_id
    and jb_screens.user_id is not null
    and jb_screens.screen_id IN (Select friend_screen_id from jb_friends where user_id = :user_id)

      </querytext>
</fullquery>

 
<fullquery name="get_external">      
      <querytext>
      
    Select jb_friends.friend_first_name, jb_friends.friend_last_name , jb_screens.screen_id , jb_screens.service 
    from jb_friends , jb_screens 
    where jb_friends.user_id = :user_id 
    and friend_first_name is not null 
    and friend_last_name is not null
    and jb_friends.friend_screen_id = jb_screens.screen_id

      </querytext>
</fullquery>

 
</queryset>
