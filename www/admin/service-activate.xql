<?xml version="1.0"?>
<queryset>

<fullquery name="activate_service">      
      <querytext>
       update jb_services SET active_check_p = 't' where service = :service 
      </querytext>
</fullquery>

 
</queryset>
