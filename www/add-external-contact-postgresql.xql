<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>


<fullquery name="get_services">      
      <querytext>
      Select service , pretty_name from jb_services where active_check_p = 't'
      </querytext>
</fullquery>


</queryset>
