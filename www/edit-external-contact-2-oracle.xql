<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="jb_screen_delete">      
      <querytext>
	begin
        jb_screen.delete(:old_screen_id);
        end;
      </querytext>
</fullquery>


<fullquery name="new_screen">      
      <querytext>
		    declare
		    id integer;
		    begin
		    id := jb_screen.new (
					 user_id => :db_nulling,
					 im_screen_name => :new_screen,
					 service => :cur_service,
					 status => 'offline',
					 refcount => '1',
					 object_type => 'jb_screen',
					 creation_user => :user_id,
					 creation_ip => :peeraddr
					 );
		    end;

      </querytext>
</fullquery>
</queryset>
