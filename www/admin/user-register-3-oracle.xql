<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_screen">      
      <querytext>
      
	declare
	id integer;
	begin
	id := jb_screen.new (
			     user_id => :user_id,
			     im_screen_name => :jscreen,
			     service => 'jabber',
			     status => 'offline',
			     refcount => '1',
			     object_type => 'jb_screen'
			     );
	end;
    
      </querytext>
</fullquery>

 
</queryset>
