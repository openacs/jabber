<?xml version="1.0"?>
<queryset>

<fullquery name="get_user_jid">      
      <querytext>
      SELECT im_screen_name FROM jb_screens WHERE user_id = :user_id AND service = 'jabber'
      </querytext>
</fullquery>

 
</queryset>
