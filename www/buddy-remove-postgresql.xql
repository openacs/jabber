<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>



<fullquery name="get_jids">      
      <querytext>
      select (sn.user_id) as user_id_cur, (sn.im_screen_name) as jabber_screen from jb_screens sn where (sn.user_id = :user_id or sn.user_id = :user_id_friend) and sn.service = 'jabber'
      </querytext>
</fullquery>


<fullquery name="get_screen_ids">      
      <querytext>
      	select screen_id from jb_screens where user_id = :friend_id
      </querytext>
</fullquery>



<fullquery name="remove_buddy">      
      <querytext>
      delete from jb_friends where user_id = :user_id and friend_screen_id = :screen_id
      </querytext>
</fullquery>


<fullquery name="update_refcount">      
      <querytext>
      	UPDATE jb_screens set refcount = (refcount -1) where screen_id = :screen_id
      </querytext>
</fullquery>

</queryset>
