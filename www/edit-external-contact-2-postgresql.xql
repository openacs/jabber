<?xml version="1.0"?>

<queryset>
      <rdbms><type>postgresql</type><version>7.1</version></rdbms>



<fullquery name="jb_screen_delete">      
      <querytext>
        SELECT  jb_screen__delete(:old_screen_id)
      </querytext>
</fullquery>


<fullquery name="new_screen">      
      <querytext>
       SELECT jb_screen__new (null , :db_nulling, :new_screen,
      :cur_service, 'offline', '' , '' , '1', 'jb_screen', null ,
      :user_id, :peeraddr , null)
      </querytext>
</fullquery>

</queryset>
