<?xml version="1.0"?>
<queryset>

<fullquery name="get_external_friends">      
      <querytext>
      
 Select distinct friend_first_name , friend_last_name , friend_screen_id 
    from   jb_friends , jb_screens
    where  jb_screens.user_id is null
    and    jb_screens.screen_id = jb_friends.friend_screen_id
    and    jb_friends.user_id = :user_id
    order by friend_last_name



      </querytext>
</fullquery>

 
</queryset>
