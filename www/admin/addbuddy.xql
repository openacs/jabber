<?xml version="1.0"?>
<queryset>

<fullquery name="get_internal_users">      
      <querytext>
      
    Select persons.first_names, persons.last_name, persons.person_id , jb_screens.im_screen_name 
    from jb_screens, persons
    where persons.person_id = jb_screens.user_id
    and jb_screens.service = 'jabber'
    and persons.person_id != :user_id
    and jb_screens.screen_id not in (Select friend_screen_id from jb_friends where user_id = :user_id)
   

      </querytext>
</fullquery>

 
</queryset>
