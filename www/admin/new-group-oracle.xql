<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_conference_group">      
      <querytext>
	    declare 
	    id integer;
	    begin
	    id := acs_group.new(group_name => :group_name);
	    insert into jb_conference_groups (group_id) values (id);
	    end;	
      </querytext>
</fullquery>

</queryset>
