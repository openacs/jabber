<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>



<fullquery name="new_conference_group">      
      <querytext>
      SELECT membership_rel__new(:group_id  , :user_id )
      </querytext>
</fullquery>
</queryset>
