<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="get_services">      
      <querytext>
      Select service from jb_services where active_check_p = 't'	
      </querytext>
</fullquery>



<fullquery name="new_screen">      
      <querytext>
	declare
		id integer;
		begin
		id := jb_screen.new(				    
				    im_screen_name => :user_screen_name,
				    service => :service,
				    status => 'offline',
				    refcount => '1',
				    object_type => 'jb_screen'
				    );
		end;
	   
      </querytext>
</fullquery>


<fullquery name="get_new_screen_id">      
      <querytext>
Select screen_id from jb_screens where im_screen_name = :user_screen_name and service = :service
      </querytext>
</fullquery>


<fullquery name="update_reference">      
      <querytext>
update jb_screens SET refcount = refcount + 1 where screen_id = :screen_id
      </querytext>
</fullquery>

<fullquery name="insert_into_friends">      
      <querytext>
      insert into jb_friends 
      (user_id, friend_screen_id, friend_first_name, friend_last_name)
      values (:user_id, :screen_id, :first_names, :last_name)
      </querytext>
</fullquery>


<fullquery name="check_screen_id">      
      <querytext>
       Select screen_id from jb_screens 
       where im_screen_name = :user_screen_name and service = :service
      </querytext>
</fullquery>



</queryset>
