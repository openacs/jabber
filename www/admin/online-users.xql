<?xml version="1.0"?>
<queryset>

<fullquery name="get_users">      
      <querytext>
      select * from jb_screens where status != 'offline'
      </querytext>
</fullquery>


<fullquery name="reg_request">      
      <querytext>
select im_screen_name from jb_screens where user_id= :user_id and service = 'jabber'
      </querytext>
</fullquery>


 
</queryset>
