<?xml version="1.0"?>
<queryset>

<fullquery name="get_name">      
      <querytext>
      select first_names , last_name from persons where person_id = :user_id
      </querytext>
</fullquery>

 
<fullquery name="get_services">      
      <querytext>
       Select service , pretty_name from jb_services where active_check_p = 't' 

      </querytext>
</fullquery>

 
<fullquery name="get_screen_name">      
      <querytext>
       Select im_screen_name from jb_screens where service = :service and user_id = :user_id 
      </querytext>
</fullquery>

 
</queryset>
