<?xml version="1.0"?>
<queryset>

<fullquery name="get_user_jid">      
      <querytext>
       Select im_screen_name from jb_screens where user_id = :user_id and service = 'jabber' 
      </querytext>
</fullquery>

 
<fullquery name="get_friend_screen_name">      
      <querytext>
       Select (im_screen_name) as friend_screen_name from jb_screens where screen_id = :screen_id 
      </querytext>
</fullquery>

 
<fullquery name="remove_from_jb_friends">      
      <querytext>
       delete from jb_friends where user_id = :user_id and friend_screen_id = :screen_id 
      </querytext>
</fullquery>

 
<fullquery name="decrease_reference">      
      <querytext>
       update jb_screens SET refcount = refcount - 1 where screen_id = :screen_id 
      </querytext>
</fullquery>

 
</queryset>
