<?xml version="1.0"?>
<queryset>

<fullquery name="get_users">      
      <querytext>
       
    Select persons.first_names, persons.last_name, persons.person_id 
    from jb_screens, persons
    where persons.person_id = jb_screens.user_id
    and jb_screens.service = 'jabber'

      </querytext>
</fullquery>

 
</queryset>
