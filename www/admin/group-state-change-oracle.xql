<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_conference_group">      
      <querytext>
   begin
   composition_rel.delete(:rel_id );
   end;	
      </querytext>
</fullquery>

</queryset>
