<?xml version="1.0"?>
<queryset>

<fullquery name="get_screens">      
      <querytext>
      Select (sn.im_screen_name) as screen, (sn.user_id) as cur 
    from jb_screens sn 
    WHERE  (sn.user_id = :user_id or sn.user_id = :user_id_friend) 
    AND sn.service = 'jabber'
      </querytext>
</fullquery>

 
</queryset>
