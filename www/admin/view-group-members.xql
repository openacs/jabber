<?xml version="1.0"?>
<queryset>

<fullquery name="get_group_members">      
      <querytext>
      
    Select pe.person_id , pe.first_names , pe.last_name 
    from persons pe, group_approved_member_map grm , jb_screens js
    where grm.group_id = :group_id
    and pe.person_id = grm.member_id
    and pe.person_id = js.user_id
    and js.service = 'jabber'
    and pe.person_id != :user_id
    and js.screen_id not in (Select friend_screen_id from jb_friends where user_id = :user_id)

      </querytext>
</fullquery>

 
</queryset>
