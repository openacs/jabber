<?xml version="1.0"?>
<queryset>

<fullquery name="get_jabber_screen_name">      
      <querytext>
      Select (im_screen_name) as user_screen from jb_screens where user_id = :user_id and service = 'jabber'
      </querytext>
</fullquery>

 
<fullquery name="get_jabber_screen_name_from_add_user">      
      <querytext>
      Select im_screen_name , screen_id from jb_screens where user_id = :add_user_id and service = 'jabber'
      </querytext>
</fullquery>

 
<fullquery name="check_friend">      
      <querytext>
      Select * from jb_friends where user_id = :user_id and friend_screen_id = :screen_id
      </querytext>
</fullquery>

 
<fullquery name="insert_into_jb_friends">      
      <querytext>
      insert into jb_friends (user_id , friend_screen_id) values (:user_id , :screen_id)
      </querytext>
</fullquery>

 
<fullquery name="update_reference_count">      
      <querytext>
      update jb_screens SET refcount = refcount + 1 where user_id = :add_user_id and service = 'jabber'
      </querytext>
</fullquery>

 
</queryset>
