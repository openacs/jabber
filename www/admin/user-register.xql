<?xml version="1.0"?>
<queryset>

<fullquery name="">      
      <querytext>
      SELECT distinct person_id , first_names , last_name FROM persons p  WHERE (lower(p.last_name) like(lower('$user_prefix%')) OR lower(p.first_names) like(lower('$user_prefix%'))) and p.person_id not in (Select distinct user_id from jb_screens where user_id is not null)
      </querytext>
</fullquery>

 
</queryset>
