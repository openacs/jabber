<?xml version="1.0"?>
<queryset>

<fullquery name="get_users">      
      <querytext>
      
    Select (un.user_id) as user_id , (sn.im_screen_name) as screen_name ,
           (un.jabber_passwd) as pass , (un.jabber_regstate) as regstate
    from jb_screens sn , jb_user_jabber_information un
    where un.user_id = sn.user_id and sn.service = 'jabber'
      </querytext>
</fullquery>

 
</queryset>
