<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_conference_group_delete">      
      <querytext>
      
   begin
   membership_rel.delete(:rel_id );
   end;

      </querytext>
</fullquery>

 
<fullquery name="new_conference_group_approve">      
      <querytext>
      
   begin
   membership_rel.approve(:rel_id );
   end;

      </querytext>
</fullquery>

 
</queryset>
