<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>


<fullquery name="get_screen">      
      <querytext>
      select im_screen_name from jb_screens WHERE user_id = :user_id_friend and service = $trans_symbol	
      </querytext>
</fullquery>


</queryset>
