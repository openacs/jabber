<?xml version="1.0"?>
<queryset>

<fullquery name="get_services">      
      <querytext>
      Select service , pretty_name from jb_services where active_check_p = 't'
      </querytext>
</fullquery>

 
<fullquery name="get_external_contacts_details">      
      <querytext>
      Select jb_screens.im_screen_name , jb_screens.service  , jb_screens.screen_id
                                 from   jb_screens , jb_friends
                                 where  jb_friends.friend_first_name = :friend_first_name
                                 and    jb_friends.friend_last_name = :friend_last_name
                                 and    jb_friends.friend_screen_id = jb_screens.screen_id
                                 and    jb_friends.user_id = :user_id
      </querytext>
</fullquery>

 
</queryset>
