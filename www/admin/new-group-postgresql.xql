<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>



<fullquery name="new_conference_group">      
      <querytext>
        insert into jb_conference_groups (group_id) values (acs_group__new(:group_name))
     </querytext>
</fullquery>
</queryset>
