<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="new_conference_group_delete">      
      <querytext>
      

   Select  membership_rel__delete(:rel_id )

      </querytext>
</fullquery>

 
<fullquery name="new_conference_group_approve">      
      <querytext>
      
   Select  membership_rel__approve(:rel_id )

      </querytext>
</fullquery>

 
</queryset>
