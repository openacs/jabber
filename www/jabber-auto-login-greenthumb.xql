<?xml version="1.0"?>
<queryset>

<fullquery name="name_pass">      
      <querytext>
      Select (jb_screens.im_screen_name) as jabber_screen , jb_user_jabber_information.jabber_passwd 
                           from jb_user_jabber_information, jb_screens 
                           where jb_user_jabber_information.user_id = :user_id 
                           and jb_screens.user_id = :user_id and jb_screens.service = 'jabber'
      </querytext>
</fullquery>

 
</queryset>
