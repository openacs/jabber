<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="get_services">      
      <querytext>
      Select service , pretty_name from jb_services where
      active_check_p = 't'	  
      </querytext>
</fullquery>


</queryset>
