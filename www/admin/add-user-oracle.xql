<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_conference_group">      
      <querytext>
    declare 
   id integer;
   begin
   id := membership_rel.new(OBJECT_ID_ONE => :group_id  , OBJECT_ID_TWO => :user_id );
   end;
      </querytext>
</fullquery>

</queryset>
