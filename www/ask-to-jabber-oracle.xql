<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>



<fullquery name="get_name_to_notify">      
      <querytext>
      SELECT (sn.im_screen_name) as screen FROM jb_screens sn WHERE sn.user_id = :user_id_friend AND sn.service = :trans_symbol
      </querytext>
</fullquery>


<fullquery name="get_name">      
      <querytext>
      select first_names , last_name from persons where person_id =:user_id
      </querytext>
</fullquery>

<fullquery name="get_screens">      
      <querytext>
	Select (sn.im_screen_name) as screen, (sn.user_id) as cur from jb_screens sn WHERE  (sn.user_id = :user_id or sn.user_id = :user_id_friend) AND sn.service = 'jabber'
      </querytext>
</fullquery>



</queryset>
