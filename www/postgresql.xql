<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>



<fullquery name="">      
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
