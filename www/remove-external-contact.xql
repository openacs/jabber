<?xml version="1.0"?>
<queryset>

<fullquery name="remove_friend">      
      <querytext>
       delete from jb_friends where user_id = :user_id and friend_screen_id = :screen_id 
      </querytext>
</fullquery>

 
<fullquery name="decrease_reference">      
      <querytext>
       update jb_screens set refcount = refcount - 1 where screen_id = :screen_id 
      </querytext>
</fullquery>

 
</queryset>
