<?xml version="1.0"?>
<queryset>

<fullquery name="deactivate_service">      
      <querytext>
       update jb_services SET active_check_p = 'f' where service = :service 
      </querytext>
</fullquery>

 
</queryset>
