<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="jb_screen_delete">      
      <querytext>
      
		begin
		jb_screen.delete(:user_screen_id);
		end;
	    
      </querytext>
</fullquery>

 
</queryset>
