<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>



<fullquery name="new_conference_group">      
      <querytext>
      SELECT composition_rel__new(:group_id  ,  :new_group_id  )
      </querytext>
</fullquery>
</queryset>
