<?xml version="1.0"?>
<queryset>

<fullquery name="check_dotlrn">      
      <querytext>
      select * from apm_packages where instance_name = 'dotlrn'
      </querytext>
</fullquery>

 
<fullquery name="get_groups">      
      <querytext>
      

    select gr.group_name , gr.group_id
    from groups gr, group_approved_member_map grm 
    where grm.member_id = :user_id 
    and gr.group_id = grm.group_id
    and gr.group_id > 1
    and gr.group_name != 'Main Site Parties'  
    and gr.group_name != 'subsite Parties'
   

      </querytext>
</fullquery>

 
</queryset>
