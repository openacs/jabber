<?xml version="1.0"?>
<queryset>

<fullquery name="get_screen_ids">      
      <querytext>
       Select screen_id from jb_screens where user_id = :user_id 
      </querytext>
</fullquery>

 
<fullquery name="delete_jabber_information">      
      <querytext>
      delete from jb_user_jabber_information where user_id = :user_id 
      </querytext>
</fullquery>

 
</queryset>
