<?xml version="1.0"?>
<queryset>

<fullquery name="get_user_screen_name">      
      <querytext>
      Select im_screen_name from jb_screens where user_id = :user_id and service = 'jabber'
      </querytext>
</fullquery>

 
<fullquery name="get_screen_id">      
      <querytext>
      Select screen_id from jb_screens where im_screen_name = :screen_name and service = 'jabber'
      </querytext>
</fullquery>

 
<fullquery name="update_reference">      
      <querytext>
      update jb_screens SET refcount = refcount + 1 where im_screen_name = :screen_name and service = 'jabber'
      </querytext>
</fullquery>

 
<fullquery name="insert_into_jb_friends">      
      <querytext>
      insert into jb_friends (user_id , friend_screen_id) values (:user_id , :screen_id)
      </querytext>
</fullquery>

 
</queryset>
