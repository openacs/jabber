<?xml version="1.0"?>
<queryset>

<fullquery name="get_services">      
      <querytext>
       Select service , pretty_name from jb_services where service = :service 
      </querytext>
</fullquery>

 
<fullquery name="insert">      
      <querytext>
      insert into jb_services (service , pretty_name , active_check_p ) values ( :service , :pretty_name , 't')
      </querytext>
</fullquery>

 
</queryset>
